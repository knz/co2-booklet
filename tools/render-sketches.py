#!/usr/bin/env python3
"""Rasterise the SVG sketches in visuals/ into visuals/render/.

There is no rsvg-convert or inkscape on the build machine, so Typst does
the rasterising: it renders SVG itself and is already a dependency.

Two outputs:

  visuals/render/<name>.png   each sketch on its own, for the image
                              generator (scenes) or for review (icons)
  visuals/render/contact-sheet.png
                              every icon at its true printed size next to a
                              magnified view. This is the check that matters
                              for icons: they fail at 7 mm, not on screen.

Usage: ./tools/render-sketches.py
"""

import pathlib
import re
import subprocess
import sys
import tempfile

PPI = 300
ROOT = pathlib.Path(__file__).resolve().parent.parent
VISUALS = ROOT / "visuals"
RENDER = VISUALS / "render"

# Target pixel width per sketch. Scenes go to the generator and want detail
# to work from; icons only need to be reviewable.
SCENE_WIDTH_PX = 1860
ICON_WIDTH_PX = 512

# An icon is drawn on the 48-unit canvas the style contract sets; anything
# on a larger canvas is a scene. Reading the file beats matching on the
# name, which needed editing every time a scene was added.
ICON_CANVAS = 48.0

# Printed sizes to show on the contact sheet, in mm.
CONTACT_SIZES = (7, 16, 40)


def mm(px: float) -> float:
    return px / PPI * 25.4


def typst(source: str, out: pathlib.Path, ppi: int = PPI) -> None:
    with tempfile.NamedTemporaryFile("w", suffix=".typ", dir=ROOT, delete=False) as fh:
        fh.write(source)
        tmp = pathlib.Path(fh.name)
    try:
        subprocess.run(
            ["typst", "compile", "--root", str(ROOT), "--ppi", str(ppi),
             str(tmp), str(out)],
            check=True,
        )
    finally:
        tmp.unlink(missing_ok=True)


def view_box(svg: pathlib.Path) -> tuple[float, float]:
    """The viewBox width and height."""
    text = svg.read_text()
    start = text.index("viewBox=") + len('viewBox="')
    _, _, w, h = text[start:text.index('"', start)].split()
    return float(w), float(h)


def is_icon(svg: pathlib.Path) -> bool:
    return view_box(svg)[0] == ICON_CANVAS


def label_of(svg: pathlib.Path) -> str:
    """What the contact sheet writes next to the icon. Numbered visuals go
    by their ID; the marks in visuals/marks/ have no ID, so they go by
    name."""
    if svg.parent.name == "marks":
        return svg.stem
    return svg.stem.split("-")[0].upper()


def sort_key(svg: pathlib.Path) -> tuple[int, str, int, str]:
    """Document order, with the unnumbered marks after the numbered
    visuals. IDs are not all a letter plus digits: a visual split across
    panels takes a suffix, as B1a and B1b do."""
    if svg.parent.name == "marks":
        return (1, svg.stem, 0, "")
    ident = svg.stem.split("-")[0].upper()
    m = re.match(r"([A-Z]+)(\d+)(.*)", ident)
    return (0,) + ((m[1], int(m[2]), m[3]) if m else (ident, 0, ""))


def rel(svg: pathlib.Path) -> str:
    """Path as the Typst snippets below have to spell it."""
    return f"/visuals/{svg.relative_to(VISUALS).as_posix()}"


def render_one(svg: pathlib.Path) -> None:
    width_px = ICON_WIDTH_PX if is_icon(svg) else SCENE_WIDTH_PX
    vb_w, vb_h = view_box(svg)
    w = mm(width_px)
    h = w / (vb_w / vb_h)
    out = RENDER / f"{svg.stem}.png"
    typst(
        f'#set page(width: {w}mm, height: {h}mm, margin: 0pt, fill: white)\n'
        f'#image("{rel(svg)}", width: 100%, height: 100%)\n',
        out,
    )
    print(f"  {out.relative_to(ROOT)}  ({width_px}px wide)")


def contact_sheet(icons: list[pathlib.Path]) -> None:
    rows = []
    for svg in icons:
        cells = "".join(
            f'box(width: {s}mm, height: {s}mm, image("{rel(svg)}", width: 100%)), '
            for s in CONTACT_SIZES
        )
        rows.append(f'text(weight: "bold", size: 8pt)[{label_of(svg)}], {cells}')
    body = "\n  ".join(rows)
    labels = ", ".join(f'text(size: 7pt, fill: gray)[{s} mm]' for s in CONTACT_SIZES)
    out = RENDER / "contact-sheet.png"
    typst(
        f'#set page(width: 120mm, height: auto, margin: 8mm, fill: white)\n'
        f'#set text(font: "Noto Sans")\n'
        f'#grid(\n'
        f'  columns: (14mm, {", ".join(f"{s + 6}mm" for s in CONTACT_SIZES)}),\n'
        f'  column-gutter: 4mm, row-gutter: 5mm, align: horizon,\n'
        f'  [], {labels},\n'
        f'  {body}\n'
        f')\n',
        out,
    )
    print(f"  {out.relative_to(ROOT)}")


def main() -> int:
    svgs = sorted(
        list(VISUALS.glob("*.svg")) + list(VISUALS.glob("marks/*.svg")),
        key=sort_key,
    )
    if not svgs:
        print("no SVG sketches in visuals/", file=sys.stderr)
        return 1
    RENDER.mkdir(parents=True, exist_ok=True)
    print("Rendering sketches:")
    for svg in svgs:
        render_one(svg)
    contact_sheet([s for s in svgs if is_icon(s)])
    return 0


if __name__ == "__main__":
    sys.exit(main())

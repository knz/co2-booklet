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


def aspect(svg: pathlib.Path) -> float:
    """width / height, read from the viewBox."""
    text = svg.read_text()
    start = text.index("viewBox=") + len('viewBox="')
    _, _, w, h = text[start:text.index('"', start)].split()
    return float(w) / float(h)


def render_one(svg: pathlib.Path) -> None:
    is_scene = svg.stem.startswith(("i1-", "i2-"))
    width_px = SCENE_WIDTH_PX if is_scene else ICON_WIDTH_PX
    w = mm(width_px)
    h = w / aspect(svg)
    out = RENDER / f"{svg.stem}.png"
    typst(
        f'#set page(width: {w}mm, height: {h}mm, margin: 0pt, fill: white)\n'
        f'#image("/visuals/{svg.name}", width: 100%, height: 100%)\n',
        out,
    )
    print(f"  {out.relative_to(ROOT)}  ({width_px}px wide)")


def contact_sheet(icons: list[pathlib.Path]) -> None:
    rows = []
    for svg in icons:
        cells = "".join(
            f'box(width: {s}mm, height: {s}mm, image("/visuals/{svg.name}", width: 100%)), '
            for s in CONTACT_SIZES
        )
        ident = svg.stem.split("-")[0].upper()
        rows.append(f'text(weight: "bold", size: 8pt)[{ident}], {cells}')
    body = "\n  ".join(rows)
    labels = ", ".join(f'text(size: 7pt, fill: gray)[{s} mm]' for s in CONTACT_SIZES)
    out = RENDER / "contact-sheet.png"
    typst(
        f'#set page(width: 120mm, height: auto, margin: 8mm, fill: white)\n'
        f'#set text(font: "Noto Sans")\n'
        f'#grid(\n'
        f'  columns: (8mm, {", ".join(f"{s + 6}mm" for s in CONTACT_SIZES)}),\n'
        f'  column-gutter: 4mm, row-gutter: 5mm, align: horizon,\n'
        f'  [], {labels},\n'
        f'  {body}\n'
        f')\n',
        out,
    )
    print(f"  {out.relative_to(ROOT)}")


def main() -> int:
    svgs = sorted(VISUALS.glob("*.svg"), key=lambda p: int(p.stem[1:].split("-")[0]))
    if not svgs:
        print("no SVG sketches in visuals/", file=sys.stderr)
        return 1
    RENDER.mkdir(parents=True, exist_ok=True)
    print("Rendering sketches:")
    for svg in svgs:
        render_one(svg)
    contact_sheet([s for s in svgs if not s.stem.startswith(("i1-", "i2-"))])
    return 0


if __name__ == "__main__":
    sys.exit(main())

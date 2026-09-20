#!/usr/bin/env python3
"""Write visuals/manifest.json: which asset, if any, each visual ID has.

Typst cannot test whether a file exists, so it cannot fall back from an
asset to a placeholder box on its own. This script does the looking and
leaves Typst a plain mapping to read.

Lookup order per ID:

  visuals/generated/<ID>*.png    what came back from the image generator
  visuals/generated/<ID>*.webp   (also .jpg / .jpeg)
  visuals/<file>.svg             the hand-authored sketch

The ID is the leading token of the file name, so `i1.jpeg`,
`i1-revised.jpeg` and `I1-v3.png` all belong to I1. When a visual has
several candidates -- which it will, once a revision pass has been run --
the most recently modified one wins, and the others are listed so the
choice is visible rather than silent.

An ID with no asset is left out of the manifest, and keeps its hatched
placeholder box in the document.

Run by build.sh. The manifest is committed, so a plain `typst compile`
works too.

Usage: ./tools/scan-visuals.py
"""

import json
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
VISUALS = ROOT / "visuals"
GENERATED = VISUALS / "generated"


def ident_of(path: pathlib.Path) -> str:
    """The visual ID a file belongs to: the leading token of its name,
    written the way the documents write it -- letters and digits upper
    case, any panel suffix lower case, so `b1a-classroom.svg` is B1a and
    `i10-hrv.svg` is I10. The documents look the ID up as a literal
    string, so this has to match them exactly."""
    token = path.stem.split("-")[0]
    m = re.match(r"([A-Za-z]+)(\d+)(.*)", token)
    return f"{m[1].upper()}{m[2]}{m[3].lower()}" if m else token.upper()


def sort_key(ident: str) -> tuple[str, int, str]:
    """Document order for an ID. Not all IDs are a letter plus digits:
    a visual split across panels takes a suffix, as B1a and B1b do."""
    m = re.match(r"([A-Z]+)(\d+)(.*)", ident)
    return (m[1], int(m[2]), m[3]) if m else (ident, 0, "")


def main() -> int:
    manifest: dict[str, str] = {}

    for svg in VISUALS.glob("*.svg"):
        manifest[ident_of(svg)] = f"/visuals/{svg.name}"

    # A generated image wins over the sketch it was made from.
    candidates: dict[str, list[pathlib.Path]] = {}
    for ext in ("png", "webp", "jpg", "jpeg"):
        for img in GENERATED.glob(f"*.{ext}"):
            candidates.setdefault(ident_of(img), []).append(img)

    superseded: dict[str, list[str]] = {}
    for ident, imgs in candidates.items():
        imgs.sort(key=lambda p: p.stat().st_mtime, reverse=True)
        manifest[ident] = f"/visuals/generated/{imgs[0].name}"
        if len(imgs) > 1:
            superseded[ident] = [p.name for p in imgs[1:]]

    ordered = dict(sorted(manifest.items(), key=lambda kv: sort_key(kv[0])))
    out = VISUALS / "manifest.json"
    out.write_text(json.dumps(ordered, indent=2) + "\n")

    print(f"visuals: {len(ordered)} asset(s) -> {out.relative_to(ROOT)}")
    for ident, path in ordered.items():
        print(f"  {ident}: {path}")
        for name in superseded.get(ident, ()):
            print(f"      (newer than {name})")
    return 0


if __name__ == "__main__":
    sys.exit(main())

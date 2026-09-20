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
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
VISUALS = ROOT / "visuals"
GENERATED = VISUALS / "generated"


def ident_of(path: pathlib.Path) -> str:
    """The visual ID a file belongs to: the leading token of its name."""
    return path.stem.split("-")[0].upper()


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

    ordered = dict(sorted(manifest.items(), key=lambda kv: int(kv[0][1:])))
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

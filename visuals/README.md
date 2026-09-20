# Visual sketches for the infographic

Hand-authored SVG sketches for the infographic visuals I1–I10. They serve
two different purposes, and it matters which:

- **I3–I10 (icons) are the final assets.** They are placed as vector SVG in
  the document. No image generator touches them.
- **I1 and I2 (scenes) are input for an image generator.** The SVG fixes
  the composition, proportions and palette; a generator is then asked to
  "improve" the render into a finished flat illustration. The result lands
  in `generated/` as raster and is what the document places.

Rationale for the split is in `changelog/20260920-image-sketches.md`.

## Style contract

Every file follows this, so that ten separately drawn images read as one
set. Departing from it is what makes a set look assembled from stock.

| | |
|---|---|
| Icon canvas | `viewBox="0 0 48 48"`, drawing kept inside 4–44 |
| Scene canvas | `viewBox="0 0 620 280"` (the 62 × 28 mm slots, ×10) |
| Outline stroke | `#1d2a33` (ink), width 2.8 on icons, 3 on scenes |
| Detail stroke | `#1f6f8b` (accent), width 2.2–2.6 on icons |
| Fill | `#e4f0f3` (accent-soft) for bodies, `#ffffff` for highlights |
| Caps / joins | `round` everywhere |
| Corners | `rx` 2–6 on icons, 3–12 on scenes. No hard 90° corners |
| Gradients | none |
| Perspective | none. Flat elevation or flat profile only |

Colours are the literals from `shared/style.typ`. Two further colours
appear in scenes only: `#c9d3d8` (rule) for floors and inert surfaces, and
`#5b6770` (muted) for the mould stain in I1.

**Icons are monochrome-accent.** Ink outline, accent detail, accent-soft
fill — nothing else. The ✓ / ✗ in the layout carries whether an item helps,
so the icon must not also try to carry it through colour; a green plant
next to a ✗ reads as a contradiction, and green and red are already spoken
for by the CO₂ colour bands.

One deliberate exception: **I10** uses `#f0c233` (band yellow) for the
retained heat. Warmth does not read without a warm colour, and the icon is
meaningless without that contrast.

## Renderer constraints

There is no `rsvg-convert` or `inkscape` on the build machine. Typst 0.15
renders SVG itself (usvg), and is used both to place the icons in the
document and to rasterise the sketches for the generator. So the SVG must
stay inside what usvg supports:

- presentation attributes only — **no `<style>` blocks, no CSS classes**
- no filters, no masks, no gradients
- **no `<text>`** — text would depend on a font being present at render
  time. Anything that has to read as a word is drawn as shapes, or is left
  to the document text next to the image.

## Files

| File | ID | Placed at |
|---|---|---|
| `i1-bedroom.svg` | I1 | 62 × 28 mm (generator input) |
| `i2-breath-meter.svg` | I2 | 62 × 28 mm (generator input) |
| `i3-grille.svg` | I3 | 7 mm, or 16 mm in the large-icon variant |
| `i4-window-ajar.svg` | I4 | idem |
| `i5-mech-vent.svg` | I5 | idem |
| `i6-plant.svg` | I6 | idem |
| `i7-purifier.svg` | I7 | idem |
| `i8-aircon.svg` | I8 | idem |
| `i9-airing-clock.svg` | I9 | idem |
| `i10-hrv.svg` | I10 | idem |

`render/` holds the rasterised sketches (generated, git-ignored).
`generated/` holds what comes back from the image generator.
`manifest.json` records which IDs have an asset; see below.

## Pipeline

```
./tools/render-sketches.py      # SVG -> visuals/render/*.png + contact-sheet.png
```

Then, for I1 and I2 only: open `visuals/render/i1-bedroom.png` in a chat
image editor, paste the prompt from `visuals/prompts/i1.md` (which already
includes the shared preamble), and save the result as
`visuals/generated/I1.png`. Same for I2.

`visuals/render/contact-sheet.png` shows every icon at its true printed
size next to a magnified view. It is the check for whether an icon still
reads at 7 mm — that is where icon sketches fail, not on screen.

## manifest.json

Typst cannot test whether a file exists, so `tools/scan-visuals.py` writes
`visuals/manifest.json` mapping each visual ID to the asset to place.
`build.sh` regenerates it before compiling. The file is committed, so a
plain `typst compile` also works. An ID that is absent from the manifest
keeps its hatched placeholder box in the document.

Lookup order per ID: anything in `generated/` beats the sketch, and the
sketch beats nothing. A file belongs to the ID that is the leading token of
its name, so `i1.jpeg`, `i1-revised.jpeg` and `I1-v3.png` are all I1.
When an ID has several candidates, the most recently modified one wins and
the script lists the ones it passed over, so the choice is visible.

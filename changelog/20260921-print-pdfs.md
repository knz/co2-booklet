# Print-ready PDFs (infographic duplex, booklet imposition)

## Task specification

User request (2026-09-21):

- Also emit a PDF for the infographic with both pages in one document
  (the A5 sheet: Dutch on one side, English on the other).
- Also emit a PDF for the booklet such that, printed double-sided, the
  stack folds into a booklet (imposition of the 8 A5 pages onto A4 sheets).

## Current state (found)

- `build.sh` compiles per language: `build/infographic-{en,nl}.pdf` (1 A5
  page each) and `build/booklet-{en,nl}.pdf` (8 A5 pages, reading order).
- CI (`.github/workflows/pages.yml`) installs only Typst 0.15.1, poppler-utils
  and Python; no TeX, so `pdfjam`/`pdfbook2` are available locally but not in CI.
- Typst can place pages of an existing PDF as images (`image(..., page: n)`),
  which would keep the imposition vector and inside the existing toolchain.

## Requirements (clarified with user)

- Booklet: A4 landscape, 2-up, duplex with short-edge flip (one variant).
- Infographic: both A5 sides next to each other on a single A4 landscape
  page (NL left, EN right), not a 2-page duplex file.
- Outputs go to `build/` only; landing page unchanged.
- Made with Typst from the built PDFs.

## Decisions

- Imposition in Typst (`image(pdf, page: n)`) rather than pdfjam: stays
  vector and needs no TeX, so it also runs in CI.
- Sheet order 8|1, 2|7 / 6|3, 4|5 (standard 2-sheet saddle stitch). No creep
  compensation: negligible for 2 sheets.
- A5 pages sit against the fold line; the 0.5 mm spare of A4 goes to the
  outer edges.
- Print PDFs inherit the `DRAFT` setting of the build; no bleed or crop marks.

## Files modified

- `changelog/20260921-print-pdfs.md` — this file.
- `print/impose.typ` — new; imposition layout, driven by `--input`.
- `build.sh` — compiles `build/booklet-print-<lang>.pdf` (4 pages checked)
  and, with both languages, `build/infographic-a4.pdf` (1 page checked).
- `README.md` — build outputs and printing note; file table row.

## Obstacles and solutions

- Grid parameters named `left`/`right` shadowed Typst's alignment values;
  renamed to `l`/`r`.

## Status

Done. Built and checked visually at low resolution (page order and placement).
Not yet test-printed on paper.

## CI failure after push (2026-09-21)

- The GitHub Pages build for commit `dcb6423` failed with
  `input file not found (searched at print/impose.typ)`: that commit included
  the `build.sh` change but not the untracked `print/` directory. Fix: commit
  `print/impose.typ`. The `Syntax Error: Suspects object is wrong type` lines
  in the log come from `pdfinfo` and did not stop the build.

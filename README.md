# CO₂ in Diemen homes — infographic and booklet

*CO₂ in huis: meten, begrijpen, ventileren*

This repository holds the source for public information material about
indoor CO₂ in homes in Diemen: why CO₂ builds up, what it does to the
people living there, how to measure it, and what does and does not help.

Published site: https://knz.github.io/co2-booklet/

## Background

A council fraction in Diemen is bringing a motion to the city council to:

- raise awareness about CO₂ build-up in homes, and
- start a programme where residents can temporarily borrow a CO₂ meter to
  see how CO₂ builds up in their own home (for example overnight in a
  bedroom).

The material in this repository supports that motion and the lending
programme. It is published by the council fraction, not by the
municipality. The fraction is not named in the material.

## Audience

- The median Diemen resident, regardless of education level.
- Immigrants and other residents who read English more easily than Dutch.
- People who have borrowed a meter and want to understand what it shows.

Proposed (not yet decided): write the Dutch text at language level B1, the
plain-language level commonly used by Dutch government communication, and
keep the English text equally plain.

## Deliverables

1. **Infographic** — one A5 sheet, Dutch on one side and English on the
   other. It gives the core message at a glance and carries a QR code that
   links to the landing page.
2. **Booklet** — at most 4 A4 pages of content, printed as 8 A5 pages. Dutch
   and English versions. It explains the topics in more depth and gives
   evidence and links to sources.
3. **Landing page** — https://knz.github.io/co2-booklet/, the target of the
   QR code. The visitor chooses Dutch or English, then sees the infographic
   in that language as an inline image, with links to the PDFs underneath.

## Content scope

Seed topics, from `input.txt`:

- **Exposure levels:** short-term vs. longer exposure (e.g. several hours
  overnight); thresholds such as ~1,000 ppm and 5,000+ ppm; limits used in
  other countries.
- **Effects:** reported symptoms of exposure over several hours (headaches,
  brain fog, reduced concentration, poorer sleep) and possible indirect
  effects (mood, household tension). The strength of evidence per effect is
  still to be checked — see *Open decisions*.
- **Why now:** stuffy winter classrooms are a familiar experience; homes
  were often drafty enough to avoid the problem, but better insulation
  changes that. Rooms without windows or ventilation openings have always
  been affected.
- **Measuring:** NDIR sensors vs. meters that estimate CO₂ from VOCs; where
  to place a sensor in a room; using the meter's history to follow CO₂
  through a night. This ties directly into the lending programme.
- **Ventilation trade-offs:** opening windows for CO₂ vs. effects on
  humidity (and heat loss).
- **What does not work:** plants, airing out once in the morning or evening,
  air conditioning, air purifiers.
- **Related but separate issues:** VOCs (mainly kitchens; activated carbon
  filters do not remove CO₂) and CO (acutely toxic, rare; CO alarms do not
  detect CO₂).
- **Myths:** "CO₂ is harmless", "I don't feel anything", "my old house is
  drafty so I'm fine", "plants help a little", "an air purifier with a CO₂
  sensor is enough".

## Editorial principles

- **Every factual claim has a checkable source.** Numbers, thresholds and
  health effects link to a source in the shared reference list.
- **Persuasive tone is allowed, but wording stays within what the source
  supports.** If findings are mixed, the text must not present them as
  settled.
- **Practical over technical.** Each section should lead to something a
  resident can do or check with the borrowed meter.
- **One set of shared facts.** CO₂ thresholds, colour bands and key figures
  are defined once and reused by the infographic and the booklet, so the two
  cannot drift apart.
- **No party branding.** The council fraction behind the motion is not named
  in the infographic, booklet or landing page.

## Toolchain

- Infographic and booklet are written and laid out in
  [Typst](https://typst.app/), kept as text files in this repository, and
  compiled to PDF (for print and download) and to an image of each
  infographic side (for the landing page).
- The landing page is a static HTML page in `site/`, written by hand: no
  framework, no build step and no third-party request at run time. Tailwind
  and daisyUI were considered and dropped (decision 2026-09-16): the page is
  one screen of content and is the target of a printed QR code, so it has to
  load fast on mobile data and keep working for years without a dependency
  going stale.
- A GitHub Actions workflow (`.github/workflows/pages.yml`) compiles the
  Typst sources, assembles `site/` and deploys it to GitHub Pages on every
  push to `master`. One-time set-up and URL stability notes: see
  [PUBLISHING.md](PUBLISHING.md).

Building locally (Typst 0.15, `pdfinfo` from poppler-utils):

```
./build.sh                 # draft mode: TBD highlights and cut candidates
DRAFT=false ./build.sh     # without draft markers
BANDS=B ./build.sh         # colour-band option B (script.md §1)
LANGS="nl" ./build.sh      # one language only
TAGS=true ./build.sh       # show the (advice)/(calc)/(inference)/(assumption) tags
ICONS=rows ./build.sh      # infographic block 4 as icon + text on one line
```

Output per language: `build/booklet-<lang>.pdf`,
`build/infographic-<lang>.pdf` and `build/infographic-<lang>.png`. The
script reports how many PDF pages each script page uses (overflow) and
lists the visual placeholders to commission. It exits non-zero when a
document runs over its page budget, which is what makes the deploy fail
rather than publish a document that no longer fits its print format.

When both languages are built, `build.sh` finishes by running
`tools/build-site.py`, which fills `site/assets/` (infographic as lossless
WebP, plus the four PDFs) and generates `site/sources.html` from
`sources/references.yml`. Open `site/index.html` in a browser to preview.

Prototype conventions:

- Each document is split into a layout file and one text file per language,
  so Dutch and English keep the same structure and cannot drift apart. Only
  the words live in `text-en.typ` / `text-nl.typ`.
- Dutch is written at roughly B1 and uses "je". Numbers follow the language:
  `1,200 ppm` in English, `1.200 ppm` in Dutch.
- Visuals carry an ID (I1–I10 on the infographic, B1–B3 in the booklet). An
  ID with an asset in `visuals/` is drawn; one without keeps a hatched
  placeholder box with its brief, and `build.sh` lists what is still open.
  The briefs stay English in both languages: they are production notes.
- The infographic visuals are sketched as SVG in `visuals/`, in one shared
  style contract (`visuals/README.md`). The eight icons are the final
  assets and stay vector. The two scenes, I1 and I2, are input for an image
  generator: the SVG fixes the composition and palette, a generator is
  asked to improve the render, and the result goes in `visuals/generated/`
  as raster, where it takes precedence over the sketch.
- Block 4 of the infographic has two layouts: `large` (default since
  2026-09-20, a 13 mm icon above the label) and `rows` (`ICONS=rows`, the
  earlier icon-and-text-on-one-line layout, kept for comparison). Both fit
  one A5 page in both languages; in `large` the Dutch heat-recovery label
  runs to four lines, which is the tightest spot on the sheet.
- The provenance tags "(advice)", "(calc)", "(inference)" and
  "(assumption)" are hidden by default; `TAGS=true` shows them for review.
  The TBD highlight and CUT CANDIDATE tag still follow draft mode, and all
  of these stay English: they are production notes.
- Citations in the booklet are numbered in order of first appearance, one
  number per source, reused when the source is cited again. The numbered
  list of all sources is printed at the end of the booklet. The
  infographic has no citations.
- Numbers from the shared facts table come from `shared/facts.typ`.

Open choices:

- Shorter block-4 labels. The `large` layout works with the current
  wording, but the Dutch heat-recovery label runs to four lines and leaves
  no slack above the footer rule.
- QR code generation: the prototype uses the Typst package `tiaoma` 0.3.0
  (downloaded on first build). To confirm.
- Font for the printed documents: Noto Sans in the prototype, provisional.
  (The landing page is settled: Fira Sans, self-hosted.)

Settled on 2026-09-16:

- Image format for the infographic on the landing page: **lossless WebP**
  at the native pixel size. Measured on this material, lossy WebP is both
  larger (q82: 144 kB against 126 kB) and rings around the text, and
  downscaling first makes the lossless file bigger, not smaller.
- Typst version pinned in the workflow: 0.15.1.

## Repository layout

Current:

| Path | Purpose |
|------|---------|
| `input.txt` | Seed input: topics, symptoms, ineffective measures, myths. |
| `script-sketch.md` | First script drafted by another agent. Reference only, see below. |
| `input2.txt` | Second input: core messages and revised direction for the script. |
| `script.md` | Working script (draft 2) for the infographic and booklet, with shared facts and source tags. |
| `site/index.html` | Landing page: language gate, then the infographic and the downloads per language. |
| `site/style.css`, `site/app.js` | Hand-written styles and the language choice. No framework. |
| `site/favicon.svg`, `site/fonts/` | Icon, and the Fira Sans subsets (SIL OFL, see `site/fonts/OFL.txt`). |
| `tools/build-site.py` | Fills `site/assets/` and generates `site/sources.html`. Run by `build.sh` and by the workflow. |
| `visuals/` | SVG sketches for the infographic visuals, the style contract they share, and the image-generator prompts for I1 and I2. |
| `visuals/manifest.json` | Which asset each visual ID has. Written by `tools/scan-visuals.py`; Typst cannot test for a file itself. |
| `tools/render-sketches.py` | Rasterises the sketches into `visuals/render/`, plus a contact sheet of the icons at true printed size. |
| `tools/scan-visuals.py` | Writes `visuals/manifest.json`. Run by `build.sh`. |
| `.github/workflows/pages.yml` | Builds and deploys the site. |
| `PUBLISHING.md` | GitHub Pages set-up and maintenance. |
| `changelog/` | Per-task notes on specifications, decisions and progress. |
| `CLAUDE.md` | Working rules for agent sessions in this repository. |
| `infographic/infographic.typ` | Layout of the A5 infographic; `text-en.typ` and `text-nl.typ` hold the words, `infographic-en.typ` and `infographic-nl.typ` are the entry points. |
| `booklet/booklet.typ` | Layout of the booklet (8 A5 pages in reading order); `text-en.typ` and `text-nl.typ` hold the words, `booklet-en.typ` and `booklet-nl.typ` are the entry points. |
| `shared/facts.typ` | Shared facts F1–F15 from `script.md` (thresholds, figures, colour bands). |
| `shared/style.typ` | Page setup, styles, placeholders, draft markers, citation helper. |
| `shared/diagrams.typ` | Data diagrams drawn from the shared facts (colour-band scale, level scale). |
| `sources/references.yml` | Reference list (Hayagriva YAML) for all cited sources. |
| `build.sh` | Local build into `build/` (ignored by git). |

Generated, and git-ignored: `build/`, `site/assets/`, `site/sources.html`
and `visuals/render/`. Nothing built is committed, except
`visuals/manifest.json`, which is committed so that a plain `typst compile`
works without running `build.sh` first.

## About `script-sketch.md`

The sketch is useful as a list of possible sections and visuals, but it is
not a basis for content as-is:

- It is structured for 16–24 pages; the booklet limit is 4 A4 pages.
- Several figures have no traceable source, e.g. "40% of Dutch bedrooms
  exceed 1,400 ppm (RIVM, 2023)" and "decision-making drops 15% at 1,000 ppm
  and 50% at 2,500 ppm (Harvard)". The latter may come from a different study
  than the one named; to check.
- Its plant figure (~1,000 plants for a 20 m² bedroom) does not match
  `input.txt` (~100 plants for a 10 m² room).
- The two "case studies" appear to be invented and cannot be presented as
  real households.
- The meter comparison table appears to contain errors (e.g. Nest Protect is
  a smoke/CO alarm, not a CO₂ meter).
- Its norms table, subsidy amounts and prices are unverified.

Any figure taken from the sketch must be confirmed against a primary source
or dropped.

## Decisions so far

- Dutch and English versions of all deliverables.
- Print format A5: infographic as one sheet with a language per side;
  booklet max 4 A4 pages, printed as 8 A5 pages.
- QR code points to the landing page, not directly to a PDF.
- Hosting on GitHub Pages at the default `github.io` address; no custom
  domain for now.
- Build and deploy through GitHub Actions; no built files committed.

## Open decisions and status

Status: script draft 2 in `script.md`; English Typst prototypes of the
infographic and booklet with visual placeholders. The booklet prototype
fits 8 A5 pages: script pages 2 and 3 share a page, and the numbered
reference list fills the last one and a half pages (see
`changelog/20260916-prototype-docs.md`). Placeholder site and deploy
workflow in place.

Open:

- Literature check on health effects. Findings on cognitive effects at
  roughly 1,000–2,500 ppm appear to be mixed across studies; the wording in
  `input.txt` is firmer than that. The outcome determines how the effects
  are phrased.
- Which Dutch guidelines and regulations to cite for ventilation and CO₂
  levels, and which foreign limits to mention.
- Which meter model(s) the lending programme uses; the measuring section
  should match them.
- Fitting the booklet content into 4 A4 pages (8 A5 pages).

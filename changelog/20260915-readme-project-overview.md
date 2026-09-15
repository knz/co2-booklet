# 2026-09-15 — README and CLAUDE.md project overview

## Task Specification

Project context (from user):
- A motion at the city council to raise awareness about CO₂ in Dutch homes,
  plus a programme where residents can temporarily borrow a CO₂ meter to
  learn about CO₂ build-up.
- Deliverables of the overall project:
  1. A 1-page infographic understandable by the median Dutch resident
     (any education level) and by immigrants; Dutch and English versions.
  2. A short booklet (max 5 pages) with more explanation, evidence and links,
     published online.
  3. A QR code on the infographic pointing to the online booklet.
- Inputs: `input.txt` (seed topics and myths), `script-sketch.md` (first
  script drafted by another agent; likely not reused as-is).

This task (first task): create `README.md` outlining the project, and fill in
the "Project Overview" section of `CLAUDE.md`.

## High-Level Decisions

User answers to clarifying questions (2026-09-15):
- Publisher: the council fraction/party behind the motion (not the
  municipality). Municipality: Diemen. Party name not given yet.
- Evidence/tone: claims must be sourced, but a persuasive tone is allowed.
- Toolchain: text-based; user confirmed Typst for formatting the documents.
- Hosting: own site / GitHub Pages.

## Requirements Changes

Follow-up answers to open items (2026-09-15):
- The council fraction was named by the user; it must NOT be named in the
  materials, nor in the public repo docs (README, CLAUDE.md, changelog).
- Booklet gets an English version: yes (both deliverables are NL + EN).
- Print format: A5 for both deliverables. The booklet's "max 5 pages" limit
  is meant in A4 terms, so roughly 10 A5 pages.
- GitHub repository: https://github.com/knz/co2-booklet
- New request: provide steps to set up GitHub Pages.
- Pages build: GitHub Actions compiles Typst and deploys (no built files in
  git).
- Pages set-up steps go in a separate file linked from the README.

Plan approval round 2 (2026-09-15), with choices:
- Workflow option B: create the Pages workflow now, deploying a placeholder
  page, so the site can go live before Typst sources exist.
- Keep branch `master`.
- QR code points to a landing page: the visitor chooses NL or EN, then sees
  the infographic in that language as an inline image, with links to the
  PDFs underneath.
- Infographic: A5 sheet, one language per side (NL on one side, EN on the
  other).
- Booklet limit changed: 4 A4 pages (was max 5), i.e. 8 A5 pages printed.
- No custom domain for now.
- Landing page: use the `frontend-design` skill when it is built (user
  instruction, 2026-09-15). Tailwind CSS and daisyUI widgets are accepted.

## Files Modified

- `changelog/20260915-readme-project-overview.md` — created (this file)
- `README.md` — created: background, audience, deliverables, content scope,
  editorial principles, Typst toolchain, current and proposed repo layout,
  assessment of `script-sketch.md`, open decisions.
- `CLAUDE.md` — "Project Overview" section filled in (purpose, deliverables,
  audience, toolchain, content rules, key files); rest unchanged.
- Round 2:
  - `PUBLISHING.md` — created: one-time GitHub Pages set-up (remote, push,
    enable Pages with Actions source, run/re-run workflow, check result,
    environment branch rule), day-to-day updates, QR/URL stability.
  - `.github/workflows/pages.yml` — created: build job uploads `site/` as
    Pages artifact, deploy job deploys it; triggers on push to `master` and
    manual dispatch.
  - `site/index.html` — created: bilingual placeholder page.
  - `README.md` — updated: A5 formats, 4 A4-page booklet, landing page,
    Actions deploy, decisions list, new layout entries, no party branding.
  - `CLAUDE.md` — Project Overview updated with the same decisions, a rule
    never to name the party/fraction anywhere in the public repo, the
    frontend-design skill for the landing page, and new key files.

## Rationales and Alternatives

- Plan approved by user ("yes") on 2026-09-15.
- README in English, since it is a working document; the material itself is
  NL + EN.
- Repo layout only proposed, not created: this task is limited to README and
  CLAUDE.md, and the structure should follow the first Typst work.
- B1 language level listed as a proposal, not a decision.
- Typst HTML export and QR package choice left open: state of Typst HTML
  export not checked in this session.
- Fraction name left as an open item rather than a placeholder in text.
  (Superseded: user asked not to name the fraction in materials or public
  repo docs; name removed from the changelog.)
- Round 2 approved by user with choices (workflow option B, `master`).
- Workflow uses the latest action releases as of 2026-09-15
  (checkout v7, upload-pages-artifact v5, deploy-pages v5). Release notes
  checked for v5 of both Pages actions: no usage changes. checkout v7 not
  checked in detail; the first run will show whether it works.
- `actions/configure-pages` omitted: not needed for a plain static
  directory, fewer unverified pieces. Can be added if the deploy needs it.
- Two jobs (build, deploy) so Typst build steps slot into the build job
  later without touching deployment permissions.
- Enabling Pages documented via the web UI; the REST alternative was not
  included because the docs summary listed `source` as required and that
  was not verified for the `workflow` build type.
- Site directory named `site/` (not `docs/`) to avoid suggesting the
  branch-folder publishing mode.

## Obstacles and Solutions

- `gh api` could not reach api.github.com once while reading action READMEs;
  used WebFetch on raw.githubusercontent.com and release pages instead.

## Observations on inputs (to carry into README as open issues, pending approval)

Noted while reading the inputs; none of this is verified against literature
yet — these are items to check, not conclusions.

- `script-sketch.md` is structured for a 16–24 page booklet with 9 sections;
  the target is max 5 pages, so it needs heavy cutting regardless.
- Several figures in the sketch have no traceable citation and need checking
  before any use, e.g. "40% of Dutch bedrooms exceed 1,400 ppm (RIVM, 2023)",
  "decision-making drops 15% at 1,000 ppm / 50% at 2,500 ppm (Harvard)" (these
  numbers look closer to Satish et al. 2012 than to a Harvard study, to be
  checked), Gezondheidsraad/WHO/Arbowet thresholds in its norms table, subsidy
  amounts, product prices.
- Internal inconsistency: plants ~100 per 10 m² room (`input.txt`) vs ~1,000
  per 20 m² bedroom (sketch).
- The two "case studies" in the sketch read as invented and cannot be
  presented as real households.
- The meter comparison table appears to contain errors (e.g. Nest Protect is
  a smoke/CO alarm, not a CO₂ meter; Awair Element is listed as VOC-based
  but, as far as I know, has an NDIR CO₂ sensor) — to verify.
- Tone of the sketch is alarmist ("invisible thief", "lies you believe"),
  which may not suit council-backed material.
- Evidence strength for cognitive and mood effects at ~1,000–2,500 ppm in
  homes appears mixed across studies (some find effects, some replications
  with pure CO₂ do not); `input.txt` states some of these effects firmly.
  Needs a literature pass before wording is fixed.
- `input.txt~` is an editor backup file, untracked.

## Current Status

- Round 1 done: `README.md` and `CLAUDE.md` Project Overview written.
- Round 2 done: open items resolved, `PUBLISHING.md`, Pages workflow and
  placeholder site created; README and CLAUDE.md updated.
- Not verified: the workflow has not run yet (no remote, nothing pushed).
  It will be tested when the user follows `PUBLISHING.md`.
- Possible next steps (user to choose): follow `PUBLISHING.md` and confirm
  the site goes live; literature check on health effects and thresholds;
  Typst skeleton with shared definitions and QR code; infographic message
  and structure; landing page (with frontend-design skill).

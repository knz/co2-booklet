// Booklet layout (8 A5 pages in reading order). The words live in
// text-en.typ and text-nl.typ; this file holds the structure, so both
// languages keep the same pages, order, boxes and tables.
//
// Citations: the text files call #src("key") with keys from
// sources/references.yml. Numbers are assigned in order of first
// appearance and printed as a list at the end.
//
// Visual briefs stay English in both languages: they are production notes
// for the illustrator, not reader text.

#import "/shared/facts.typ" as f
#import "/shared/style.typ": *
#import "/shared/diagrams.typ": band-scale, level-scale, night-graph
#import "@preview/tiaoma:0.3.0": qrcode

#let render(t) = {
  show: setup.with(title: t.title-plain, lang: t.lang)
  set page(footer: context {
    let n = counter(page).get().first()
    if n > 1 { align(center, text(size: 7pt, fill: muted, str(n))) }
  })

  // =====================================================================
  // Page 1 — Cover and introduction
  script-page(1)

  block(below: 4mm)[
    #text(size: 22pt, weight: "bold", fill: accent, t.title)
    #v(-3mm)
    #text(size: 13pt, fill: accent, t.subtitle)
  ]

  // One visual in two panels, framed separately like I1 and I2 on the
  // infographic. The gap is held here rather than drawn into the images,
  // so each panel is a self-contained square: (124mm - 5mm) / 2 = 59.5mm,
  // which is also the height, so the panels come out square.
  grid(
    columns: (1fr, 1fr),
    column-gutter: 5mm,
    placeholder(
      "B1a",
      "Classroom on a winter afternoon: board, shut window, pupils at desks, stale air building up at the ceiling.",
      height: 59.5mm,
    ),
    placeholder(
      "B1b",
      "Bedroom at night: shut window and shut door, one person asleep, the same stale air. Not the same room as I1.",
      height: 59.5mm,
    ),
  )

  heading(level: 2, t.p1.hook-head)
  t.p1.hook

  heading(level: 2, t.p1.why-head)
  t.p1.why

  heading(level: 2, t.p1.about-head)
  t.p1.about

  // =====================================================================
  // Page 2 — Why fresh air matters, especially at night
  script-page(2)
  heading(level: 1, t.p2.head)

  heading(level: 2, t.p2.sleep-head)
  t.p2.sleep

  heading(level: 2, t.p2.stuffy-head)
  t.p2.stuffy

  heading(level: 2, t.p2.damp-head)
  t.p2.damp

  // =====================================================================
  // Page 3 — CO₂: a sign of how fresh the air is
  // Continues on the same page as script page 2 (user, 2026-09-16).
  script-page(3, new-page: false)
  heading(level: 1, t.p3.head)

  heading(level: 2, t.p3.where-head)
  t.p3.where

  heading(level: 2, t.p3.smell-head)
  t.p3.smell

  // Text replaced on user instruction, 2026-09-16. See the changelog: the
  // 10,000 ppm and 1,400 ppm figures have no source of their own.
  heading(level: 2, t.p3.harmful-head)
  t.p3.harmful

  level-scale(titles: t.p3.scale-titles, captions: t.p3.scale-captions)
  text(size: 6.5pt, fill: muted, t.p3.scale-sources)

  heading(level: 2, t.p3.not-shown-head)
  t.p3.not-shown

  // =====================================================================
  // Page 4 — What level is good? Advice here and abroad
  script-page(4)
  heading(level: 1, t.p4.head)

  band-scale(
    band-labels: t.band-labels,
    marker-label: t.marker-label,
    outdoor-label: t.outdoor-label,
    unit-label: t.unit-label,
  )

  heading(level: 2, t.p4.nl-head)
  t.p4.nl

  heading(level: 2, t.p4.abroad-head)
  {
    set text(size: 7pt)
    set par(leading: 0.45em)
    table(
      columns: (auto, 1.4fr, 1fr, 1fr),
      table.header(..t.p4.table-head),
      ..t.p4.rows.flatten(),
    )
  }

  heading(level: 2, t.p4.bedrooms-head)
  t.p4.bedrooms

  heading(level: 2, t.p4.common-head)
  t.p4.common

  // =====================================================================
  // Page 5 — Measure it yourself
  script-page(5)
  heading(level: 1, t.p5.head)

  // Depends on the council decision on the motion.
  info-box(title: t.p5.lending-title, tbd(t.p5.lending))

  t.p5.buy

  heading(level: 2, t.p5.choose-head)
  t.p5.choose

  heading(level: 2, t.p5.place-head)
  t.p5.place-intro
  list(..t.p5.place-bullets)
  t.p5.place-note

  heading(level: 2, t.p5.read-head)
  t.p5.read-intro
  list(..t.p5.read-bullets)
  t.p5.read-after

  // B3. A measured night, not a drawn one: the curve comes from
  // shared/night-data.typ. The numbered call-outs under the graph repeat
  // the four moments as icons, for readers who do not read graphs. No
  // heading of its own: the bullets just above end on "look at the graph",
  // and the page has no room to spare.
  night-graph(
    title: t.p5.night-head,
    band-labels: t.band-labels,
    vent-label: t.p5.night-vent,
    x-caption: t.p5.night-x,
    y-caption: t.p5.night-y,
    steps: t.p5.night-steps,
  )
  // Caption and explanation are set smaller than the body: they belong to
  // the graph above them, not to the running text.
  {
    set text(size: 7pt)
    set par(leading: 0.42em)
    t.p5.night-caption
    parbreak()
    t.p5.night-explain
  }


  // =====================================================================
  // Page 6 — What helps and what doesn't
  script-page(6)
  [#heading(level: 1, t.p6.head) <what-helps>]

  heading(level: 2, t.p6.helps-head)
  list(..t.p6.helps)

  heading(level: 2, t.p6.not-replace-head)
  list(..t.p6.not-replace)

  heading(level: 2, t.p6.moisture-head)
  t.p6.moisture

  cut[
    #heading(level: 2, t.p6.subsidy-head)
    #t.p6.subsidy
  ]

  // =====================================================================
  // Page 7 — Myths and related issues
  script-page(7)
  heading(level: 1, t.p7.head)

  {
    set text(size: 7.6pt)
    table(
      columns: (1fr, 1.9fr),
      table.header(..t.p7.table-head),
      ..t.p7.rows.flatten(),
    )
  }

  info-box(title: t.p7.co-title, t.p7.co)

  cut(info-box(title: t.p7.voc-title, fill: luma(240), t.p7.voc))

  // =====================================================================
  // Page 8 — More information, colophon and sources
  script-page(8)
  heading(level: 1, t.p8.head)

  list(..t.p8.links)

  // URLs checked by hand and confirmed (user, 2026-09-16).

  v(4mm)
  align(center)[
    #qrcode(f.url, width: 30mm)
    #v(-1mm)
    #t.p8.qr-caption \
    #link(f.url)
  ]

  v(4mm)
  heading(level: 2, t.p8.colophon-head)
  t.p8.colophon

  heading(level: 2, t.p8.sources-head)
  reference-list()
}

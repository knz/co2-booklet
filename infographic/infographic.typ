// Infographic layout (A5, one side per language). The words live in
// text-en.typ and text-nl.typ; this file holds the structure, so both
// languages keep the same layout.
//
// Sources per block are given in the booklet, not here (decision
// 2026-09-16): the infographic carries no citations.

#import "/shared/facts.typ" as f
#import "/shared/style.typ": *
#import "/shared/diagrams.typ": band-scale
#import "@preview/tiaoma:0.3.0": qrcode

// Icons to commission, in the order of the two lists. Briefs stay English
// in both languages: they are production notes, not reader text.
#let helps-icons = (
  ("I3", "Icon: open ventilation grille"),
  ("I4", "Icon: window slightly open"),
  ("I5", "Icon: mechanical ventilation switch"),
)
#let not-icons = (
  ("I6", "Icon: plant"),
  ("I7", "Icon: air purifier"),
  ("I8", "Icon: air conditioner"),
  ("I9", "Icon: window opened briefly, morning and evening (clock)"),
)

#let badge(n) = box(baseline: 22%, circle(
  radius: 2.5mm,
  fill: accent,
  inset: 0pt,
  align(center + horizon, text(fill: white, weight: "bold", size: 7.5pt, str(n))),
))

#let block-head(n, title) = block(below: 0.5em, grid(
  columns: (auto, 1fr),
  column-gutter: 1.6mm,
  align: horizon,
  badge(n), text(size: 10pt, weight: "bold", fill: accent, title),
))

#let item(id, brief, ok, body) = grid(
  columns: (7mm, 1fr),
  column-gutter: 1.8mm,
  align: horizon,
  placeholder(id, brief, width: 7mm, height: 7mm, compact: true),
  [#text(weight: "bold", fill: if ok { f.band-green } else { f.band-red }, if ok [✓] else [✗]) #body],
)

#let render(t) = {
  show: setup.with(title: t.title-plain, size: 8.4pt, lang: t.lang)
  set page(margin: (x: 9mm, top: 9mm, bottom: 8mm))

  // ---- Title
  block(width: 100%, fill: accent, inset: (x: 4.5mm, y: 3.5mm), radius: 3pt, below: 3.5mm)[
    #text(size: 16pt, weight: "bold", fill: white, t.title)
    #v(-1mm)
    #text(size: 9pt, fill: white, t.subtitle)
  ]

  // ---- Blocks 1 and 2, with the visuals aligned at the same height
  grid(
    columns: (1fr, 1fr),
    column-gutter: 5mm,
    row-gutter: 1.5mm,
    // 25mm, not 21mm: Dutch headings and body text run longer than English
    // and would otherwise overlap the visuals below.
    block(width: 100%, height: 25mm)[
      #block-head(1, t.block1-head)
      #t.block1
    ],
    block(width: 100%, height: 25mm)[
      #block-head(2, t.block2-head)
      #t.block2
    ],
    placeholder("I1", "Bed, closed window and closed door; small mould spot in the corner.", height: 28mm),
    placeholder("I2", "Person breathing out; CO₂ meter display.", height: 28mm),
  )

  // ---- Block 3: the colour-band scale and the three key lines
  block-head(3, t.block3-head)
  band-scale(
    bar-height: 7mm,
    band-labels: t.band-labels,
    marker-label: t.marker-label,
    outdoor-label: t.outdoor-label,
    unit-label: t.unit-label,
  )
  v(-1mm)
  list(..t.levels)

  // ---- Block 4: what helps, what does not replace ventilation
  v(1mm)
  let rows = calc.max(t.helps.len(), t.not-replace.len())
  let cells = ()
  for i in range(rows) {
    cells.push(if i < t.helps.len() {
      item(helps-icons.at(i).at(0), helps-icons.at(i).at(1), true, t.helps.at(i))
    } else { [] })
    cells.push(if i < t.not-replace.len() {
      item(not-icons.at(i).at(0), not-icons.at(i).at(1), false, t.not-replace.at(i))
    } else { [] })
  }
  grid(
    columns: (1fr, 1fr),
    column-gutter: 5mm,
    row-gutter: 1.6mm,
    text(size: 10pt, weight: "bold", fill: accent, t.helps-head),
    text(size: 10pt, weight: "bold", fill: accent, t.not-replace-head),
    ..cells,
  )

  // ---- Footer
  v(1fr)
  line(length: 100%, stroke: 0.5pt + rule)
  grid(
    columns: (1fr, auto),
    column-gutter: 4mm,
    align: (left + top, center + top),
    [
      #text(size: 10pt, weight: "bold", fill: accent, t.footer-head)
      #v(-1.5mm)
      // Depends on the council decision on the motion.
      #tbd(t.lending)

      #t.buy

      #text(size: 6pt, fill: muted, t.sources-line) \
      #text(size: 6pt, fill: muted, t.colophon)
    ],
    [
      #qrcode(f.url, width: 21mm)
      #v(-2mm)
      #text(size: 6.2pt, t.qr-caption)
    ],
  )
}

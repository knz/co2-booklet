// Infographic, English side (A5). Text from script.md §2.
// No footnotes on the infographic (decision 2026-09-16); sources are listed
// per block in comments and given in the booklet.

#import "/shared/facts.typ" as f
#import "/shared/style.typ": *
#import "/shared/diagrams.typ": band-scale
#import "@preview/tiaoma:0.3.0": qrcode

#show: setup.with(title: "Fresh air in your bedroom? Measure it.", size: 8.4pt)
#set page(margin: (x: 9mm, top: 9mm, bottom: 8mm))

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

// ---- Title
#block(width: 100%, fill: accent, inset: (x: 4.5mm, y: 3.5mm), radius: 3pt, below: 3.5mm)[
  #text(size: 16pt, weight: "bold", fill: white)[Fresh air in your bedroom? Measure it.]
  #v(-1mm)
  #text(size: 9pt, fill: white)[CO₂ shows whether enough fresh air comes in.]
]

// ---- Blocks 1 and 2
#grid(
  columns: (1fr, 1fr),
  column-gutter: 5mm,
  row-gutter: 1.5mm,
  // Text cells have a fixed height, so I1 and I2 start at the same height.
  block(width: 100%, height: 21mm)[
    // Sources: Fan 2023 (sleep); Kang 2024; Strøm-Tejsen 2016 [§1d];
    // WHO 2009; Milieu Centraal [§14].
    #block-head(1)[Stale air, poorer sleep]
    In studies, people slept less deeply and woke up more often in poorly
    ventilated bedrooms. Too little fresh air also raises the risk of damp
    and mould.
  ],
  block(width: 100%, height: 21mm)[
    // Sources: ASHRAE 2025; HSE [§3, §9]; Zhang 2016, Chen 2023 [§4].
    #block-head(2)[CO₂ shows how fresh the air is]
    Everyone breathes out CO₂. When too little fresh air comes in, CO₂ goes
    up. You can't smell it, but a CO₂ meter shows it.
  ],
  placeholder("I1", "Bed, closed window and closed door; small mould spot in the corner.", height: 28mm),
  placeholder("I2", "Person breathing out; CO₂ meter display.", height: 28mm),
)

// ---- Block 3
// Sources: F2, F3, F5, F6. Factual comparison only, no "NL lags behind"
// line (decision 2026-09-15).
#block-head(3)[How much is too much?]
#band-scale(bar-height: 7mm)
#v(-1mm)
- Netherlands: advice is to stay below #ppm(f.nl-reference).
- Canada, Germany and Norway: #ppm(f.guide-abroad) guide value for indoor air.
- Sleep researchers: below #ppm(f.bedroom-max) in bedrooms.

// ---- Block 4
// Helps: Milieu Centraal "Natuurlijke ventilatie" and "Woning ventileren"
// 2026 [§12]. Does not replace: Gubb 2018 [§11]; EPA; REHVA 2021 [§13];
// Milieu Centraal [§12].
#v(1mm)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 5mm,
  row-gutter: 1.6mm,
  text(size: 10pt, weight: "bold", fill: accent)[What helps],
  text(size: 10pt, weight: "bold", fill: accent)[This does not replace ventilation],
  item("I3", "Icon: open ventilation grille", true)[Keep ventilation grilles open, day and night.],
  item("I6", "Icon: plant", false)[Plants],
  item("I4", "Icon: window slightly open", true)[No grilles? Put a small window ajar when you are home.],
  item("I7", "Icon: air purifier", false)[Air purifier],
  item("I5", "Icon: mechanical ventilation switch", true)[Mechanical ventilation: leave it on.],
  item("I8", "Icon: air conditioner", false)[Air conditioner],
  [],
  // Wording follows the booklet, which says "at most twice a day (only in
  // the evening, only in the morning, or both)"; shortened for the list.
  item("I9", "Icon: window opened briefly, morning and evening (clock)", false)[Airing at most twice a day],
)

// ---- Footer
#v(1fr)
#line(length: 100%, stroke: 0.5pt + rule)
#grid(
  columns: (1fr, auto),
  column-gutter: 4mm,
  align: (left + top, center + top),
  [
    #text(size: 10pt, weight: "bold", fill: accent)[Measure it yourself]
    #v(-1.5mm)
    // Depends on the council decision on the motion.
    #tbd[Borrow a CO₂ meter: \[where\] · \[how long\] · \[how to reserve\].]

    // [F13; HSE §10]
    Or buy a meter with an "NDIR" sensor (from about €#f.meter-price-min).

    #text(size: 6pt, fill: muted)[Sources: see the booklet, via the QR code.] \
    #text(size: 6pt, fill: muted)[Published by #f.publisher · #f.text-date]
  ],
  [
    #qrcode(f.url, width: 21mm)
    #v(-2mm)
    #text(size: 6.2pt)[More information \ and sources]
  ],
)

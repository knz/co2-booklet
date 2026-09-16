// Infographic text, English. Structure is in infographic.typ.

#import "/shared/facts.typ" as f
#import "/shared/style.typ": num, ppm

#let t = (
  lang: "en",
  title-plain: "Fresh air in your bedroom? Measure it.",
  title: [Fresh air in your bedroom? Measure it.],
  subtitle: [CO₂ shows whether enough fresh air comes in.],

  // Sources: Fan 2023 (sleep); Kang 2024; Strøm-Tejsen 2016 [§1d];
  // WHO 2009; Milieu Centraal [§14].
  block1-head: [Stale air, poorer sleep],
  block1: [In studies, people slept less deeply and woke up more often in
    poorly ventilated bedrooms. Too little fresh air also raises the risk of
    damp and mould.],

  // Sources: ASHRAE 2025; HSE [§3, §9]; Zhang 2016, Chen 2023 [§4].
  block2-head: [CO₂ shows how fresh the air is],
  block2: [Everyone breathes out CO₂. When too little fresh air comes in,
    CO₂ goes up. You can't smell it, but a CO₂ meter shows it.],

  // Sources: F2, F3, F5, F6. Factual comparison only, no "NL lags behind"
  // line (decision 2026-09-15).
  block3-head: [How much is too much?],
  band-labels: ([Good], [Could be better], [Too high: ventilate more], [Act now]),
  marker-label: [#num(f.guide-abroad) ppm: advised abroad and by sleep researchers],
  outdoor-label: [outdoors ≈ #num(f.outdoor)],
  unit-label: [ppm],
  levels: (
    [Netherlands: advice is to stay below #ppm(f.nl-reference).],
    [Canada, Germany and Norway: #ppm(f.guide-abroad) guide value for indoor air.],
    [Sleep researchers: below #ppm(f.bedroom-max) in bedrooms.],
  ),

  // Helps: Milieu Centraal "Natuurlijke ventilatie" and "Woning ventileren"
  // 2026 [§12]. Does not replace: Gubb 2018 [§11]; EPA; REHVA 2021 [§13];
  // Milieu Centraal [§12].
  helps-head: [What helps],
  helps: (
    [Keep ventilation grilles open, day and night.],
    [No grilles? Put a small window ajar when you are home.],
    [Mechanical ventilation: leave it on.],
  ),
  not-replace-head: [This does not replace ventilation],
  not-replace: (
    [Plants],
    [Air purifier],
    [Air conditioner],
    [Airing at most twice a day],
  ),

  footer-head: [Measure it yourself],
  lending: [Borrow a CO₂ meter: \[where\] · \[how long\] · \[how to reserve\].],
  // [F13; HSE §10] and the market check of 2026-09-16.
  buy: [Or buy a meter with an "NDIR" sensor (from about €#f.meter-price-min).],
  sources-line: [Sources: see the booklet, via the QR code.],
  colophon: [Published by #f.publisher · September 2026],
  qr-caption: [More information \ and sources],
)

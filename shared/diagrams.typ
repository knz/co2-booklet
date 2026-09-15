// Data diagrams drawn from the shared facts. Illustrations are commissioned
// separately; these can be restyled by the illustrator, but their numbers
// come from facts.typ.

#import "/shared/facts.typ" as f
#import "/shared/style.typ": num, ink, muted, accent

#let _label(x, y, body, width: 34mm, anchor: center, size: 6pt) = {
  let dx = if anchor == left { x } else if anchor == right { x - width } else { x - width / 2 }
  place(top + left, dx: dx, dy: y, box(width: width, align(anchor, text(size: size, fill: ink, body))))
}

#let _vtick(x, y, len, stroke: 0.5pt + ink) = place(
  top + left,
  dx: x,
  dy: y,
  line(start: (0pt, 0pt), end: (0pt, len), stroke: stroke),
)

// Filled colour bands between lo and hi, scaled to width w, at offset y.
#let _bands(lo, hi, w, y, h, labels: true) = {
  let x(v) = (calc.max(lo, calc.min(v, hi)) - lo) / (hi - lo) * w
  for b in f.bands {
    let to = if b.to == none { hi } else { b.to }
    if to > lo and b.from < hi {
      let x0 = x(b.from)
      let x1 = x(to)
      place(top + left, dx: x0, dy: y, rect(width: x1 - x0, height: h, fill: b.color, stroke: none))
      if labels {
        place(top + left, dx: x0, dy: y, box(
          width: x1 - x0,
          height: h,
          inset: (x: 1pt),
          align(center + horizon, text(size: 6.2pt, weight: "bold", fill: b.text, b.label)),
        ))
      }
    }
  }
}

// Colour-band scale from outdoor air to 2,000+ ppm, with markers for
// outdoor air and 1,000 ppm. Used on the infographic and booklet p4.
#let band-scale(
  bar-height: 8mm,
  marker-label: [#num(f.guide-abroad) ppm: advised abroad and by sleep researchers],
) = layout(size => {
  let w = size.width - 3mm // room for the arrow tip
  let lo = 400
  let hi = if f.bands-option == "B" { 2500 } else { 2300 }
  let x(v) = (v - lo) / (hi - lo) * w
  let y0 = 4.5mm
  let h = bar-height
  block(width: size.width, height: y0 + h + 5.5mm, breakable: false, spacing: 0.9em, {
    _bands(lo, hi, w, y0, h)
    // arrow tip at the open end
    place(top + left, dx: w, dy: y0, polygon(
      fill: f.bands.last().color,
      (0mm, 0mm),
      (2.4mm, h / 2),
      (0mm, h),
    ))
    // 1,000 ppm marker: above the bar only, so it does not cross band labels
    let xm = x(f.guide-abroad)
    place(top + left, dx: xm, dy: y0 - 1.8mm, line(
      start: (0pt, 0pt),
      end: (0pt, 1.8mm),
      stroke: 1pt + ink,
    ))
    place(top + left, dx: xm - 1mm, dy: y0 - 0.2mm, polygon(
      fill: ink,
      (0mm, 0mm),
      (2mm, 0mm),
      (1mm, 1.2mm),
    ))
    _label(xm - 1mm, 0mm, marker-label, width: 90mm, anchor: left)
    // axis ticks below
    let y = y0 + h
    _vtick(x(f.outdoor), y, 1.2mm)
    _label(x(f.outdoor) - 0.6mm, y + 1.4mm, [outdoors ≈ #num(f.outdoor)], anchor: left)
    for v in (f.mc-good-max, f.guide-abroad, f.nl-reference, 2000) {
      _vtick(x(v), y, 1.2mm)
      _label(x(v), y + 1.4mm, num(v), width: 12mm)
    }
    _label(size.width, y + 1.4mm, [ppm], width: 12mm, anchor: right)
  })
})

// Level scale with breaks: home levels, workplace limit, toxic levels.
// Booklet p3. Each panel has its own scale.
#let level-scale() = layout(size => {
  let w = size.width
  let gap = 5mm
  let pw = (w - 2 * gap) / 3
  let y0 = 4mm
  let h = 5.5mm
  let panels = (
    (lo: 400, hi: 3000, title: [Homes], ticks: (1000, 2000, 3000),
      caption: [Levels you can find at home]),
    (lo: 3000, hi: 10000, title: [Workplaces], ticks: (f.workplace-limit, 10000),
      caption: [#num(f.workplace-limit): limit for workplaces, averaged over #f.workplace-hours hours]),
    (lo: 10000, hi: f.unconscious-max, title: [Poisonous], ticks: (f.toxic-symptoms, f.unconscious-max),
      caption: [From about #num(f.toxic-symptoms): headache, dizziness, breathlessness. #num(f.unconscious-min)–#num(f.unconscious-max): unconsciousness]),
  )
  block(width: w, height: y0 + h + 14mm, breakable: false, spacing: 0.9em, {
    for (i, p) in panels.enumerate() {
      let x0 = i * (pw + gap)
      let x(v) = x0 + (v - p.lo) / (p.hi - p.lo) * pw
      place(top + left, dx: x0, dy: 0mm, text(size: 6.5pt, weight: "bold", fill: accent, p.title))
      if i == 0 {
        place(top + left, dx: x0, dy: 0mm, box(width: pw, height: y0 + h, _bands(p.lo, p.hi, pw, y0, h, labels: false)))
      } else if i == 1 {
        place(top + left, dx: x0, dy: y0, rect(width: pw, height: h, fill: gradient.linear(f.band-red, f.band-darkred)))
      } else {
        place(top + left, dx: x0, dy: y0, rect(width: pw, height: h, fill: f.band-darkred))
        place(top + left, dx: x(f.unconscious-min), dy: y0, rect(
          width: x(f.unconscious-max) - x(f.unconscious-min),
          height: h,
          fill: black,
        ))
      }
      let y = y0 + h
      for (j, v) in p.ticks.enumerate() {
        _vtick(x(v), y, 1.2mm)
        if v == p.hi {
          _label(x(v) + 0.3mm, y + 1.4mm, num(v), width: 12mm, anchor: right)
        } else {
          _label(x(v), y + 1.4mm, num(v), width: 12mm)
        }
      }
      _label(x0, y + 4.6mm, p.caption, width: pw, anchor: left, size: 5.8pt)
      // scale break between panels
      if i < 2 {
        place(top + left, dx: x0 + pw + gap / 2 - 1.6mm, dy: y0 - 0.6mm, text(size: 10pt, fill: muted, "//"))
      }
    }
  })
})

// Data diagrams drawn from the shared facts. Numbers come from facts.typ;
// all wording is passed in by the caller, so the diagrams work in any
// language. Illustrations are commissioned separately.

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
// `labels` is one label per band, in the order of facts.bands.
#let _bands(lo, hi, w, y, h, labels: ()) = {
  let x(v) = (calc.max(lo, calc.min(v, hi)) - lo) / (hi - lo) * w
  for (i, b) in f.bands.enumerate() {
    let to = if b.to == none { hi } else { b.to }
    if to > lo and b.from < hi {
      let x0 = x(b.from)
      let x1 = x(to)
      place(top + left, dx: x0, dy: y, rect(width: x1 - x0, height: h, fill: b.color, stroke: none))
      if i < labels.len() {
        place(top + left, dx: x0, dy: y, box(
          width: x1 - x0,
          height: h,
          inset: (x: 1pt),
          align(center + horizon, text(size: 6.2pt, weight: "bold", fill: b.fg, labels.at(i))),
        ))
      }
    }
  }
}

// Colour-band scale from outdoor air to 2,000+ ppm, with markers for
// outdoor air and 1,000 ppm. Used on the infographic and booklet p4.
#let band-scale(
  band-labels: (),
  marker-label: [],
  outdoor-label: [],
  unit-label: [ppm],
  bar-height: 8mm,
) = layout(size => {
  let w = size.width - 3mm // room for the arrow tip
  let lo = 400
  let hi = if f.bands-option == "B" { 2500 } else { 2300 }
  let x(v) = (v - lo) / (hi - lo) * w
  let y0 = 4.5mm
  let h = bar-height
  block(width: size.width, height: y0 + h + 5.5mm, breakable: false, spacing: 0.9em, {
    _bands(lo, hi, w, y0, h, labels: band-labels)
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
    _label(x(f.outdoor) - 0.6mm, y + 1.4mm, outdoor-label, anchor: left)
    for v in (f.mc-good-max, f.guide-abroad, f.nl-reference, 2000) {
      _vtick(x(v), y, 1.2mm)
      _label(x(v), y + 1.4mm, num(v), width: 12mm)
    }
    _label(size.width, y + 1.4mm, unit-label, width: 12mm, anchor: right)
  })
})

// Level scale with breaks: home levels, workplace limit, toxic levels.
// Booklet p3. Each panel has its own scale. `titles` and `captions` hold
// three entries each, in that order.
#let level-scale(titles: (), captions: ()) = layout(size => {
  let w = size.width
  let gap = 5mm
  let pw = (w - 2 * gap) / 3
  let y0 = 4mm
  let h = 5.5mm
  let panels = (
    (lo: 400, hi: 3000, ticks: (1000, 2000, 3000)),
    (lo: 3000, hi: 10000, ticks: (f.workplace-limit, 10000)),
    (lo: 10000, hi: f.unconscious-max, ticks: (f.toxic-symptoms, f.unconscious-max)),
  )
  block(width: w, height: y0 + h + 14mm, breakable: false, spacing: 0.9em, {
    for (i, p) in panels.enumerate() {
      let x0 = i * (pw + gap)
      let x(v) = x0 + (v - p.lo) / (p.hi - p.lo) * pw
      if i < titles.len() {
        place(top + left, dx: x0, dy: 0mm, text(size: 6.5pt, weight: "bold", fill: accent, titles.at(i)))
      }
      if i == 0 {
        place(top + left, dx: x0, dy: 0mm, box(width: pw, height: y0 + h, _bands(p.lo, p.hi, pw, y0, h)))
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
      for v in p.ticks {
        _vtick(x(v), y, 1.2mm)
        if v == p.hi {
          _label(x(v) + 0.3mm, y + 1.4mm, num(v), width: 12mm, anchor: right)
        } else {
          _label(x(v), y + 1.4mm, num(v), width: 12mm)
        }
      }
      if i < captions.len() {
        _label(x0, y + 4.6mm, captions.at(i), width: pw, anchor: left, size: 5.8pt)
      }
      // scale break between panels
      if i < 2 {
        place(top + left, dx: x0 + pw + gap / 2 - 1.6mm, dy: y0 - 0.6mm, text(size: 10pt, fill: muted, "//"))
      }
    }
  })
})

// ---------------------------------------------------------------------
// Booklet B3 — one measured night in one bedroom.
//
// Every value comes from shared/night-data.typ, which tools/make-night-data.py
// writes from the CSV export in sources/; nothing here invents a reading. The
// x-axis carries no clock times, only hours since the resident came into the
// room, so the graph says nothing about when the night happened.
//
// The decoration is the point as much as the curve is: colour bands behind
// it, a shaded strip over the minutes the ventilation ran a step higher, and
// four numbered call-outs that are repeated underneath as icons with a line
// of text each. Someone who does not read graphs should still get the story
// from the icons and the four lines.

#import "/shared/night-data.typ" as night

// The four call-outs, in time order. Which event each one marks is
// structure, so it lives here; the wording comes from the text files.
#let _night-steps = (
  (event: "enter", icon: "/visuals/marks/door-in.svg"),
  (event: "asleep", icon: "/visuals/marks/asleep.svg"),
  (event: "vent-up", icon: "/visuals/i10-hrv.svg"),
  (event: "leave", icon: "/visuals/marks/door-out.svg"),
)

// ppm on the measured curve at an arbitrary hour, linearly interpolated
// between the two samples around it.
#let _ppm-at(h) = {
  let prev = night.samples.first()
  for p in night.samples {
    if p.at(0) >= h {
      let span = p.at(0) - prev.at(0)
      if span == 0 { return p.at(1) }
      return prev.at(1) + (h - prev.at(0)) / span * (p.at(1) - prev.at(1))
    }
    prev = p
  }
  prev.at(1)
}

#let _badge(n, r: 1.7mm, size: 5.6pt) = box(
  width: 2 * r,
  height: 2 * r,
  baseline: r * 0.45,
  circle(radius: r, fill: accent, stroke: none, align(center + horizon, text(
    size: size,
    weight: "bold",
    fill: white,
    str(n),
  ))),
)

#let night-graph(
  title: [],            // sits inside the block, so it cannot break away
  band-labels: (),      // one per colour band the plot shows, bottom up
  vent-label: [],       // over the shaded strip
  x-caption: [],        // what the x-axis counts
  y-caption: [],        // the unit, over the y-axis
  steps: (),            // four call-outs, in time order
  y-ticks: (500, 750),
  plot-height: 29mm,
) = layout(size => {
  let y-lo = 400
  let y-hi = 1000
  let gutter = 8mm // y-axis labels
  let right-gutter = 7mm // threshold labels
  let ticks-h = 3.4mm
  let caption-h = 2.6mm
  let w = size.width - gutter - right-gutter
  let h = plot-height
  let x(v) = gutter + (v - night.x-min) / (night.x-max - night.x-min) * w
  let y(v) = (y-hi - v) / (y-hi - y-lo) * h
  let y-top = 0mm
  let y-bottom = h
  let e = night.events

  block(width: size.width, breakable: false, spacing: 0.9em, {
    block(width: size.width, spacing: 0.5em, align(
      center,
      text(size: 7.6pt, weight: "bold", fill: accent, title),
    ))
    block(width: size.width, height: y-bottom + ticks-h + caption-h, {
      // colour bands behind the curve, clipped to the plotted range
      for (i, b) in f.bands.enumerate() {
        let to = if b.to == none { y-hi } else { calc.min(b.to, y-hi) }
        let from = calc.max(b.from, y-lo)
        if to > from {
          place(top + left, dx: gutter, dy: y(to), rect(
            width: w,
            height: y(from) - y(to),
            fill: b.color.lighten(55%),
            stroke: none,
          ))
          if i < band-labels.len() {
            // Kept clear of the dashed threshold line the top band runs into.
            place(top + left, dx: gutter + 1.2mm, dy: y(calc.min(to, night.vent-up-ppm - 15)) + 0.8mm, text(
              size: 5.4pt,
              weight: "bold",
              fill: b.color.darken(25%),
              band-labels.at(i),
            ))
          }
        }
      }

      // the minutes the ventilation ran a step higher
      let vx0 = x(e.at("vent-up"))
      let vx1 = x(e.at("vent-down"))
      place(top + left, dx: vx0, dy: y-top, rect(
        width: vx1 - vx0,
        height: h,
        fill: ink.transparentize(82%),
        stroke: (left: 0.5pt + ink, right: 0.5pt + ink),
      ))
      // The strip is only a few minutes wide, far too narrow to letter, so
      // its label is overlaid in the empty green band just to its right.
      place(top + left, dx: vx1 + 1.4mm, dy: y-bottom - 6.4mm, box(width: 24mm, text(
        size: 5.4pt,
        weight: "bold",
        fill: ink,
        vent-label,
      )))

      // the two levels the automation switches on
      for v in (night.vent-up-ppm, night.vent-down-ppm) {
        place(top + left, dx: gutter, dy: y(v), line(
          length: w,
          stroke: (paint: accent, thickness: 0.4pt, dash: "dashed"),
        ))
        place(top + left, dx: gutter + w + 0.8mm, dy: y(v) - 1.3mm, text(
          size: 5.4pt,
          weight: "bold",
          fill: accent,
          num(v),
        ))
      }

      // the measured curve
      place(top + left, dx: 0mm, dy: 0mm, curve(
        stroke: 1pt + ink,
        fill: none,
        curve.move((x(night.samples.first().at(0)), y(night.samples.first().at(1)))),
        ..night.samples.slice(1).map(p => curve.line((x(p.at(0)), y(p.at(1))))),
      ))

      // axes
      place(top + left, dx: gutter, dy: y-bottom, line(length: w, stroke: 0.6pt + ink))
      place(top + left, dx: gutter, dy: y-top, line(
        start: (0pt, 0pt),
        end: (0pt, h),
        stroke: 0.6pt + ink,
      ))
      for v in y-ticks {
        _vtick(gutter - 1.2mm, y(v), 1.2mm, stroke: 0.5pt + ink)
        _label(gutter - 1.8mm, y(v) - 1.4mm, num(v), width: 12mm, anchor: right)
      }
      _label(0mm, y-top - 0.4mm, y-caption, width: 14mm, anchor: left, size: 5.4pt)

      // hours since the resident came into the room
      for hh in range(0, 13, step: 2) {
        _vtick(x(hh), y-bottom, 1.2mm)
        _label(x(hh), y-bottom + 1.4mm, if hh == 0 { [0] } else { str(hh) }, width: 10mm)
      }
      _label(gutter + w, y-bottom + ticks-h, x-caption, width: w, anchor: right, size: 5.6pt)

      // numbered call-outs on the curve
      for (i, s) in _night-steps.enumerate() {
        let hh = e.at(s.event)
        place(top + left, dx: x(hh) - 1.7mm, dy: y(_ppm-at(hh)) - 1.7mm, _badge(i + 1))
      }
    })

    // the same four, as icons with a line of text: the way in for a reader
    // who does not read graphs. Kept tight against the plot: the row
    // belongs to the graph, not to the text under it.
    block(above: 0.25em, grid(
      columns: (1fr,) * _night-steps.len(),
      column-gutter: 2.5mm,
      ..for (i, s) in _night-steps.enumerate() {
        (block(spacing: 0em, {
          grid(
            columns: (auto, auto),
            column-gutter: 1.4mm,
            align: horizon,
            _badge(i + 1),
            image(s.icon, width: 5.6mm),
          )
          v(1mm, weak: true)
          set par(leading: 0.32em)
          text(size: 5.6pt, if i < steps.len() { steps.at(i) } else { [] })
        }),)
      }
    ))
  })
})

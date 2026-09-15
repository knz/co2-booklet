// Shared page setup, styles and helpers for the infographic and booklet.

#import "/shared/facts.typ" as f

// Draft mode (default): shows TBD highlights, cut-candidate tags and
// (calc)/(advice) tags. Turn off with `--input draft=false`.
#let draft = sys.inputs.at("draft", default: "true") != "false"

// Colours
#let ink = rgb("#1d2a33")
#let accent = rgb("#1f6f8b")
#let accent-soft = rgb("#e4f0f3")
#let muted = rgb("#5b6770")
#let rule = rgb("#c9d3d8")
#let draft-mark = rgb("#b0187a")
#let tbd-fill = rgb("#fff0a8")

#let body-font = ("Noto Sans",)

// Numbers with thousands separators: 1200 -> "1,200".
#let num(n) = {
  let s = str(n)
  let out = ""
  let len = s.len()
  for (i, c) in s.clusters().enumerate() {
    if i > 0 and calc.rem(len - i, 3) == 0 { out += "," }
    out += c
  }
  out
}
#let ppm(n) = [#num(n)~ppm]

// ---------------------------------------------------------------------
// Page setup

#let setup(doc, title: "", size: 8.8pt) = {
  set document(title: title)
  set page(
    paper: "a5",
    margin: (x: 12mm, top: 12mm, bottom: 14mm),
    header: if draft {
      align(right, text(size: 6pt, fill: draft-mark)[PROTOTYPE · DRAFT · visuals are placeholders])
    },
    header-ascent: 40%,
  )
  set text(font: body-font, size: size, fill: ink, lang: "en")
  set par(leading: 0.55em, spacing: 0.75em)
  set list(indent: 0.1em, body-indent: 0.45em, spacing: 0.4em, marker: text(fill: accent)[•])
  set table(stroke: 0.4pt + rule, inset: (x: 1.6mm, y: 1.2mm))
  show table.cell.where(y: 0): set text(weight: "bold")
  show heading.where(level: 1): it => block(
    below: 0.7em,
    text(size: 14pt, weight: "bold", fill: accent, it.body),
  )
  show heading.where(level: 2): it => block(
    above: 0.9em,
    below: 0.45em,
    text(size: 9.8pt, weight: "bold", fill: accent, it.body),
  )
  set footnote.entry(
    separator: line(length: 20%, stroke: 0.4pt + muted),
    clearance: 0.5em,
    gap: 0.2em,
    indent: 0pt,
  )
  show footnote.entry: set text(size: 6pt, fill: muted)
  show footnote.entry: set par(leading: 0.4em)
  show link: set text(hyphenate: false)
  doc
}

// ---------------------------------------------------------------------
// Draft markers

#let _tag(label) = if draft {
  box(
    inset: (x: 1pt, y: 0.5pt),
    baseline: 0.5pt,
    text(size: 5.5pt, weight: "bold", fill: draft-mark, label),
  )
}

// Information still needed. Highlighted in draft mode.
#let tbd(body) = if draft {
  highlight(fill: tbd-fill, top-edge: "ascender", bottom-edge: "descender")[#text(
      size: 0.75em,
      weight: "bold",
      fill: draft-mark,
    )[TBD] #body]
} else { body }

// Practical advice derived from sourced statements (script marker).
#let advice = _tag("(advice)")
// Assumption not backed by a source (script open points).
#let assumption = _tag("(assumption)")
// Follows from a sourced mechanism, not stated as such in a source.
#let inference = _tag("(inference)")
// First to go if a page runs over.
#let cut-tag = _tag("CUT CANDIDATE")
#let cut(body) = if draft {
  block(
    stroke: (left: 1pt + draft-mark),
    inset: (left: 2mm),
    spacing: 0.75em,
  )[#cut-tag #body]
} else { body }

// Start of a script page (booklet). Records the script page number, so
// build.sh can report on which PDF page each script page starts.
#let script-page(n) = {
  if n > 1 { pagebreak() }
  [#metadata(n) <script-page>]
}

// ---------------------------------------------------------------------
// Visual placeholders (visuals are commissioned separately).
// Each placeholder is also recorded as metadata, so build.sh can list them.

#let _hatch = tiling(size: (5pt, 5pt))[
  #place(line(start: (0%, 100%), end: (100%, 0%), stroke: 0.4pt + rgb("#d5dadd")))
]

#let placeholder(id, brief, width: 100%, height: 30mm, compact: false) = {
  [#metadata((id: id, brief: brief, height: repr(height))) <visual>]
  block(
    width: width,
    height: height,
    fill: _hatch,
    stroke: (paint: muted, thickness: 0.6pt, dash: "dashed"),
    radius: 2pt,
    inset: 1.5mm,
    spacing: 0.6em,
    align(center + horizon, if compact {
      text(size: 5pt, fill: muted, weight: "bold")[#id]
    } else {
      box(fill: white.transparentize(15%), inset: 1.2mm, radius: 1pt)[
        #text(size: 6pt, weight: "bold", fill: muted)[VISUAL #id] \
        #text(size: 6pt, fill: muted, brief)
      ]
    }),
  )
}

// ---------------------------------------------------------------------
// Boxes

#let info-box(title: none, fill: accent-soft, body) = block(
  width: 100%,
  fill: fill,
  inset: 2.5mm,
  radius: 2pt,
  spacing: 0.9em,
  {
    if title != none {
      block(below: 0.5em, text(weight: "bold", fill: accent, size: 9.2pt, title))
    }
    body
  },
)

// ---------------------------------------------------------------------
// Citations: one footnote number per source. The first citation of a
// source creates a footnote with the full reference; later citations of
// the same source reuse its number.

#let refs = yaml("/sources/references.yml")
#let _cited = state("cited-sources", ())

#let _authors(a) = {
  if a == none { return none }
  if type(a) == str { return a }
  if a.len() <= 2 { a.join(", ") } else { a.first() + " et al." }
}

#let format-ref(key) = {
  assert(key in refs, message: "unknown source key: " + key)
  let r = refs.at(key)
  let parts = ()
  let who = _authors(r.at("author", default: none))
  let year = r.at("date", default: none)
  let head = if who != none and year != none {
    [#who (#str(year))]
  } else if who != none { who } else if year != none { [(#str(year))] }
  if head != none { parts.push(head) }
  parts.push(r.title)
  let p = r.at("parent", default: none)
  if p != none {
    let venue = emph(p.title)
    let vol = p.at("volume", default: none)
    let iss = p.at("issue", default: none)
    let pages = r.at("page-range", default: none)
    if vol != none { venue = [#venue #str(vol)] }
    if iss != none { venue = [#venue\(#str(iss))] }
    if pages != none { venue = [#venue:#str(pages)] }
    parts.push(venue)
  }
  let extra = r.at("note", default: none)
  if extra != none { parts.push(extra) }
  let sn = r.at("serial-number", default: none)
  let loc = if sn != none and "doi" in sn {
    link("https://doi.org/" + sn.doi)[doi:#sn.doi]
  } else if "url" in r {
    let u = if type(r.url) == str { r.url } else { r.url.value }
    link(u)
  }
  [#parts.join(". "). #if loc != none [#loc]]
}

#let _cite-one(key) = context {
  let lbl = label("src-" + key)
  if key in _cited.get() {
    ref(lbl)
  } else {
    _cited.update(s => s + (key,))
    [#footnote(format-ref(key))#lbl]
  }
}

// Cite one or more sources: #src("kang2024", "fan2023sleep")
#let src(..keys) = keys.pos().map(_cite-one).join(super[,])

// Our own arithmetic from sourced inputs: cites the sources, then adds a
// footnote that explains the calculation.
#let ourcalc(what, ..keys) = [#src(..keys)#super[,]#footnote[Our calculation: #what]#if draft [#_tag("(calc)")]]
#let calc-tag = _tag("(calc)")

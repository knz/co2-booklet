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

// Document language, set by `setup`. Dutch groups thousands with a full
// stop (1.200), English with a comma (1,200).
#let doc-lang = state("doc-lang", "en")

#let _grouped(n, sep) = {
  let s = str(n)
  let out = ""
  let len = s.len()
  for (i, c) in s.clusters().enumerate() {
    if i > 0 and calc.rem(len - i, 3) == 0 { out += sep }
    out += c
  }
  out
}

// Numbers with thousands separators: 1200 -> "1,200" (en), "1.200" (nl).
#let num(n) = context _grouped(n, if doc-lang.get() == "nl" { "." } else { "," })
#let ppm(n) = [#num(n)~ppm]

// ---------------------------------------------------------------------
// Page setup

#let setup(doc, title: "", size: 8.8pt, lang: "en") = {
  set document(title: title)
  doc-lang.update(lang)
  set page(
    paper: "a5",
    margin: (x: 12mm, top: 12mm, bottom: 14mm),
    header: if draft {
      align(right, text(size: 6pt, fill: draft-mark)[PROTOTYPE · DRAFT · visuals are placeholders])
    },
    header-ascent: 40%,
  )
  set text(font: body-font, size: size, fill: ink, lang: lang)
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
  show link: set text(hyphenate: false)
  doc
}

// ---------------------------------------------------------------------
// Draft markers

// Provenance tags — (advice), (calc), (inference), (assumption) — are
// hidden by default (user, 2026-09-16). Turn them back on with
// `--input tags=true`, or `TAGS=true ./build.sh`. The TBD highlight and the
// cut-candidate tag are not affected: they mark work still to do.
#let show-tags = sys.inputs.at("tags", default: "false") != "false"

#let _tag(label, visible: draft) = if visible {
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
#let advice = _tag("(advice)", visible: show-tags)
// Assumption not backed by a source (script open points).
#let assumption = _tag("(assumption)", visible: show-tags)
// Follows from a sourced mechanism, not stated as such in a source.
#let inference = _tag("(inference)", visible: show-tags)
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
// `new-page: false` continues on the current page (script pages merged).
#let script-page(n, new-page: true) = {
  if n > 1 and new-page { pagebreak() }
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

// The URL of a source, as a link (used for the "more information" list).
#let ref-url(key) = {
  let u = refs.at(key).url
  link(if type(u) == str { u } else { u.value })
}

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

#let calc-tag = _tag("(calc)", visible: show-tags)

// Number of an entry, or none if it has not been cited yet.
#let _index-of(entries, key) = {
  let found = none
  for (i, e) in entries.enumerate() {
    if e.key == key { found = i + 1 }
  }
  found
}

#let _cite-one(key, body: none) = context {
  let entries = _cited.get()
  let n = _index-of(entries, key)
  if n == none {
    n = entries.len() + 1
    _cited.update(es => es + ((key: key, body: body),))
  }
  super(str(n))
}

// Cite one or more sources: #src("kang2024", "fan2023sleep")
#let src(..keys) = keys.pos().map(k => _cite-one(k)).join(super[,])

// A numbered entry that is not a source, e.g. our own calculation. Give it
// an id; citing the same id again reuses its number.
#let note-cite(id, body: none) = _cite-one(id, body: body)

// Our own arithmetic from sourced inputs: cites the sources, then a
// numbered note that explains the calculation.
#let ourcalc(id, what, ..keys) = [#src(..keys)#super[,]#note-cite(id, body: [Our calculation: #what])#calc-tag]

// The numbered reference list, printed at the end of the document.
#let reference-list(size: 5.9pt, cols: 2) = context {
  let entries = _cited.final()
  set text(size: size)
  set par(leading: 0.38em, spacing: 0.4em)
  columns(cols, gutter: 4mm, {
    for (i, e) in entries.enumerate() {
      block(spacing: 0.4em, [#super(str(i + 1))~#if e.body != none { e.body } else { format-ref(e.key) }])
    }
  })
}

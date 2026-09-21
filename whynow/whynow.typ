// "Why should you care now?" sheet (A5, one side per language). The words
// live in text-en.typ and text-nl.typ; this file holds the structure, so
// both languages keep the same layout.
//
// Like the infographic, the sheet carries no citations (decision
// 2026-09-21). Its sources are in sources/references.yml under "Why now
// (A5 sheet)" and appear in the site's source list; the text files name
// the sources per block in comments. Storyline and wording limits:
// whynow-storyline.md.

#import "/shared/facts.typ" as f
#import "/shared/style.typ": *
#import "@preview/tiaoma:0.3.0": qrcode

// One of the two home types of block 3: icon beside the heading, text
// below at the full card width. The tint comes from the grid cell in
// `render`, not from a block here, so both cards get the height of the
// taller one.
#let home-card(id, brief, head, body) = {
  grid(
    columns: (9mm, 1fr),
    column-gutter: 2mm,
    align: horizon,
    placeholder(id, brief, width: 9mm, height: 9mm, compact: true),
    text(weight: "bold", fill: accent, head),
  )
  v(-1.2mm)
  body
}

#let render(t) = {
  show: setup.with(title: t.title-plain, size: 8.2pt, lang: t.lang)
  set page(margin: (x: 9mm, top: 9mm, bottom: 8mm))

  // ---- Title
  block(width: 100%, fill: accent, inset: (x: 4.5mm, y: 3.5mm), radius: 3pt, below: 3.5mm)[
    #text(size: 16pt, weight: "bold", fill: white, t.title)
    #v(-1mm)
    #text(size: 9pt, fill: white, t.subtitle)
  ]

  // ---- Blocks 1 and 2: before and after, with the two visuals side by
  // side above the text. W1 and W2 show the same door and window, so the
  // pair carries the argument before any text is read.
  grid(
    columns: (1fr, 1fr),
    column-gutter: 5mm,
    row-gutter: 1.5mm,
    placeholder("W1", "Front door with letterbox and a window frame; arrows of air coming in through the gaps.", height: 15mm),
    placeholder("W2", "The same door and window, sealed: draught strips, new frame; the arrows are gone.", height: 15mm),
    [
      #block-head(1, t.b1-head)
      #t.b1
    ],
    [
      #block-head(2, t.b2-head)
      #t.b2
    ],
  )

  // ---- Block 3: the two home types
  v(0.8mm)
  block-head(3, t.b3-head)
  grid(
    columns: (1fr, 1fr),
    column-gutter: 3mm,
    fill: accent-soft,
    inset: 2.2mm,
    // The icons are the infographic's I3 and I10, reused so the two sheets
    // share one icon set (decision 2026-09-21; they were W3 and W4).
    home-card("I3", "Icon: open ventilation grille", t.home-a-head, t.home-a),
    home-card("I10", "Icon: heat-recovery ventilation unit (WTW)", t.home-b-head, t.home-b),
  )

  // ---- Blocks 4 and 5
  v(0.8mm)
  grid(
    columns: (1fr, 1fr),
    column-gutter: 5mm,
    [
      #block-head(4, t.b4-head)
      #t.b4
    ],
    [
      #block-head(5, t.b5-head)
      #t.b5
    ],
  )

  // ---- Block 6: what the standard advice leaves out
  v(0.8mm)
  block-head(6, t.b6-head)
  t.b6-intro
  list(..t.b6-points)

  // ---- Footer: the first-person closing and the QR code
  // The 2.5mm is a hard minimum gap above the rule, as on the infographic:
  // text that has grown into the footer becomes a page overflow, which
  // build.sh fails on.
  v(2.5mm)
  v(1fr)
  line(length: 100%, stroke: 0.5pt + rule)
  grid(
    columns: (1fr, auto),
    column-gutter: 4mm,
    align: (left + top, center + top),
    [
      #text(size: 10pt, weight: "bold", fill: accent, t.closing-head)
      #v(-1.5mm)
      #t.closing

      #text(size: 6pt, fill: muted, t.sources-line) \
      #text(size: 6pt, fill: muted, t.colophon)
    ],
    [
      #qrcode(f.url, width: 21mm)
      #v(-1mm)
      #text(size: 6.2pt, t.qr-caption)
    ],
  )
}

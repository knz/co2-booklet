// Print imposition: places A5 pages of already-built PDFs onto A4
// landscape sheets, two side by side. Run by build.sh after the documents
// are compiled; reads its inputs from `--input`:
//
//   mode=infographic  nl=<pdf> en=<pdf>
//     One sheet: the Dutch infographic left, the English one right. Also
//     used for the "why now" sheet, which has the same format.
//   mode=booklet      src=<pdf>
//     The 8-page booklet as 2 sheets (4 sides) for saddle stitching:
//     8|1, 2|7 / 6|3, 4|5. Print double-sided, flip on the short edge, put
//     sheet 2 inside sheet 1, fold and staple.
//
// Paths are relative to the project root (typst --root .), hence the "/".

#set page(paper: "a4", flipped: true, margin: 0pt)

#let mode = sys.inputs.at("mode")

#let a5(path, n) = image("/" + path, page: n, width: 148mm, height: 210mm)

// A5 is 148 mm wide, half of A4 landscape 148.5 mm: both pages sit against
// the fold line, leaving the 0.5 mm spare at the outer edges.
#let sheet(l, r) = grid(
  columns: (148.5mm, 148.5mm),
  align(right, l), align(left, r),
)

#if mode == "infographic" {
  sheet(a5(sys.inputs.at("nl"), 1), a5(sys.inputs.at("en"), 1))
} else if mode == "booklet" {
  let src = sys.inputs.at("src")
  let sides = ((8, 1), (2, 7), (6, 3), (4, 5))
  for (i, (l, r)) in sides.enumerate() {
    if i > 0 { pagebreak() }
    sheet(a5(src, l), a5(src, r))
  }
} else {
  panic("unknown mode: " + mode)
}

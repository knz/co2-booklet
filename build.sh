#!/usr/bin/env bash
# Builds the infographic, the "why now" sheet and the booklet prototypes, in
# both languages, into build/.
#
#   ./build.sh                 draft mode (TBD highlights, cut tags)
#   DRAFT=false ./build.sh     without draft markers
#   BANDS=B ./build.sh         colour-band option B (see script.md §1)
#   LANGS="nl" ./build.sh      one language only
#   TAGS=true ./build.sh       show the (advice)/(calc)/(inference)/
#                              (assumption) provenance tags, hidden by default
#   ICONS=rows ./build.sh      infographic block 4 as icon + text on one
#                              line, instead of the default icon tiles
#
# Needs typst (0.15) and network access on the first run to fetch the QR
# code package. Uses pdfinfo (poppler-utils) for the page-count check.
set -euo pipefail
cd "$(dirname "$0")"

draft="${DRAFT:-true}"
bands="${BANDS:-A}"
langs="${LANGS:-en nl}"
tags="${TAGS:-false}"
icons="${ICONS:-large}"
args=(--root . --input "draft=$draft" --input "bands=$bands" --input "tags=$tags" \
      --input "icons=$icons")

mkdir -p build

# Which visual IDs have an asset. Typst cannot test for a file, so this
# writes visuals/manifest.json for it to read; an ID that is missing keeps
# its hatched placeholder box.
python3 tools/scan-visuals.py > /dev/null

# The measured curve on booklet B3, as Typst data. Committed, so a plain
# `typst compile` works; regenerated here so it cannot go stale against the
# CSV or the script that reads it.
python3 tools/make-night-data.py > /dev/null

status=0
check_pages() {
  local pdf=$1 expected=$2 pages
  pages=$(pdfinfo "$pdf" | awk '/^Pages:/ {print $2}')
  if [ "$pages" -gt "$expected" ]; then
    echo "OVERFLOW: $pdf has $pages pages (expected $expected)"
    status=1
  else
    echo "ok: $pdf ($pages page(s))"
  fi
}

for lang in $langs; do
  typst compile "${args[@]}" "booklet/booklet-$lang.typ" "build/booklet-$lang.pdf"
  typst compile "${args[@]}" "infographic/infographic-$lang.typ" "build/infographic-$lang.pdf"
  typst compile "${args[@]}" --pages 1 --ppi 200 \
    "infographic/infographic-$lang.typ" "build/infographic-$lang.png"
  # Booklet cover, shown as a thumbnail on the landing page next to the
  # infographic. 100 ppi is about twice its largest display size.
  typst compile "${args[@]}" --pages 1 --ppi 100 \
    "booklet/booklet-$lang.typ" "build/booklet-cover-$lang.png"
  # "Why now" sheet, and its thumbnail for the landing page.
  typst compile "${args[@]}" "whynow/whynow-$lang.typ" "build/whynow-$lang.pdf"
  typst compile "${args[@]}" --pages 1 --ppi 100 \
    "whynow/whynow-$lang.typ" "build/whynow-$lang.png"
  check_pages "build/booklet-$lang.pdf" 8
  check_pages "build/infographic-$lang.pdf" 1
  check_pages "build/whynow-$lang.pdf" 1
done

# Print versions on A4 landscape, from the PDFs just built (see
# print/impose.typ): the booklet imposed for folding, and both sides of the
# infographic, and of the "why now" sheet, on one sheet each.
for lang in $langs; do
  typst compile --root . --input mode=booklet --input "src=build/booklet-$lang.pdf" \
    print/impose.typ "build/booklet-print-$lang.pdf"
  check_pages "build/booklet-print-$lang.pdf" 4
done
if [ -z "${langs##*en*}" ] && [ -z "${langs##*nl*}" ]; then
  typst compile --root . --input mode=infographic \
    --input nl=build/infographic-nl.pdf --input en=build/infographic-en.pdf \
    print/impose.typ build/infographic-a4.pdf
  check_pages build/infographic-a4.pdf 1
  typst compile --root . --input mode=infographic \
    --input nl=build/whynow-nl.pdf --input en=build/whynow-en.pdf \
    print/impose.typ build/whynow-a4.pdf
  check_pages build/whynow-a4.pdf 1
fi

for lang in $langs; do
  echo
  echo "Booklet ($lang): PDF pages used per script page:"
  total=$(pdfinfo "build/booklet-$lang.pdf" | awk '/^Pages:/ {print $2}')
  typst eval "${args[@]}" --in "booklet/booklet-$lang.typ" --format json \
    'query(<script-page>).map(it => (it.value, it.location().page()))' \
    | python3 -c 'import json, sys
starts = json.load(sys.stdin)
total = int(sys.argv[1])
# Script pages that start on the same PDF page share it: report them together.
groups = []
for n, page in starts:
    if groups and groups[-1][1] == page:
        groups[-1][0].append(n)
    else:
        groups.append([[n], page])
for i, (ns, page) in enumerate(groups):
    end = groups[i + 1][1] if i + 1 < len(groups) else total + 1
    used = end - page
    label = "+".join("p%d" % n for n in ns)
    print("  script %s: %d%s" % (label, used, "  <- runs over" if used > len(ns) else ""))' "$total"
done

echo
echo "Visuals still to make (same in both languages):"
for doc in infographic/infographic-en.typ whynow/whynow-en.typ booklet/booklet-en.typ; do
  typst eval "${args[@]}" --in "$doc" --format json 'query(<visual>).map(it => it.value)' \
    | python3 -c 'import json, sys
done_ = 0
for v in json.load(sys.stdin):
    if v.get("asset"):
        done_ += 1
    else:
        print("  %s: %s" % (v["id"], v["brief"]))
if done_:
    print("  (%d placed from visuals/)" % done_)'
done

echo
if [ -n "${langs##*en*}" ] || [ -n "${langs##*nl*}" ]; then
  echo "site: skipped, needs both languages (LANGS=\"$langs\")"
else
  python3 tools/build-site.py
fi

exit $status

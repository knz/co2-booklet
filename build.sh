#!/usr/bin/env bash
# Builds the infographic and booklet prototypes, in both languages, into
# build/.
#
#   ./build.sh                 draft mode (TBD highlights, cut tags)
#   DRAFT=false ./build.sh     without draft markers
#   BANDS=B ./build.sh         colour-band option B (see script.md §1)
#   LANGS="nl" ./build.sh      one language only
#   TAGS=true ./build.sh       show the (advice)/(calc)/(inference)/
#                              (assumption) provenance tags, hidden by default
#
# Needs typst (0.15) and network access on the first run to fetch the QR
# code package. Uses pdfinfo (poppler-utils) for the page-count check.
set -euo pipefail
cd "$(dirname "$0")"

draft="${DRAFT:-true}"
bands="${BANDS:-A}"
langs="${LANGS:-en nl}"
tags="${TAGS:-false}"
args=(--root . --input "draft=$draft" --input "bands=$bands" --input "tags=$tags")

mkdir -p build

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
  check_pages "build/booklet-$lang.pdf" 8
  check_pages "build/infographic-$lang.pdf" 1
done

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
echo "Visual placeholders (same in both languages):"
for doc in infographic/infographic-en.typ booklet/booklet-en.typ; do
  typst eval "${args[@]}" --in "$doc" --format json 'query(<visual>).map(it => it.value)' \
    | python3 -c 'import json, sys
for v in json.load(sys.stdin): print("  %s: %s" % (v["id"], v["brief"]))'
done

exit $status

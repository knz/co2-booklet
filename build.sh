#!/usr/bin/env bash
# Builds the infographic and booklet prototypes into build/.
#
#   ./build.sh                 draft mode (TBD highlights, cut tags)
#   DRAFT=false ./build.sh     without draft markers
#   BANDS=B ./build.sh         colour-band option B (see script.md §1)
#
# Needs typst (0.15) and network access on the first run to fetch the QR
# code package. Uses pdfinfo (poppler-utils) for the page-count check.
set -euo pipefail
cd "$(dirname "$0")"

draft="${DRAFT:-true}"
bands="${BANDS:-A}"
args=(--root . --input "draft=$draft" --input "bands=$bands")

mkdir -p build

typst compile "${args[@]}" booklet/booklet-en.typ build/booklet-en.pdf
typst compile "${args[@]}" infographic/infographic-en.typ build/infographic-en.pdf
typst compile "${args[@]}" --pages 1 --ppi 200 infographic/infographic-en.typ build/infographic-en.png

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
check_pages build/booklet-en.pdf 8
check_pages build/infographic-en.pdf 1

echo
echo "Booklet: PDF pages used per script page:"
total=$(pdfinfo build/booklet-en.pdf | awk '/^Pages:/ {print $2}')
typst eval "${args[@]}" --in booklet/booklet-en.typ --format json \
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

echo
echo "Visual placeholders:"
for doc in infographic/infographic-en.typ booklet/booklet-en.typ; do
  typst eval "${args[@]}" --in "$doc" --format json 'query(<visual>).map(it => it.value)' \
    | python3 -c 'import json, sys
for v in json.load(sys.stdin): print("  %s: %s" % (v["id"], v["brief"]))'
done

exit $status

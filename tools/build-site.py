#!/usr/bin/env python3
"""Assemble the publishable site from the Typst build output.

Run by build.sh after a successful Typst build, and by
.github/workflows/pages.yml before the Pages upload. It:

  * converts each infographic PNG to a lossless WebP of the same size and
    copies it into site/assets/;
  * makes two lossy WebP thumbnails per language for the landing page, of
    the infographic and of the booklet cover;
  * copies the four PDFs into site/assets/;
  * generates site/sources.html from sources/references.yml.

Everything it writes is generated and git-ignored: site/index.html,
site/style.css, site/app.js and site/fonts/ are the hand-written sources.

Lossless, at the native pixel size, is not an arbitrary choice. The
infographic is text and line art, where lossy WebP rings around the glyphs
and, measured on this material, comes out larger anyway (q82: 144 kB
against 126 kB lossless). Resampling before compressing also makes the file
bigger, because it adds anti-aliasing noise for the encoder to store.

The thumbnails are the other way round: they are shown at most 208 px wide,
so nobody reads their text, and they carry illustrations. Measured at 583 px
wide, q80: booklet cover 44 kB (lossless 133 kB), infographic 52 kB (the
full-size lossless file is 258 kB). The full-size infographic is still
published, as the og:image.

Needs Pillow and PyYAML.
"""

import html
import shutil
import sys
from pathlib import Path

try:
    import yaml
    from PIL import Image
except ImportError as exc:  # pragma: no cover - dependency hint
    sys.exit("missing dependency: %s (need PyYAML and Pillow)" % exc.name)

ROOT = Path(__file__).resolve().parent.parent
BUILD = ROOT / "build"
SITE = ROOT / "site"
ASSETS = SITE / "assets"
LANGS = ("nl", "en")
# Pixel width of the landing page thumbnails: the booklet cover comes out of
# build.sh at this width (A5 at 100 ppi), and the infographic is scaled to it.
THUMB_WIDTH = 583

# Headings for the source list. The English keys are the section comments
# in sources/references.yml; the file's own order is kept.
SECTIONS = {
    "Health: sleep": "Gezondheid: slaap",
    "Health: cognition, headache, stuffy rooms": (
        "Gezondheid: concentratie, hoofdpijn, slecht geventileerde ruimtes"
    ),
    "Schools": "Scholen",
    "CO₂ as a ventilation indicator; toxic levels": (
        "CO₂ als maat voor ventilatie; giftige niveaus"
    ),
    "Netherlands: guidance, rules, data": "Nederland: advies, regels, cijfers",
    "Abroad": "Buitenland",
    "Measuring": "Meten",
    "What helps and what doesn't": "Wat helpt en wat niet",
    "More information (booklet p8)": "Meer informatie",
}


# --------------------------------------------------------------------------
# Images and PDFs


def to_webp(src: Path, dst: Path, quality=None, width=None) -> None:
    """Lossless at the native size, unless a quality or a width is given."""
    with Image.open(src) as im:
        if im.mode == "RGBA":
            flat = Image.new("RGB", im.size, "white")
            flat.paste(im, mask=im.split()[-1])
        else:
            flat = im.convert("RGB")
        if width is not None:
            height = round(width * flat.height / flat.width)
            flat = flat.resize((width, height), Image.LANCZOS)
        if quality is None:
            flat.save(dst, format="WEBP", lossless=True, method=6)
        else:
            flat.save(dst, format="WEBP", quality=quality, method=6)
    print("  %s  %d kB" % (dst.name, dst.stat().st_size // 1024))


def copy_assets() -> None:
    ASSETS.mkdir(parents=True, exist_ok=True)
    missing = []
    for lang in LANGS:
        png = BUILD / ("infographic-%s.png" % lang)
        if png.exists():
            to_webp(png, ASSETS / ("infographic-%s.webp" % lang))
            to_webp(
                png,
                ASSETS / ("infographic-thumb-%s.webp" % lang),
                quality=80,
                width=THUMB_WIDTH,
            )
        else:
            missing.append(png)
        cover = BUILD / ("booklet-cover-%s.png" % lang)
        if cover.exists():
            to_webp(cover, ASSETS / ("booklet-cover-%s.webp" % lang), quality=80)
        else:
            missing.append(cover)
        for name in ("infographic-%s.pdf" % lang, "booklet-%s.pdf" % lang):
            pdf = BUILD / name
            if pdf.exists():
                shutil.copy2(pdf, ASSETS / name)
                print("  %s  %d kB" % (name, (ASSETS / name).stat().st_size // 1024))
            else:
                missing.append(pdf)
    if missing:
        sys.exit(
            "missing build output, run ./build.sh first:\n  "
            + "\n  ".join(str(p.relative_to(ROOT)) for p in missing)
        )


# --------------------------------------------------------------------------
# Source list
#
# Entries are formatted the way the booklet formats them
# (shared/style.typ, format-ref), so print and page agree.


def read_refs():
    """Return [(english section title, [(key, entry)])], in file order."""
    raw = (ROOT / "sources" / "references.yml").read_text(encoding="utf-8")
    data = yaml.safe_load(raw)
    sections, current = [], None
    for line in raw.splitlines():
        if line.startswith("# ---"):
            title = line.lstrip("# -").rstrip(" -").strip()
            current = (title, [])
            sections.append(current)
        elif line and not line[0].isspace() and not line.startswith("#"):
            key = line.split(":", 1)[0].strip()
            if key in data:
                if current is None:
                    current = ("", [])
                    sections.append(current)
                current[1].append((key, data[key]))
    return [s for s in sections if s[1]]


def authors(value):
    if value is None:
        return None
    if isinstance(value, str):
        return value
    if len(value) <= 2:
        return ", ".join(value)
    return value[0] + " et al."


def esc(value) -> str:
    """Escape for text content. quote=False so apostrophes in titles stay
    readable in the source instead of becoming &#x27;."""
    return html.escape(str(value), quote=False)


def url_of(entry):
    u = entry.get("url")
    if isinstance(u, dict):
        return u.get("value")
    return u


def format_entry(entry) -> str:
    parts = []
    who = authors(entry.get("author"))
    year = entry.get("date")
    if who and year is not None:
        parts.append("%s (%s)" % (esc(who), esc(year)))
    elif who:
        parts.append(esc(who))
    elif year is not None:
        parts.append("(%s)" % esc(year))

    parts.append(esc(entry["title"]))

    parent = entry.get("parent")
    if parent:
        venue = "<cite>%s</cite>" % esc(parent["title"])
        if parent.get("volume") is not None:
            venue += " %s" % esc(parent["volume"])
        if parent.get("issue") is not None:
            venue += "(%s)" % esc(parent["issue"])
        if entry.get("page-range") is not None:
            venue += ":%s" % esc(entry["page-range"])
        parts.append(venue)

    text = ". ".join(parts) + "."

    doi = (entry.get("serial-number") or {}).get("doi")
    if doi:
        link = '<a href="https://doi.org/%s">doi:%s</a>' % (
            html.escape(str(doi)),
            esc(doi),
        )
    else:
        u = url_of(entry)
        link = '<a href="%s">%s</a>' % (html.escape(u), html.escape(u)) if u else ""
    return (text + " " + link).strip()


SOURCES_TEMPLATE = """<!doctype html>
<html lang="nl">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bronnen / Sources — CO₂</title>
<meta name="description" content="Bronnenlijst bij de informatie over gezonde lucht in huis. Reference list for the information about healthy air at home.">
<meta name="robots" content="index, follow">
<link rel="icon" href="favicon.svg" type="image/svg+xml">
<link rel="stylesheet" href="style.css">
<script>
/* Same language choice as the landing page. No gate here: a visitor who
   arrives straight at this page and has not chosen yet gets Dutch. */
(function(){var d=document.documentElement;d.className='js';var h=location.hash.replace('#','');
var l=(h==='nl'||h==='en')?h:null;try{if(!l)l=localStorage.getItem('co2-lang');}catch(e){}
if(l!=='nl'&&l!=='en')l='nl';d.setAttribute('data-lang',l);d.lang=l;})();
</script>
</head>
<body>
<div class="page">
%(sections)s
</div>
<script src="app.js" defer></script>
</body>
</html>
"""

SOURCES_SECTION = """<div class="lang" lang="%(lang)s">
  <header class="topbar"><div class="topbar__inner">
    <span class="brand">
      <span class="wordmark">%(wordmark)s</span>
      <span class="sender">%(sender)s</span>
    </span>
    <nav class="langswitch" aria-label="%(navlabel)s">
      <a href="#nl" data-lang-choice="nl"%(nlcur)s hreflang="nl">NL</a>
      <a href="#en" data-lang-choice="en"%(encur)s hreflang="en">EN</a>
    </nav>
  </div></header>
  <main class="wrap">
    <h1>%(title)s</h1>
    <p class="lede">%(lede)s</p>
%(groups)s
    <p><a class="back" href="index.html#%(lang)s">%(back)s</a></p>
  </main>
</div>
"""

COPY = {
    "nl": {
        "wordmark": "Gezonde lucht, gezond huis",
        "sender": "Een initiatief van leden van de gemeenteraad van Diemen",
        "navlabel": "Taal",
        "title": "Bronnen",
        "lede": (
            "Alle bronnen achter de infographic en de gids. "
            "Gecontroleerd op 15 september 2026."
        ),
        "back": "Terug naar de startpagina",
    },
    "en": {
        "wordmark": "Healthy air, healthy home",
        "sender": "An initiative of members of the Diemen city council",
        "navlabel": "Language",
        "title": "Sources",
        "lede": (
            "Every source behind the infographic and the booklet. "
            "Checked on 15 September 2026."
        ),
        "back": "Back to the start page",
    },
}


def render_sources() -> str:
    sections = read_refs()
    blocks = []
    for lang in LANGS:
        groups = []
        for title_en, entries in sections:
            heading = title_en if lang == "en" else SECTIONS.get(title_en, title_en)
            items = "\n".join(
                "        <li>%s</li>" % format_entry(e) for _, e in entries
            )
            groups.append(
                "    <h2>%s</h2>\n    <ul class=\"refs\">\n%s\n    </ul>"
                % (esc(heading), items)
            )
        copy = COPY[lang]
        blocks.append(
            SOURCES_SECTION
            % {
                "lang": lang,
                "wordmark": copy["wordmark"],
                "sender": copy["sender"],
                "navlabel": copy["navlabel"],
                "title": copy["title"],
                "lede": copy["lede"],
                "back": copy["back"],
                "groups": "\n".join(groups),
                "nlcur": ' aria-current="true"' if lang == "nl" else "",
                "encur": ' aria-current="true"' if lang == "en" else "",
            }
        )
    return SOURCES_TEMPLATE % {"sections": "\n".join(blocks)}


def main() -> None:
    print("site assets:")
    copy_assets()
    out = SITE / "sources.html"
    out.write_text(render_sources(), encoding="utf-8")
    total = sum(len(e) for _, e in read_refs())
    print("  sources.html  %d references" % total)


if __name__ == "__main__":
    main()

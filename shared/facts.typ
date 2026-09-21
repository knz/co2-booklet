// Shared facts for the infographic and the booklet.
// IDs (F1–F15) follow the shared facts table in script.md §1.
// Change a number here, and both documents follow.

// Landing page (QR target). Must stay stable, see PUBLISHING.md.
#let url = "https://knz.github.io/co2-booklet/"

// Colophon: the sender statement, the date wording ("September 2026" /
// "september 2026") and the date the sources were checked (2026-09-15) live
// in the per-language text files.

// F1 Outdoor CO₂, NOAA 2025 annual means.
#let outdoor = 425

// F2 Dutch reference value (Gezondheidsraad 2010; RIVM/GGD 2023).
#let nl-reference = 1200

// F3 Milieu Centraal consumer bands: up to 750 good; 750–1,200 could be
// better; above 1,200 too high.
#let mc-good-max = 750

// F5 Guidance for homes abroad.
#let guide-abroad = 1000 // Canada (24-hour average), Germany, Norway
#let uba-elevated-max = 2000 // Germany: above this "unacceptable"
#let flanders-above = 500 // above outdoor air
#let finland-above = 1150 // above outdoor air, binding action limit
// Derived (calc): absolute values with outdoor air at F1.
#let flanders-abs = outdoor + flanders-above
#let finland-abs = outdoor + finland-above

// F6 Researchers' bedroom target (Akimoto 2025).
#let bedroom-max = 1000
#let bedroom-preferred = 800

// F7 Workplace limit (Arboregeling Bijlage XIII; EU 2006/15/EC).
#let workplace-limit = 5000
#let workplace-hours = 8

// Short-term poisoning threshold used in the booklet (user, 2026-09-16).
// The literature report supports: no measurable effects in healthy adults
// after short exposures up to 20,000 ppm; symptoms above ~50,000 ppm. The
// exact 10,000 ppm figure has no source of its own.
#let poisoning-min = 10000

// Level above which the booklet says long-term effects are being studied
// (user, 2026-09-16). No source found for 1,400 ppm; the report could not
// trace the Dutch 1,400 ppm figures used elsewhere.
#let longterm-concern = 1400

// F8 Toxic levels (NIOSH 1994; Azuma 2018).
#let toxic-symptoms = 50000
#let unconscious-min = 70000
#let unconscious-max = 100000

// F9 Dutch bedroom data (TNO 2007; RIVM 2007). Measured in the heating
// season between October 2004 and April 2005 (TNO 2007, summary); earlier
// drafts said "around 2006", corrected 2026-09-21.
#let tno-homes = 1200
#let tno-year = "2004–2005"

// F10 Size of sleep effects (Kang 2024).
#let kang-low-ppm = 1000
#let kang-low-awake-min = 5
#let kang-low-efficiency = "1.3%"
#let kang-high-ppm = 1300
#let kang-high-awake-min = 8
#let kang-high-deep-min = "6–7"

// F11 CO deaths in the Netherlands per year (Brandweer).
#let co-deaths-min = 5
#let co-deaths-max = 10

// F12 Origin of ~1,000 ppm.
#let pettenkofer-period = "1850s"

// F13 Meter price in euro. Milieu Centraal 2026 gives €80–300. The €50
// starting price comes from a market check of Dutch and EU retail listings
// on 2026-09-16: several models whose manufacturer specifies an NDIR sensor
// were offered at about €50. Both documents now say "from about €50", so
// meter-price-max is currently unused. Caveats in the changelog.
#let meter-price-min = 50
#let meter-price-max = 300

// F14 Good indoor humidity in percent.
#let humidity-min = 40
#let humidity-max = 60

// F15 ISDE subsidy (RVO 2026).
#let isde-amount = 400
#let isde-year = 2026

// F16 Balanced ventilation: "van de woningen sinds het jaar 2000 gemiddeld
// 1 op de 4" (Milieu Centraal, balansventilatie, 2026). Used on the "why
// now" sheet.
#let balanced-since = 2000
#let balanced-one-in = 4

// Worked example p6 (calc; Persily & de Jonge 2017): one adult in a closed
// 30 m³ bedroom with no air leakage.
#let example-room-m3 = 30
#let example-rise-per-hour = 440

// Colour bands. Option A (default): Milieu Centraal's three bands.
// Option B adds a band above 2,000 ppm (UBA 2008 "unacceptable").
// Select with `--input bands=B`.
#let bands-option = sys.inputs.at("bands", default: "A")

#let band-green = rgb("#3f9b5c")
#let band-yellow = rgb("#f0c233")
#let band-red = rgb("#d4493f")
#let band-darkred = rgb("#8c1d18")

// Band labels are text and live in the per-language text files, in this
// order; `fg` is the colour to write them in.
#let bands = if bands-option == "B" {
  (
    (from: 0, to: mc-good-max, color: band-green, fg: white),
    (from: mc-good-max, to: nl-reference, color: band-yellow, fg: black),
    (from: nl-reference, to: uba-elevated-max, color: band-red, fg: white),
    (from: uba-elevated-max, to: none, color: band-darkred, fg: white),
  )
} else {
  (
    (from: 0, to: mc-good-max, color: band-green, fg: white),
    (from: mc-good-max, to: nl-reference, color: band-yellow, fg: black),
    (from: nl-reference, to: none, color: band-red, fg: white),
  )
}

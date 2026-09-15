// Booklet, English (8 A5 pages in reading order). Text from script.md §3.
// Citations: #src("key") with keys from sources/references.yml; one footnote
// number per source. Section pointers (§) refer to the local literature
// report and are kept as comments only.

#import "/shared/facts.typ" as f
#import "/shared/style.typ": *
#import "/shared/diagrams.typ": band-scale, level-scale
#import "@preview/tiaoma:0.3.0": qrcode

#show: setup.with(title: "CO₂ at home: measure, understand, ventilate")
#set page(footer: context {
  let n = counter(page).get().first()
  if n > 1 { align(center, text(size: 7pt, fill: muted, str(n))) }
})

// =====================================================================
// Page 1 — Cover and introduction

#script-page(1)

#block(below: 4mm)[
  #text(size: 22pt, weight: "bold", fill: accent)[CO₂ at home]
  #v(-3mm)
  #text(size: 13pt, fill: accent)[measure, understand, ventilate]
]

#placeholder("B1", "Classroom sketch next to a bedroom sketch.", height: 45mm)

== Remember that stuffy classroom?
// §17e
Remember a classroom on a winter afternoon, windows shut, thirty children
inside? The air felt heavy. Studies of schools link better ventilation to
better test results and better attendance#src("fisk2017", "haverinen2011", "wargocki2020").
The same thing can happen at home, especially in a bedroom with the door and
window closed.

== Why this matters now
// §8
When a home is sealed against draughts or insulated, less air leaks in
through gaps. Then grilles, windows or a ventilation system have to bring in
the fresh air#src("mc-natuurlijke", "signalen2024"). A room without a grille,
with the window closed, gets little fresh air at all. #inference

#cut[RIVM thinks that many people ventilated less during the 2022–2023 energy
  crisis#src("rivm-radon2024").]

== In this booklet
Why fresh air matters, how a CO₂ meter shows whether you get enough, and what
you can do.

// =====================================================================
// Page 2 — Why fresh air matters, especially at night

#script-page(2)
= Why fresh air matters, especially at night

== Sleep
// §1d
In several studies, researchers changed how much fresh air came into
bedrooms, sometimes without the sleepers knowing. With less fresh air (CO₂
from about 1,000 to 2,500 ppm during the night), people slept less deeply and
woke up more often#src("stromtejsen2016", "fan2023sleep", "kang2024"). In one
study, people also felt more rested after nights with better
ventilation#src("stromtejsen2016").

The differences were small, for example about #f.kang-low-awake-min to
#f.kang-high-awake-min extra minutes awake per night#src("kang2024"). Most
studies involved young, healthy adults.

#placeholder("B2", "Simple sleep-stage bar (deep / light / awake), schematic, no data values.", height: 14mm)

== Stuffy rooms during the day
// §1b–1c
In stuffy, poorly ventilated rooms, more people report headaches and
tiredness#src("zhang2017", "norback2013").

== Damp and mould
// §14
Breathing, cooking and showering add moisture to the air. Without enough
ventilation it stays inside. That raises the risk of damp and mould, which
are linked to breathing problems, allergies and asthma#src("who2009", "mc-woning").

#info-box(title: [What people say they notice])[
  // non-specific symptoms: §4a
  #text(size: 7.4pt, style: "italic")[These are personal experiences, not
    measured results. These complaints can have many causes; a meter shows
    whether stale air could be one of them.]
  #set text(size: 7.4pt)
  #table(
    columns: (1fr, 2fr),
    fill: white,
    table.header[People say…][What studies found],
    ["I wake up with a headache."],
    [More headaches in stuffy rooms during the day#src("zhang2017"). The one
      bedroom study that asked about headaches found no
      difference#src("stromtejsen2016").],

    ["I feel foggy and can't concentrate."],
    // §1a
    [Studies disagree. Some found lower scores on a demanding decision test
      in stale or CO₂-rich air#src("satish2012", "allen2016")\; others did
      not#src("rodeheffer2018", "scully2019", "chen2023").],

    ["I wake up tired."],
    [In one study people felt more rested after better-ventilated
      nights#src("stromtejsen2016").],

    [#cut-tag "I get irritable."],
    // §2
    [Not studied for stuffy bedrooms. Poor sleep in general can affect
      mood#src("palmer2024")\; whether the small sleep effects above are
      enough is not known.],
  )
]

// =====================================================================
// Page 3 — CO₂: a sign of how fresh the air is

#script-page(3)
= CO₂: a sign of how fresh the air is

== Where CO₂ comes from
// §3
Outdoor air contains about #ppm(f.outdoor) CO₂#src("noaa2025"). ("ppm" means
parts per million; 1,000 ppm is 0.1% of the air.) Everyone breathes out CO₂,
together with moisture and other substances from breath and skin. In a closed
room they build up together. So the CO₂ level shows how well a room is
ventilated for the number of people in it#src("ashrae2025", "hse", "persily2015").

== You can't smell it
// §4
CO₂ has no smell at these levels. The stuffy smell comes from the other
substances. After a few minutes in the room you stop noticing it, while
someone coming in from outside notices it straight
away#src("gunnarsen1992", "zhang2017").

== Is CO₂ itself harmful?
// §1a, §3, §5
Not at the levels found in homes, as far as studies show.

- In experiments where only pure CO₂ was added to well-ventilated rooms, most
  studies found no effect on headaches, tiredness or simple tasks, even at
  5,000 ppm for a few hours#src("zhang2016", "zhang2017", "chen2023", "fan2023meta").
  Tests of complex decision-making gave mixed results#src("fan2023meta").
- Workplaces may average up to #ppm(f.workplace-limit) over a working
  day#src("arboregeling", "eu2006").
- CO₂ becomes poisonous only at tens of thousands of ppm, far above home
  levels#src("niosh-idlh", "azuma2018").

#level-scale()

The advice to stay around #num(f.guide-abroad)–#ppm(f.nl-reference) is about
fresh air. It goes back to the #f.pettenkofer-period, when the scientist Max
von Pettenkofer used CO₂ as a sign of stale air#src("ashrae2025", "uba2008").

Studies lasted hours to weeks. No study has followed people at home levels
for months or years.

== What a CO₂ meter does not show
CO₂ is not a full measure of air quality#src("ashrae2025"). Smoke, cooking
fumes, fumes from paint or cleaning products, and damp are not measured by a
CO₂ meter. An empty room shows low CO₂ even if its ventilation is
poor. #inference Sleep researchers note that watching CO₂ alone may not be
enough for undisturbed sleep#src("akimoto2025").

// =====================================================================
// Page 4 — What level is good? Advice here and abroad

#script-page(4)
= What level is good? Advice in the Netherlands and abroad

#band-scale()

== The Netherlands
// §6
The Netherlands has no legal CO₂ limit for homes. The building code sets how
much ventilation a home must be able to provide, not a CO₂
level#src("iplo-nieuwbouw", "iplo-bestaand"). Dutch health bodies use
#ppm(f.nl-reference) as a sign that a room is not ventilated
enough#src("gezondheidsraad2010", "rivm-ggd2023"). Milieu Centraal: up to
#ppm(f.mc-good-max) is good, between #num(f.mc-good-max) and
#ppm(f.nl-reference) it could be better#src("mc-natuurlijke").

== Other countries
// §9
#[
  #set text(size: 7pt)
  #set par(leading: 0.45em)
  #table(
    columns: (auto, 1.4fr, 1fr, 1fr),
    table.header[Where][Value][Applies to][Status],
    [Canada#src("healthcanada2021")],
    [#ppm(f.guide-abroad), 24-hour average], [homes], [health ministry guideline],

    [Germany#src("uba2008")],
    [below #num(f.guide-abroad) no concern; #num(f.guide-abroad)–#num(f.uba-elevated-max)
      elevated; above #num(f.uba-elevated-max) unacceptable],
    [indoor spaces including homes], [federal environment agency guide values],

    [Norway#src("fhi2015")],
    [#ppm(f.guide-abroad)], [all indoor spaces (not industry)], [recommended norm (FHI)],

    [Flanders (Belgium)#src("flanders2018")],
    [#ppm(f.flanders-above) above outdoor air (≈~#ppm(f.flanders-abs))#footnote[Our
        calculation: the value above outdoor air plus outdoor air of about
        #ppm(f.outdoor).] <calc-abroad> #calc-tag],
    [homes and public buildings], [guide value in a regional decree],

    [Finland#src("finland545")],
    [#ppm(f.finland-above) above outdoor air (≈~#ppm(f.finland-abs))#ref(<calc-abroad>)],
    [homes], [binding: authorities can act above this],

    [#cut-tag Denmark#src("br18")],
    [#ppm(1000) (design)], [schools, day care], [building regulation BR18 §447],

    [#cut-tag France#src("france2022")],
    [#ppm(800) fine; above #num(1500) act quickly],
    [schools, childcare, care facilities], [binding since 2023],
  )
]

== Bedrooms
Sleep researchers advise keeping bedroom CO₂ below #ppm(f.bedroom-max),
preferably below #ppm(f.bedroom-preferred). This is advice from the research
group whose studies make up most of the evidence, not a legal
limit#src("akimoto2025").

== How common is it in Dutch homes?
// §7
In a national study of about #num(f.tno-homes) Dutch homes, measured around
#f.tno-year, almost half of main bedrooms went above #ppm(f.nl-reference) at
least once during the measured week#src("tno2007", "rivm2007"). No newer
national measurements were found.

// =====================================================================
// Page 5 — Measure it yourself

#script-page(5)
= Measure it yourself

#info-box(title: [Borrow a CO₂ meter])[
  #tbd[Borrow a CO₂ meter: \[where\] · \[for how long\] · \[how to reserve\]
    · \[what you get: meter, short instruction\].]
]

Or buy one: a CO₂ meter costs about
€#f.meter-price-min–#f.meter-price-max#src("mc-natuurlijke"). Milieu Centraal
also advises measuring, or borrowing a meter, in the living room and
bedrooms#src("mc-natuurlijke").

== Choose the right meter
// §10
Choose a meter with an NDIR sensor. Meters that show "eCO₂" or "CO₂
equivalent" do not measure CO₂; they estimate it from other
gases#src("hse"). In Belgium such estimating meters may no longer be sold
since March 2024#src("prevent").

== Where to put it
Guidance for workplaces and public buildings says:
- at head height;
- not next to a window, door or air inlet;
- not right next to people: at least 0.5 m#src("hse") to 1.5 m#src("prevent").

There is no specific guidance for bedrooms. In a bedroom, for example, on a
cupboard or shelf away from the window and not next to your pillow. #advice

Outdoors, a meter shows roughly 400–450 ppm: outdoor air is about
#ppm(f.outdoor)#src("noaa2025"), and meters are not exact. #assumption

== Read the night
Most meters store their readings. The next morning, look at the graph:
- When did CO₂ start rising?
- How high did it get?
- Did it drop when a grille or window was opened?

Then change one thing at a time, for example one night with the grille
closed and one night with it open, and compare. #advice

#placeholder("B3", "Example overnight graph from a real measurement with a test meter, with date and room described. Do not draw invented values.", height: 30mm)

// =====================================================================
// Page 6 — What helps and what doesn't

#script-page(6)
= What helps and what doesn't <what-helps>

== What helps
// §12
- *Grilles open.* Keep ventilation grilles open, day and night, all year.
  They don't need to be fully open. Clean them at least once a
  year#src("mc-natuurlijke").
- *No grilles?* Put a small window slightly open when you are
  home#src("mc-natuurlijke").
- *Mechanical ventilation.* Leave the fan on at all times#src("mc-woning").
  Studies of new Dutch homes found systems were often left on the lowest
  setting, partly because of noise, and often delivered less air than
  required#src("bader2009", "rigo2009", "bba2011"). If your meter shows high
  values, try a higher setting. #advice
- *Above #ppm(f.nl-reference)?* Open the grille or window
  further#src("mc-natuurlijke").

== This does not replace ventilation
- *Plants.* Plants do not measurably lower CO₂ in a home. Even in very bright
  light you would need hundreds to more than a thousand plants to take up the
  CO₂ of one person, and in the dark plants give off
  CO₂#ourcalc([plant count from the CO₂ uptake per plant that Gubb et al.
    measured under very bright light, and about 30 g of CO₂ per hour for one
    person at home (Persily & de Jonge).], "gubb2018", "persily2017").
- *Air purifier or air conditioner.* They clean or cool the air that is
  already inside. They don't bring in outdoor air, so they don't lower
  CO₂#src("epa", "rehva2021").
- *Airing once a day.* Airing refreshes the air, but once the window is
  closed, CO₂ rises again while people are in the room. As an example: one
  adult in a closed bedroom of #f.example-room-m3 m³ with no air leaking in
  adds roughly #ppm(f.example-rise-per-hour) per
  hour#ourcalc([about 13 litres of CO₂ per hour for one adult man at rest
    (Persily & de Jonge), spread over #f.example-room-m3 m³ of air with no
    air exchange.], "persily2017"). Real rooms leak some air, so the rise
  slows. Keep the grilles open as well#src("mc-natuurlijke").

== Fresh air and moisture in winter
// §14
Ventilation also removes moisture, which lowers the risk of damp and
mould#src("who2009", "uba-lueften"). Indoor humidity of
#f.humidity-min–#f.humidity-max% is good#src("uba-lueften", "mc-natuurlijke").

A window left wide open on tilt for hours in winter cools the wall around it,
which can cause condensation and mould. German advice is to air briefly with
the window wide open, and keep grilles open#src("uba-lueften").

#cut[
  == Subsidy
  // §17f
  Homeowners may get €#f.isde-amount ISDE subsidy for a CO₂-controlled or
  heat-recovery ventilation system, only together with an insulation measure
  (conditions #f.isde-year; check rvo.nl)#src("rvo-isde").
]

// =====================================================================
// Page 7 — Myths and related issues

#script-page(7)
= Myths and facts

#[
  #set text(size: 7.6pt)
  #table(
    columns: (1fr, 1.9fr),
    table.header[Myth][Fact],
    [*"CO₂ is harmless — we breathe it out anyway."*],
    // §3, §1d
    [Partly true: at home levels, CO₂ itself is not poisonous. But high CO₂
      means stale air, too little fresh air for the people in the
      room#src("ashrae2025"). In studies, people slept less deeply in such
      bedrooms#src("fan2023sleep", "kang2024").],

    [*"I don't notice anything, so it's fine."*],
    // §4
    [Your nose is not a good guide. CO₂ has no smell, and you stop noticing
      stale air within minutes#src("gunnarsen1992", "zhang2017"). A meter
      shows what your nose misses.],

    [*"My house is old and draughty, so the air is fine."*],
    // §7, §8
    [Not necessarily. In the national Dutch study (measured around
      #f.tno-year), living rooms in homes built between 1945 and 1970 had
      higher CO₂ than in newer homes#src("tno2007"). And many people seal
      gaps against draughts; then grilles or windows must bring in the
      air#src("mc-natuurlijke").],

    [*"Plants help a little."*],
    // §11
    [Not measurably. See page #context counter(page).at(<what-helps>).first()#src("gubb2018").],

    [*"An air purifier with a CO₂ sensor is enough."*],
    // §13
    [The sensor can show the problem, but the purifier doesn't fix it: it
      brings in no outdoor air#src("epa").],
  )
]

#info-box(title: [CO is something else])[
  // §15
  CO (carbon monoxide) is a different gas. It can come from appliances that
  burn fuel, such as a central-heating boiler, geyser, gas fire, stove or
  open fireplace, when they don't work properly or lack fresh air. It is
  poisonous even for a short time. Every year #f.co-deaths-min to
  #f.co-deaths-max people in the Netherlands die from it and hundreds go to
  hospital. The first signs (headache, dizziness, nausea) look like
  flu#src("brandweer-co"). A CO alarm does not measure CO₂, and a CO₂ meter
  does not warn you about CO: they do different jobs#src("co2meter2023").
]

#cut[
  #info-box(title: [Other substances], fill: luma(240))[
    // §16
    Fumes from paint, furniture, cleaning and personal-care products and
    cooking (VOCs) are not measured by a CO₂ meter either. Ventilation lowers
    both#src("uba2020", "mc-woning", "epa").
  ]
]

// =====================================================================
// Page 8 — More information and colophon

#script-page(8)
= Want to know more?

#let ref-url(key) = {
  let u = refs.at(key).url
  link(if type(u) == str { u } else { u.value })
}

- Milieu Centraal, ventilation: #ref-url("mc-woning")
- RIVM, "Binnenmilieu in woningen": #ref-url("rivm-woningen")
- Brandweer.nl, "Koolmonoxide": #ref-url("brandweer-co")

#tbd[Check these URLs before print.]

== Sources
The sources for this booklet are given in the footnotes on each page.
#tbd[Full source list on the landing page.]

#v(6mm)
#align(center)[
  #qrcode(f.url, width: 32mm)
  #v(-1mm)
  More information and sources \
  #link(f.url)
]

#v(1fr)
== About this booklet
#tbd[Publisher line (no party or fraction name).] \
#tbd[Date of the text.] \
Sources checked on #f.sources-checked. \
This booklet gives general information. It is not medical advice.

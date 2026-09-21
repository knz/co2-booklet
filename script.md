# Script: infographic and booklet (draft 2)

Status: draft for content review, 2026-09-15. Replaces `script-sketch.md` as
the working script; the old sketch stays in the repository as a reference.

## 0. How to read this script

- **Direction:** `input2.txt` (three core messages, relevance, ineffective
  measures, unrelated problems, myths). Topics kept from `input.txt` by
  decision: measuring with a meter; humidity, damp and mould; toxic levels
  vs 1,000 ppm; stuffy-room symptoms. Symptoms that studies do not back up
  are shown as anecdotal reports, each paired with what studies found.
- **Language:** English text is draft copy. Lines marked **NL:** are
  proposed Dutch headlines or key sentences (aiming at B1). Full Dutch text
  follows after the content is approved.
- **Sources:** `[Author year; §n]` points to a source and to the section of
  the literature report (`sources/archive/_report.md`, local only). Two
  papers share "Fan 2023": *Fan 2023 (sleep)* is the bedroom ventilation
  study, *Fan 2023 (meta)* the cognition meta-analysis.
- **Markers:**
  - `(calc)` — our own arithmetic from sourced inputs;
  - `(advice)` — practical advice derived from sourced statements, not a
    finding in itself;
  - `[TBD]` — information still needed;
  - `[cut candidate]` — first to go if a page runs over.
- **Word budgets** are estimates for A5 with a visual; they are checked
  once the text is laid out in Typst.
- No figure from `script-sketch.md` is used unless the report confirmed it.

---

## 1. Shared facts

Defined once, used by both the infographic and the booklet. Strength is the
report's rating.

| ID | Fact | Wording in the materials | Source | Strength |
|---|---|---|---|---|
| F1 | Outdoor CO₂ | about 425 ppm | NOAA 2025 annual means (global 425.62; Mauna Loa 427.35) [§5] | well supported |
| F2 | Dutch reference value | 1,200 ppm, a sign that a room is not ventilated enough | Gezondheidsraad 2010; RIVM/GGD school guideline 2023; Milieu Centraal 2026 [§6] | well supported |
| F3 | Dutch consumer bands | up to 750 ppm good; 750–1,200 could be better; above 1,200 too high, ventilate more | Milieu Centraal "Natuurlijke ventilatie" 2026 [§6] | consumer advice |
| F4 | Dutch rules for homes | no legal CO₂ limit; the building code sets a minimum ventilation capacity | IPLO pages on Bbl [§6] | well supported |
| F5 | Guidance for homes abroad | Canada 1,000 ppm (24-hour average); Germany <1,000 no concern, 1,000–2,000 elevated, >2,000 unacceptable; Norway 1,000 ppm; Flanders 500 ppm above outdoor; Finland 1,150 ppm above outdoor (binding action limit) | Health Canada 2021; UBA 2008; FHI 2015; Binnenmilieubesluit annex 2018; Decree 545/2015 [§9] | well supported per item |
| F6 | Researchers' bedroom target | below 1,000 ppm, preferably below 800 ppm | Akimoto 2025 [§1d] | research recommendation |
| F7 | Workplace limit | 5,000 ppm averaged over an 8-hour working day | Arboregeling Bijlage XIII; EU 2006/15/EC [§3] | well supported |
| F8 | Toxic levels | headache, dizziness, breathlessness above ~50,000 ppm; unconsciousness at 70,000–100,000 ppm | NIOSH IDLH 1994; Azuma 2018 Table 1 [§3] | well supported / with caveats |
| F9 | Dutch bedroom data | almost half of main bedrooms above 1,200 ppm at least once in a measured week (about 1,200 homes, measured around 2006) | TNO 2007; RIVM 2007 summary (47%) [§7] | supported with caveats (old data) |
| F10 | Size of sleep effects | at ~1,000 ppm night average: about 5 min more awake, sleep efficiency 1.3% lower; at ~1,300 ppm: about 8 min more awake, 6–7 min less deep sleep | Kang 2024 [§1d] | one lab study |
| F11 | CO deaths NL | on average 5–10 deaths a year, hundreds to hospital | Brandweer.nl "Koolmonoxide" [§15] | well supported |
| F12 | Origin of ~1,000 ppm | 1850s, Max von Pettenkofer, as a sign of stale air | ASHRAE 2025; UBA 2008 [§3] | well supported |
| F13 | Meter price | about €80–300 | Milieu Centraal 2026 [§6] | consumer page |
| F14 | Good humidity | 40–60% | UBA "Wie lüfte ich richtig?"; Milieu Centraal 2026 [§14] | guidance |
| F15 | ISDE subsidy | €400 for CO₂-controlled or heat-recovery ventilation, only with an insulation measure (2026) | RVO 2026 [§17f] | well supported, may change |

Derived values `(calc)`: Flanders 425 + 500 ≈ 925 ppm; Finland 425 + 1,150
≈ 1,575 ppm.

**Colour bands (decision needed).**

- **Option A (default):** Milieu Centraal's three bands (F3), with a
  marker line at 1,000 ppm labelled "advised abroad and by sleep
  researchers" (F5, F6).
  - green: up to 750
  - yellow: 750–1,200
  - red: above 1,200
- **Option B:** as A, plus a fourth band above 2,000 ppm, based on the
  German "unacceptable" value (UBA 2008). It gives a clearer "act now"
  band, but mixes a German value into the Dutch scale.

The script below assumes option A.

---

## 2. Infographic (A5, one side per language)

Budget: about 150–180 words per side. Layout from top to bottom: title,
three numbered blocks, "what helps / what doesn't" in two columns, footer
with meter and QR code.

### Title

- **EN:** Fresh air in your bedroom? Measure it.
- **NL:** Frisse lucht in je slaapkamer? Meet het!
- **Subtitle EN:** CO₂ shows whether enough fresh air comes in.
- **NL:** CO₂ laat zien of er genoeg frisse lucht binnenkomt.

### Block 1 — Stale air, poorer sleep

- **NL headline:** Gebruikte lucht, slechter slapen
- **EN text:** In studies, people slept less deeply and woke up more often
  in poorly ventilated bedrooms. Too little fresh air also raises the risk
  of damp and mould.
- **Sources:** Fan 2023 (sleep); Kang 2024; Strøm-Tejsen 2016 [§1d]; WHO
  2009; Milieu Centraal [§14].
- **Visual:** bed, closed window and closed door; small mould spot in the
  corner.

### Block 2 — CO₂ shows how fresh the air is

- **NL headline:** CO₂ laat zien hoe fris de lucht is
- **EN text:** Everyone breathes out CO₂. When too little fresh air comes
  in, CO₂ goes up. You can't smell it, but a CO₂ meter shows it.
- **Sources:** ASHRAE 2025; HSE [§3, §9]; Zhang 2016, Chen 2023 (no smell
  effect) [§4].
- **Visual:** person breathing out, meter display.

### Block 3 — How much is too much?

- **NL headline:** Hoeveel is te veel?
- **Visual:** horizontal scale from 400 to 2,000+ ppm with the colour bands
  (option A). Markers: "outdoors ≈ 425" and "1,000".
- **EN text:**
  - Netherlands: advice is to stay below 1,200 ppm.
  - Canada, Germany and Norway: 1,000 ppm guide value for indoor air.
  - Sleep researchers: below 1,000 ppm in bedrooms.
- **NL key line:** Nederland: onder 1200 ppm. Canada, Duitsland, Noorwegen:
  1000 ppm.
- **Sources:** F2, F3, F5, F6.
- **Note:** a factual comparison only, with no "the Netherlands lags
  behind" line (decision 2026-09-15).

### Block 4 — What helps / what doesn't

- **NL headlines:** Wat helpt / Dit vervangt ventileren niet
- **Helps (EN):**
  - Keep ventilation grilles open, day and night.
  - No grilles? Put a small window ajar when you are home.
  - Mechanical ventilation: leave it on.
  - Sources: Milieu Centraal "Natuurlijke ventilatie" and "Woning
    ventileren" 2026 [§12].
- **Does not replace ventilation (EN):**
  - plants
  - air purifier
  - air conditioner
  - airing only once a day
  - Sources: Gubb 2018 [§11]; EPA; REHVA 2021 [§13]; Milieu Centraal
    [§12].
- **Visual:** icons with check / cross.

### Footer — Measure it yourself

- **NL headline:** Meet het zelf
- **Lending block [TBD]:** "Borrow a CO₂ meter: [where] · [how long] ·
  [how to reserve]." Depends on the council decision on the motion.
- **Fallback line (EN):** Or buy a meter with an "NDIR" sensor (about
  €80–300). [F13; HSE §10]
- **QR code:** "More information and sources" / NL "Meer informatie en
  bronnen" → https://knz.github.io/co2-booklet/
- **Colophon [TBD]:** publisher line and date. No party or fraction name.

---

## 3. Booklet (8 A5 pages)

### Page 1 — Cover and introduction

Budget: title plus about 150 words.

- **Title EN:** CO₂ at home: measure, understand, ventilate
- **NL:** CO₂ in huis: meten, begrijpen, ventileren

**Hook** (NL headline: *Weet je nog, dat benauwde klaslokaal?*)

> Remember a classroom on a winter afternoon, windows shut, thirty
> children inside? The air felt heavy. Studies of schools link better
> ventilation to better test results and better attendance
> [Fisk 2017; Haverinen-Shaughnessy 2011; Wargocki 2020; §17e].
> The same thing can happen at home, especially in a bedroom with the
> door and window closed.

**Why this matters now** (NL headline: *Waarom juist nu?*)

> When a home is sealed against draughts or insulated, less air leaks in
> through gaps. Then grilles, windows or a ventilation system have to
> bring in the fresh air [Milieu Centraal 2026; Signalen Leefomgeving
> 2024; §8]. A room without a grille, with the window closed, gets little
> fresh air at all (advice, follows from the same mechanism).

[cut candidate]

> RIVM thinks that many people ventilated less during the 2022–2023 energy
> crisis [RIVM radon survey 2024; §8].

**What this booklet covers:** why fresh air matters, how a CO₂ meter shows
whether you get enough, and what you can do.

**Visual:** classroom sketch next to a bedroom sketch.

**Not used:** a measured national trend of "worse since insulation". The
report rates this mixed: TNO 2007 found no simple "newer home = higher CO₂"
pattern [§8].

---

### Page 2 — Why fresh air matters, especially at night

Budget: about 280 words, including the box.

- **Headline EN:** Why fresh air matters, especially at night
- **NL:** Waarom frisse lucht belangrijk is, vooral 's nachts

**Sleep**

> In several studies, researchers changed how much fresh air came into
> bedrooms, sometimes without the sleepers knowing. With less fresh air
> (CO₂ from about 1,000 to 2,500 ppm during the night), people slept less
> deeply and woke up more often [Strøm-Tejsen 2016; Fan 2023 (sleep);
> Kang 2024; §1d]. In one study, people also felt more rested after nights
> with better ventilation [Strøm-Tejsen 2016].
>
> The differences were small, for example about 5 to 8 extra minutes awake
> per night [Kang 2024]. Most studies involved young, healthy adults.

**Stuffy rooms during the day**

> In stuffy, poorly ventilated rooms, more people report headaches and
> tiredness [Zhang 2017; Norbäck 2013; §1b–1c].

**Damp and mould**

> Breathing, cooking and showering add moisture to the air. Without enough
> ventilation it stays inside. That raises the risk of damp and mould,
> which are linked to breathing problems, allergies and asthma
> [WHO 2009; Milieu Centraal 2026; §14].

**Box: What people say they notice** (NL: *Wat mensen zeggen te merken*)

Label on the box: *These are personal experiences, not measured results.
These complaints can have many causes; a meter shows whether stale air
could be one of them.* [non-specific symptoms: §4a]

| People say… | What studies found |
|---|---|
| "I wake up with a headache." | More headaches in stuffy rooms during the day [Zhang 2017]. The one bedroom study that asked about headaches found no difference [Strøm-Tejsen 2016]. |
| "I feel foggy and can't concentrate." | Studies disagree. Some found lower scores on a demanding decision test in stale or CO₂-rich air [Satish 2012; Allen 2016]; others did not [Rodeheffer 2018; Scully 2019; Chen 2023]. [§1a] |
| "I wake up tired." | In one study people felt more rested after better-ventilated nights [Strøm-Tejsen 2016]. |
| "I get irritable." [cut candidate] | Not studied for stuffy bedrooms. Poor sleep in general can affect mood [Palmer 2024]; whether the small sleep effects above are enough is not known [§2]. |

**Not used** (rated weak or unsupported in the report):
- "lowers IQ" or "reduced intelligence";
- chronic cognitive impairment;
- anxiety, depression or household tension as CO₂ effects;
- insomnia;
- "CO₂ narrows the airways".

**Visual:** simple sleep-stage bar (deep / light / awake), schematic, no
data values.

---

### Page 3 — CO₂: a sign of how fresh the air is

Budget: about 280 words.

- **Headline EN:** CO₂: a sign of how fresh the air is
- **NL:** CO₂: een teken van hoe fris de lucht is

**Where CO₂ comes from**

> Outdoor air contains about 425 ppm CO₂ [F1]. ("ppm" means parts per
> million; 1,000 ppm is 0.1% of the air.) Everyone breathes out CO₂,
> together with moisture and other substances from breath and skin. In a
> closed room they build up together. So the CO₂ level shows how well a
> room is ventilated for the number of people in it
> [ASHRAE 2025; HSE; Persily 2015; §3].

**You can't smell it** (NL: *Je ruikt het niet*)

> CO₂ has no smell at these levels. The stuffy smell comes from the other
> substances. After a few minutes in the room you stop noticing it, while
> someone coming in from outside notices it straight away
> [Gunnarsen & Fanger 1992; Zhang 2017; §4].

**Is CO₂ itself harmful?** (NL: *Is CO₂ zelf schadelijk?*)

> Not at the levels found in homes, as far as studies show.
>
> - In experiments where only pure CO₂ was added to well-ventilated rooms,
>   most studies found no effect on headaches, tiredness or simple tasks,
>   even at 5,000 ppm for a few hours [Zhang 2016; Zhang 2017; Chen 2023;
>   Fan 2023 (meta); §1a]. Tests of complex decision-making gave mixed
>   results [§1a].
> - Workplaces may average up to 5,000 ppm over a working day [F7].
> - CO₂ becomes poisonous only at tens of thousands of ppm, far above
>   home levels [F8].
>
> The advice to stay around 1,000–1,200 ppm is about fresh air. It goes
> back to the 1850s, when the scientist Max von Pettenkofer used CO₂ as a
> sign of stale air [F12].
>
> Studies lasted hours to weeks. No study has followed people at home
> levels for months or years [§1a, §5].

**What a CO₂ meter does not show** (NL: *Wat een CO₂-meter niet laat zien*)

> CO₂ is not a full measure of air quality [ASHRAE 2025]. Smoke, cooking
> fumes, fumes from paint or cleaning products, and damp are not measured
> by a CO₂ meter. An empty room shows low CO₂ even if its ventilation is
> poor (follows from how CO₂ builds up). Sleep researchers note that
> watching CO₂ alone may not be enough for undisturbed sleep
> [Akimoto 2025].

**Visual:** scale with a log-like break: home levels (400–3,000) → workplace
limit (5,000) → toxic (50,000+). Makes the difference in size visible.

---

### Page 4 — What level is good? Advice here and abroad

Budget: about 200 words plus the table.

- **Headline EN:** What level is good? Advice in the Netherlands and abroad
- **NL:** Welk niveau is goed? Advies in Nederland en daarbuiten

**Visual:** the colour scale from the infographic (option A).

**The Netherlands**

> The Netherlands has no legal CO₂ limit for homes. The building code
> sets how much ventilation a home must be able to provide, not a CO₂
> level [F4]. Dutch health bodies use 1,200 ppm as a sign that a room is
> not ventilated enough [F2]. Milieu Centraal: up to 750 ppm is good,
> between 750 and 1,200 ppm it could be better [F3].

**Other countries**

| Where | Value | Applies to | Status |
|---|---|---|---|
| Canada | 1,000 ppm, 24-hour average | homes | health ministry guideline |
| Germany | below 1,000 no concern; 1,000–2,000 elevated; above 2,000 unacceptable | indoor spaces including homes | federal environment agency guide values |
| Norway | 1,000 ppm | all indoor spaces (not industry) | recommended norm (FHI) |
| Flanders (Belgium) | 500 ppm above outdoor air (≈ 925 ppm) | homes and public buildings | guide value in a regional decree |
| Finland | 1,150 ppm above outdoor air (≈ 1,575 ppm) | homes | binding: authorities can act above this |
| Denmark [cut candidate] | 1,000 ppm (design) | schools, day care | building regulation BR18 §447 |
| France [cut candidate] | 800 ppm fine; above 1,500 act quickly | schools, childcare, care facilities | binding since 2023 |

Sources: Health Canada 2021; UBA 2008; FHI 2015; Binnenmilieubesluit annex
2018; Finnish Decree 545/2015; BR18 §447; Arrêté 27 Dec 2022 [§9]. The
approximate absolute values are `(calc)` with outdoor air at 425 ppm.

**Bedrooms**

> Sleep researchers advise keeping bedroom CO₂ below 1,000 ppm, preferably
> below 800 ppm. This is advice from the research group whose studies make
> up most of the evidence, not a legal limit [F6].

**How common is it in Dutch homes?** (NL: *Hoe vaak komt het voor?*)

> In a national study of about 1,200 Dutch homes, measured around 2006,
> almost half of main bedrooms went above 1,200 ppm at least once during
> the measured week [F9]. No newer national measurements were found.

**Not used:**
- "WHO <1,000 ppm": no current WHO value [§9];
- "ASHRAE <1,000 ppm": ASHRAE has no CO₂ limit [§9];
- "Gezondheidsraad <1,000 / 1,400 ppm" [§6];
- "40% of bedrooms >1,400 ppm (RIVM 2023)": not found [§7].

---

### Page 5 — Measure it yourself

Budget: about 260 words.

- **Headline EN:** Measure it yourself
- **NL:** Meet het zelf

**Lending block [TBD]** (NL: *CO₂-meter lenen*)

> Borrow a CO₂ meter: [where] · [for how long] · [how to reserve] ·
> [what you get: meter, short instruction].

Fallback line (works with or without the programme):

> Or buy one: a CO₂ meter costs about €80–300 [F13]. Milieu Centraal also
> advises measuring, or borrowing a meter, in the living room and
> bedrooms [Milieu Centraal 2026].

**Choose the right meter** (NL: *Kies de goede meter*)

> Choose a meter with an NDIR sensor. Meters that show "eCO₂" or "CO₂
> equivalent" do not measure CO₂; they estimate it from other gases
> [HSE; §10]. In Belgium such estimating meters may no longer be sold
> since March 2024 [Prevent, summary of Royal Decree of 7 Feb 2024; §10].

**Where to put it** (NL: *Waar zet je de meter?*)

> Guidance for workplaces and public buildings says:
> - at head height;
> - not next to a window, door or air inlet;
> - not right next to people: at least 0.5 m [HSE] to 1.5 m [Prevent].
>
> There is no specific guidance for bedrooms [§10]. In a bedroom, for
> example, on a cupboard or shelf away from the window and not next to
> your pillow (advice, adapted from the workplace guidance).
>
> Outdoors, a meter shows roughly 400–450 ppm: outdoor air is about
> 425 ppm [F1], and meters are not exact (range is an assumption, see
> open points).

**Read the night** (NL: *Lees de nacht terug*)

> Most meters store their readings. The next morning, look at the graph:
> - When did CO₂ start rising?
> - How high did it get?
> - Did it drop when a grille or window was opened?
>
> Then change one thing at a time, for example one night with the grille
> closed and one night with it open, and compare (advice).

**Visual:** example overnight graph. **[TBD]** Use a real measurement from
a test meter, with date and room described. Do not draw invented values.

---

### Page 6 — What helps and what doesn't

Budget: about 300 words.

- **Headline EN:** What helps and what doesn't
- **NL:** Wat helpt en wat niet

**What helps** (NL: *Dit helpt*)

> - **Grilles open.** Keep ventilation grilles open, day and night, all
>   year. They don't need to be fully open. Clean them at least once a
>   year [Milieu Centraal 2026].
> - **No grilles?** Put a small window slightly open when you are home
>   [Milieu Centraal 2026].
> - **Mechanical ventilation.** Leave the fan on at all times
>   [Milieu Centraal 2026]. Studies of new Dutch homes found systems were
>   often left on the lowest setting, partly because of noise, and often
>   delivered less air than required [RIVM 2009; RIGO 2009; BBA 2011; §7].
>   If your meter shows high values, try a higher setting (advice).
> - **Above 1,200 ppm?** Open the grille or window further
>   [Milieu Centraal 2026].

**This does not replace ventilation** (NL: *Dit vervangt ventileren niet*)

> - **Plants.** Plants do not measurably lower CO₂ in a home. Even in very
>   bright light you would need hundreds to more than a thousand plants to
>   take up the CO₂ of one person, and in the dark plants give off CO₂
>   [Gubb 2018; §11] (plant count is `(calc)` from Gubb's figures).
> - **Air purifier or air conditioner.** They clean or cool the air that
>   is already inside. They don't bring in outdoor air, so they don't
>   lower CO₂ [EPA; REHVA 2021; §13].
> - **Airing once a day.** Airing refreshes the air, but once the window
>   is closed, CO₂ rises again while people are in the room. As an
>   example: one adult in a closed bedroom of 30 m³ with no air leaking in
>   adds roughly 440 ppm per hour `(calc; Persily & de Jonge 2017; §12)`.
>   Real rooms leak some air, so the rise slows. Keep the grilles open as
>   well [Milieu Centraal 2026].

**Fresh air and moisture in winter** (NL: *Ventileren en vocht in de winter*)

> Ventilation also removes moisture, which lowers the risk of damp and
> mould [WHO 2009; UBA]. Indoor humidity of 40–60% is good [F14].
>
> A window left wide open on tilt for hours in winter cools the wall
> around it, which can cause condensation and mould. German advice is to
> air briefly with the window wide open, and keep grilles open
> [UBA "Wie lüfte ich richtig?"; §14].

**Subsidy** [cut candidate] (NL: *Subsidie*)

> Homeowners may get €400 ISDE subsidy for a CO₂-controlled or
> heat-recovery ventilation system, only together with an insulation
> measure (conditions 2026; check rvo.nl) [F15].

**Not used:**
- "10 minutes per hour" airing: no home source [§12];
- "only industrial CO₂ scrubbers work": not verified [§13];
- brand names;
- installation costs.

---

### Page 7 — Myths and related issues

Budget: about 300 words.

- **Headline EN:** Myths and facts
- **NL:** Fabels en feiten

| Myth | Fact | Sources |
|---|---|---|
| "CO₂ is harmless — we breathe it out anyway." NL: *"CO₂ is onschuldig, we ademen het toch uit."* | Partly true: at home levels, CO₂ itself is not poisonous. But high CO₂ means stale air, too little fresh air for the people in the room. In studies, people slept less deeply in such bedrooms. | §3, §1d |
| "I don't notice anything, so it's fine." NL: *"Ik merk niks, dus het zit goed."* | Your nose is not a good guide. CO₂ has no smell, and you stop noticing stale air within minutes. A meter shows what your nose misses. | Gunnarsen & Fanger 1992; Zhang 2017; §4 |
| "My house is old and draughty, so the air is fine." NL: *"Mijn huis is oud en tochtig, dus de lucht is prima."* | Not necessarily. In the national Dutch study (measured around 2006), living rooms in homes built between 1945 and 1970 had higher CO₂ than in newer homes. And many people seal gaps against draughts; then grilles or windows must bring in the air. | TNO 2007 [§7, §8]; Milieu Centraal 2026 |
| "Plants help a little." NL: *"Planten helpen een beetje."* | Not measurably. See page 6. | Gubb 2018 [§11] |
| "An air purifier with a CO₂ sensor is enough." NL: *"Een luchtreiniger met CO₂-sensor is genoeg."* | The sensor can show the problem, but the purifier doesn't fix it: it brings in no outdoor air. | EPA [§13] |

**Box: CO is something else** (NL: *CO is iets anders*)

> CO (carbon monoxide) is a different gas. It can come from appliances
> that burn fuel, such as a central-heating boiler, geyser, gas fire, stove
> or open fireplace, when they don't work properly or lack fresh air. It is
> poisonous even for a short time.
> Every year 5 to 10 people in the Netherlands die from it and hundreds go
> to hospital. The first signs (headache, dizziness, nausea) look like flu
> [F11; Brandweer]. A CO alarm does not measure CO₂, and a CO₂ meter does
> not warn you about CO: they do different jobs [§15].

**Box: other substances** [cut candidate] (NL: *Andere stoffen*)

> Fumes from paint, furniture, cleaning and personal-care products and
> cooking (VOCs) are not measured by a CO₂ meter either. Ventilation lowers
> both [UBA 2020; Milieu Centraal 2026; EPA; §16].

**Not used:**
- "VOCs are mostly in kitchens" [§16];
- activated-carbon filters and CO₂ (no source found) [§16];
- "CO effects are immediately visible" [§15].

---

### Page 8 — Sources and colophon

Budget: full page.

- **More information** (NL: *Meer weten?*):
  - Milieu Centraal ventilation pages;
  - RIVM "Binnenmilieu in woningen";
  - Brandweer.nl "Koolmonoxide";
  - URLs [TBD, check before print].
- **Sources:** numbered list built from the tags above. Short citation plus
  DOI or URL. Full list also on the landing page. Format [TBD].
- **QR code** to the landing page.
- **Colophon [TBD]:**
  - publisher line without party or fraction name;
  - date of the text;
  - "sources checked on 2026-09-15";
  - note that the booklet is general information, not medical advice.

---

## 4. Changes compared with `input2.txt`

| `input2.txt` item | How the script puts it | Why | Report |
|---|---|---|---|
| Core 1: poor ventilation, esp. bedrooms → poorer sleep and health issues | "In studies, people slept less deeply and woke up more often"; effect size stated; headaches/tiredness in stuffy rooms; damp and mould | Sleep supported with caveats, small effects; "health issues" made specific to what is sourced | §1b–1d, §14 |
| Core 2: poor ventilation strongly correlated with CO₂; CO₂ estimates ventilation | Kept; added what CO₂ does not show (other pollutants, empty room) | Well supported; ASHRAE and Akimoto note limits | §3, §1d |
| Core 3: norms <1,000 ppm for living spaces; NL lagging | Side-by-side comparison with setting and legal status per row; no "lagging" line | Binding values mostly for non-homes; NL value is 1,200; decision 2026-09-15 | §6, §9 |
| Relevance: stuffy classrooms | Kept as the hook, with school studies | Well supported (association, intervention studies included) | §17e |
| Relevance: more of a problem now we insulate | Mechanism only ("less air leaks in, grilles must do the work") | Measured trend is mixed | §8 |
| Relevance: rooms without windows / closed windows without grille | Kept as one sentence, marked as following from the mechanism | No specific study | §8, §12 |
| Ineffective: plants | Kept; "hundreds to more than a thousand, in very bright light; CO₂ given off in the dark" | "~100 per 10 m²" not supported | §11 |
| Ineffective: open windows once | Kept, with a worked example `(calc)` | Supported with caveats; no direct home measurement | §12 |
| Ineffective: AC, air filter | Kept as "does not bring in outdoor air" | Well supported in principle | §13 |
| VOCs mostly in kitchens; carbon filters don't apply to CO₂/NOx | VOCs from many products; CO₂ meter doesn't measure them; carbon-filter line dropped | "Mostly kitchens" weak; carbon filter not verified | §16 |
| CO: very poisonous, rare; CO detectors don't detect CO₂ | Numbers instead of "rare"; flu-like signs; different devices | Brandweer figures; "immediately visible" contradicted | §15 |
| Myth: CO₂ harmless → chronic >1,000 ppm impairs cognition | "Partly true: not poisonous, but a sign of stale air; sleep studies" | Chronic cognitive effect weak/unsupported | §1a, §3 |
| Myth: I don't feel anything → adapt without realising impairment | "Nose is not a good guide; no smell; you get used to stale air" | Only smell adaptation supported | §4 |
| Myth: old drafty house | Kept, backed by TNO build-year pattern | TNO 2007 | §7, §8 |
| Myth: plants help a little | Kept, points to page 6 | As above | §11 |
| Myth: air purifier with CO₂ sensor; only industrial scrubbers work | Kept without the scrubber line | Scrubber claim not verified | §13 |
| (from `input.txt`) symptoms | Anecdotal box with evidence per item | User decision 2026-09-15 | §1a–1d, §2 |
| (from `input.txt`) measuring, humidity, toxic levels vs 1,000 ppm | Pages 3, 5, 6 | User decision 2026-09-15 | §3, §10, §14 |

---

## 5. Open points

**Decisions for the user**
- Colour bands: option A or B (section 1).
- Cut candidates:
  - energy-crisis line (p1);
  - "irritable" row (p2);
  - Denmark and France rows (p4);
  - subsidy (p6);
  - VOC box (p7).
- Anecdotal box: keep all four rows, and keep the evidence column. The box
  has no source for how often people report these complaints. Stories from
  meter borrowers could replace the generic quotes later, with consent.

**Information needed [TBD]**
- Lending programme details (infographic footer, p5).
- Colophon and publisher line (no party name).
- A real overnight measurement for the p5 graph.
- Format of the source list (p8) and URLs to check before print.

**Evidence gaps that affect wording**
- Klausen 2023 (the only sleep study with pure CO₂) and the Xu 2021 methods
  are not read. The p3 line "not harmful at home levels, as far as studies
  show" leans on Akimoto 2025's summary for sleep.
- The Belgian meter decree itself was not retrieved; p5 cites the Prevent
  summary.
- No bedroom-specific meter placement guidance; p5 adapts workplace
  guidance and says so.
- "Outdoors a meter shows roughly 400–450 ppm": the range is an assumption
  (outdoor background plus meter tolerance), not sourced.
- Milieu Centraal advises a small window ajar when at home; UBA advises
  against windows left on tilt for hours in winter. The script uses both
  with "small window slightly open" vs "wide open on tilt for hours". Check
  the Dutch wording keeps that difference.
- Dutch bedroom data are from around 2006 (loggers at 2 m height, capped at
  3,000 ppm). No newer national data found.
- The report and archive are local only (`sources/archive/` is ignored by
  git). A tracked reference list is needed before publishing.

**Layout checks**
- Word budgets per page to be checked in Typst; Dutch text tends to run
  longer than English.
- Full Dutch text (B1) after content approval.

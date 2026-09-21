// "Why should you care now?" sheet, English. Structure is in whynow.typ.
// Source keys refer to sources/references.yml. Wording limits per block:
// whynow-storyline.md §3.

#import "/shared/facts.typ" as f

#let t = (
  lang: "en",
  title-plain: "Why should you care now?",
  title: [Why should you care now?],
  subtitle: [Our homes get warmer and cheaper to heat. And the fresh air?],

  // Sources: duijm2009 (p.19); tno2007; mc-ventilatie ("via naden en
  // kieren"). "Some fresh air", not "enough": TNO 2007 found older homes
  // also often above the Dutch reference value.
  b1-head: [Fresh air came in by itself],
  b1: [Older homes let air in through gaps around windows and doors, and
    through the letterbox. It cost heat, but it also brought in some fresh
    air, and nobody had to think about it.],

  // Sources: mc-natuurlijke, clo-isolatie (insulating, sealing);
  // mc-gascrisis2023 (heating less); ggd-zw2023, rivm-radon2024 (closing
  // grilles and windows: self-reports; RIVM calls it plausible, did not
  // measure it). Air conditioning is in block 6.
  b2-head: [We are closing the gaps],
  b2: [Energy is expensive, so we insulate, replace window frames and seal
    gaps. Many people heat less, and some keep grilles and windows shut.
    Good for the energy bill. But the fresh air that came in by accident is
    gone.],

  // Sources: mc-ventilatie, mc-mechanisch, mc-balans (system types, F16,
  // grilles must stay open); woon2012 (system by build period); bader2009,
  // rigo2009, bba2011 (lowest setting, noise); monicair2016, bba2011
  // ("usually better, if"). No build-year boundary: see
  // whynow-storyline.md §2.
  b3-head: [Which home do you have?],
  home-a-head: [Grilles above the windows, or no grilles],
  home-a: [Most homes, also many built after #f.balanced-since. Fresh air
    for the bedroom comes only through the grille or the window; a fan in
    the kitchen or bathroom often only takes air out in those spaces. Grille shut? Then hardly any
    fresh air comes in. And many people keep the fan on its lowest setting
    because of the noise.],
  home-b-head: [Supply vents in every room (balanced ventilation, HRV)],
  home-b: [About 1 in #f.balanced-one-in homes built since
    #f.balanced-since. The system brings fresh air to every room, also with
    the windows shut. Usually better, if it is well installed and not left
    on the lowest setting.],

  // Sources: koudijs2011; signalen2024; mc-natuurlijke; fisk2020;
  // foldvary2017. "Can", and no "drastic": the measured evidence is thin
  // and mixed, and there is no measured national trend.
  b4-head: [Good intentions, worse air],
  b4: [Insulating and saving energy are good things to do. But in a home
    of the first kind they can make the indoor air noticeably worse, without
    anyone meaning to.],

  // Sources: gunnarsen1992; zhang2017; duijm2009 (§3.5.5, §3.6.1).
  b5-head: [You don't notice it],
  b5: [You get used to stale air within minutes. Health
    complaints related to air quality are vague and hard to link to the air. A CO₂ meter shows
    what you cannot sense.],

  // Sources: ggd-handinhand2020 (the literal phrase); mc-woning, duijm2009
  // p.60 (airing gives a short improvement only); rivm-ventilatie;
  // mc-mechanisch. The two lines are corrections, not claims about how
  // many people believe otherwise. The airco line says what the device
  // does, not that people keep windows shut because of it: no source found
  // for that. No ownership figure: CBS 2024 gives about 12% nationally but
  // 7% in very urban municipalities and under 5% in rental homes, so a
  // national figure would overstate it for Diemen. "Keep the grilles open"
  // is in block 3, card A.
  b6-head: ["Insulation and ventilation go hand in hand". But what is ventilating?],
  b6-intro: [What the advice often leaves unsaid:],
  b6-points: (
    [Ventilating means fresh outdoor air coming in day and night.
      Airing a room for a short while is not the same.],
    [An air conditioner does not ventilate. It cools the air in the room
      but brings in no fresh air.],
  ),

  closing-head: [That is why we ask for attention],
  closing: [We, members of the city council of Diemen, want clear
    information about what ventilating means in your kind of home, and CO₂
    meters that residents can borrow. What can you do yourself? Read the
    guide.],
  sources-line: [Sources: on the website, via the QR code.],
  colophon: [An initiative of members of the Diemen city council · September 2026],
  qr-caption: [The guide \ and our sources],
)

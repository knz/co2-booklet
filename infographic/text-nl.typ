// Infographic text, Dutch (draft, roughly B1, "je"). Structure is in
// infographic.typ. Translated from text-en.typ; headlines that already
// existed in script.md §2 are reused.

#import "/shared/facts.typ" as f
#import "/shared/style.typ": num, ppm

#let t = (
  lang: "nl",
  title-plain: "Frisse lucht in je slaapkamer? Meet het!",
  title: [Frisse lucht in je slaapkamer? Meet het!],
  subtitle: [CO₂ laat zien of er genoeg frisse lucht binnenkomt.],

  block1-head: [Bedompte lucht, slechter slapen],
  block1: [In onderzoeken sliepen mensen minder diep en werden ze vaker
    wakker in slecht geventileerde slaapkamers. Te weinig frisse lucht
    vergroot ook de kans op vocht en schimmel.],

  block2-head: [CO₂ laat zien hoe fris de lucht is],
  block2: [Iedereen ademt CO₂ uit. Komt er te weinig frisse lucht binnen,
    dan loopt de CO₂ op. Je ruikt het niet, maar een CO₂-meter laat het
    zien.],

  block3-head: [Hoeveel is te veel?],
  band-labels: ([Goed], [Kan beter], [Te hoog: ventileer meer], [Nu actie]),
  marker-label: [#num(f.guide-abroad) ppm: advies in het buitenland en van slaaponderzoekers],
  outdoor-label: [buiten ≈ #num(f.outdoor)],
  unit-label: [ppm],
  levels: (
    [Nederland: het vroegere advies is om onder #ppm(f.nl-reference) te blijven.],
    [Andere landen, nieuwere richtlijnen: #ppm(f.guide-abroad) richtwaarde voor binnenlucht.],
    [Slaaponderzoekers: onder #ppm(f.bedroom-max) in slaapkamers.],
  ),

  helps-head: [Wat helpt],
  helps: (
    [Laat ventilatieroosters open, dag en nacht.],
    [Geen roosters? Zet een raam op een kier.],
    [Mechanische ventilatie: laat die aanstaan.],
    [WTW: frisse lucht binnen, kou blijft buiten. Ook per kamer mogelijk.],
  ),
  not-replace-head: [Dit vervangt ventileren niet],
  not-replace: (
    [Planten],
    [Luchtreiniger],
    [Airco],
    [Hooguit twee keer per dag luchten],
  ),

  footer-head: [Meet het zelf],
  lending: [Leen een CO₂-meter: \[waar\] · \[hoe lang\] · \[hoe reserveren\].],
  buy: [Of koop een meter met een "NDIR"-sensor (vanaf ongeveer € #f.meter-price-min).],
  sources-line: [Bronnen: zie de gids, via de QR-code.],
  colophon: [Uitgegeven door #f.publisher · september 2026],
  qr-caption: [Meer informatie \ en bronnen],
)

// Booklet text, Dutch (draft, roughly B1, "je"). Structure is in
// booklet.typ. Translated from text-en.typ; headlines that already existed
// in script.md §3 are reused. Section pointers (§) refer to the local
// literature report.

#import "/shared/facts.typ" as f
#import "/shared/style.typ": *

#let t = (
  lang: "nl",
  title-plain: "CO₂ in huis: meten, begrijpen, ventileren",
  title: [CO₂ in huis],
  subtitle: [meten, begrijpen, ventileren],

  // Kleurenschaal op pagina 4.
  band-labels: ([Goed], [Kan beter], [Te hoog: ventileer meer], [Nu actie]),
  marker-label: [#num(f.guide-abroad) ppm: advies in het buitenland en van slaaponderzoekers],
  outdoor-label: [buiten ≈ #num(f.outdoor)],
  unit-label: [ppm],

  p1: (
    // §17e
    hook-head: [Weet je nog, dat benauwde klaslokaal?],
    hook: [Denk aan een klaslokaal op een winterse middag: de ramen dicht en
      dertig kinderen binnen. De lucht voelde zwaar. Onderzoek op scholen
      laat zien dat betere ventilatie samengaat met betere toetsresultaten
      en minder verzuim#src("fisk2017", "haverinen2011", "wargocki2020").
      Hetzelfde kan thuis gebeuren, vooral in een slaapkamer met de deur en
      het raam dicht.],
    // §8
    why-head: [Waarom juist nu?],
    why: [Als een huis wordt geïsoleerd of als kieren worden dichtgemaakt,
      komt er minder lucht binnen via naden en kieren. Dan moeten roosters,
      ramen of een ventilatiesysteem de frisse lucht
      binnenbrengen#src("mc-natuurlijke", "signalen2024"). In een kamer
      zonder rooster, met het raam dicht, komt bijna geen frisse lucht
      binnen. #inference],
    about-head: [In dit boekje],
    about: [Waarom frisse lucht belangrijk is, hoe een CO₂-meter laat zien
      of je genoeg frisse lucht krijgt, en wat je zelf kunt doen.],
  ),

  p2: (
    head: [Waarom frisse lucht belangrijk is, vooral ’s nachts],
    // §1d
    sleep-head: [Slapen],
    sleep: [Onderzoek laat zien dat mensen bij minder frisse lucht (CO₂ van
      ongeveer 1.000 tot 2.500 ppm in de nacht) minder diep slapen en vaker
      wakker worden#src("stromtejsen2016", "fan2023sleep", "kang2024"). In
      één onderzoek voelden mensen zich ook meer uitgerust na nachten met
      betere ventilatie#src("stromtejsen2016").],
    // §1b–1c
    stuffy-head: [Bedompte kamers overdag],
    stuffy: [In bedompte, slecht geventileerde ruimtes hebben meer mensen
      last van hoofdpijn en vermoeidheid#src("zhang2017", "norback2013").],
    // §14
    damp-head: [Vocht en schimmel],
    damp: [Door ademen, koken en douchen komt er vocht in de lucht. Zonder
      genoeg ventilatie blijft dat vocht binnen. Daardoor is er meer kans op
      vocht en schimmel. Die hangen samen met luchtwegklachten, allergie en
      astma#src("who2009", "mc-woning").],
  ),

  p3: (
    head: [CO₂: een teken van hoe fris de lucht is],
    // §3
    where-head: [Waar komt CO₂ vandaan?],
    where: [Buitenlucht bevat ongeveer #ppm(f.outdoor) CO₂#src("noaa2025").
      ("ppm" betekent deeltjes per miljoen; 1.000 ppm is 0,1% van de lucht.)
      Iedereen ademt CO₂ uit, samen met vocht en andere stoffen uit adem en
      huid. In een gesloten kamer hopen die zich samen op. De CO₂-waarde
      laat dus zien hoe goed een kamer wordt geventileerd voor het aantal
      mensen dat er is#src("ashrae2025", "hse", "persily2015").],
    // §4
    smell-head: [Je ruikt het niet],
    smell: [CO₂ heeft bij deze waarden geen geur. De muffe geur komt van de
      andere stoffen. Na een paar minuten in de kamer ruik je het niet meer,
      terwijl iemand die van buiten binnenkomt het meteen
      ruikt#src("gunnarsen1992", "zhang2017").],
    harmful-head: [Is CO₂ zelf schadelijk?],
    harmful: [Een CO₂-vergiftiging op korte termijn komt pas voor bij
      #ppm(f.poisoning-min) of
      hoger#src("azuma2018", "permentier2017", "maniscalco2022"). De
      gevolgen van langdurige blootstelling aan verhoogde CO₂ (boven
      #ppm(f.longterm-concern)) worden nog
      onderzocht#src("lowther2021", "jacobson2019"). Sommige onderzoeken
      melden verminderde cognitieve prestaties#src("satish2012", "allen2016"),
      andere verhoogde chronische stress#src("kang2024", "jacobson2019").],
    scale-titles: ([Woningen], [Werkplekken], [Giftig]),
    scale-captions: (
      [Waarden die je thuis kunt tegenkomen],
      [#num(f.workplace-limit): grenswaarde voor werkplekken, gemiddeld over #f.workplace-hours uur],
      [Vanaf ongeveer #num(f.toxic-symptoms): hoofdpijn, duizeligheid,
        benauwdheid. #num(f.unconscious-min)–#num(f.unconscious-max):
        bewusteloosheid],
    ),
    scale-sources: [Waarden in de schaal: buitenlucht#src("noaa2025"),
      grenswaarde werkplek#src("arboregeling", "eu2006"),
      vergiftiging#src("niosh-idlh", "azuma2018").],
    not-shown-head: [Wat een CO₂-meter niet laat zien],
    not-shown: [CO₂ is geen volledige maat voor de
      luchtkwaliteit#src("ashrae2025"). Rook, kookdampen, dampen van verf of
      schoonmaakmiddelen en vocht meet een CO₂-meter niet.],
  ),

  p4: (
    head: [Welk niveau is goed? Advies in Nederland en daarbuiten],
    // §6
    nl-head: [Nederland],
    nl: [Nederland heeft geen wettelijke CO₂-grens voor woningen. De
      bouwregels stellen eisen aan hoeveel ventilatie een woning moet kunnen
      leveren, niet aan een CO₂-waarde#src("iplo-nieuwbouw", "iplo-bestaand").
      Nederlandse gezondheidsorganisaties gebruiken #ppm(f.nl-reference) als
      teken dat een ruimte niet genoeg wordt
      geventileerd#src("gezondheidsraad2010", "rivm-ggd2023"). Milieu
      Centraal: tot #ppm(f.mc-good-max) is goed, tussen
      #num(f.mc-good-max) en #ppm(f.nl-reference) kan het
      beter#src("mc-natuurlijke").],
    // §9
    abroad-head: [Andere landen],
    table-head: ([Waar], [Waarde], [Geldt voor], [Status]),
    rows: (
      (
        [Canada#src("healthcanada2021")],
        [#ppm(f.guide-abroad), gemiddelde over 24 uur],
        [woningen],
        [richtlijn van het ministerie van Volksgezondheid],
      ),
      (
        [Duitsland#src("uba2008")],
        [onder #num(f.guide-abroad) geen zorg;
          #num(f.guide-abroad)–#num(f.uba-elevated-max) verhoogd; boven
          #num(f.uba-elevated-max) onacceptabel],
        [binnenruimtes, ook woningen],
        [richtwaarden van het federale milieuagentschap],
      ),
      (
        [Noorwegen#src("fhi2015")],
        [#ppm(f.guide-abroad)],
        [alle binnenruimtes (niet industrie)],
        [aanbevolen norm (FHI)],
      ),
      (
        [Vlaanderen (België)#src("flanders2018")],
        [#ppm(f.flanders-above) boven de buitenlucht (≈~#ppm(f.flanders-abs))#note-cite(
            "calc-abroad",
            body: [Onze berekening: de waarde boven de buitenlucht plus
              buitenlucht van ongeveer #ppm(f.outdoor).],
          )#calc-tag],
        [woningen en publieke gebouwen],
        [richtwaarde in een gewestelijk besluit],
      ),
      (
        [Finland#src("finland545")],
        [#ppm(f.finland-above) boven de buitenlucht (≈~#ppm(f.finland-abs))#note-cite("calc-abroad")],
        [woningen],
        [bindend: de overheid kan ingrijpen boven deze waarde],
      ),
      (
        [Denemarken#src("br18")],
        [#ppm(1000) (ontwerp)],
        [scholen, kinderopvang],
        [bouwbesluit BR18 §447],
      ),
      (
        [Frankrijk#src("france2022")],
        [#ppm(800) is goed; boven #num(1500) snel actie],
        [scholen, kinderopvang, zorginstellingen],
        [bindend sinds 2023],
      ),
    ),
    bedrooms-head: [Slaapkamers],
    bedrooms: [Slaaponderzoekers adviseren om de CO₂ in de slaapkamer onder
      #ppm(f.bedroom-max) te houden, het liefst onder
      #ppm(f.bedroom-preferred). Wetenschappelijk bewijs wijst erop dat we
      onze wettelijke grenzen moeten herzien#src("akimoto2025").],
    // §7
    common-head: [Hoe vaak komt dit voor in Nederlandse huizen?],
    common: [In een landelijk onderzoek in ongeveer #num(f.tno-homes)
      Nederlandse woningen, gemeten rond #f.tno-year, kwam bijna de helft
      van de hoofdslaapkamers in de meetweek minstens één keer boven
      #ppm(f.nl-reference)#src("tno2007", "rivm2007").],
  ),

  p5: (
    head: [Meet het zelf],
    lending-title: [Leen een CO₂-meter],
    lending: [Leen een CO₂-meter: \[waar\] · \[hoe lang\] · \[hoe
      reserveren\] · \[wat je krijgt: meter, korte uitleg\].],
    buy: [Of koop er een: een CO₂-meter met NDIR-sensor is er vanaf ongeveer
      € #f.meter-price-min#note-cite("market-check", body: [Controle van
        Nederlandse en Europese webwinkels, 16 september 2026: meerdere
        meters waarvan de fabrikant een NDIR-sensor opgeeft, werden
        aangeboden vanaf ongeveer € #f.meter-price-min.
        Consumentenorganisatie Milieu Centraal noemt € 80–300.]). Milieu
      Centraal adviseert ook om te meten, of een meter te lenen, in de
      woonkamer en slaapkamers#src("mc-natuurlijke").],
    // §10
    choose-head: [Kies de goede meter],
    choose: [Kies een meter met een NDIR-sensor. Meters die "eCO₂" of
      "CO₂-equivalent" laten zien, meten geen CO₂: die schatten het op basis
      van andere gassen#src("hse").],
    place-head: [Waar zet je de meter?],
    place-intro: [Richtlijnen voor werkplekken en openbare gebouwen zeggen:],
    place-bullets: (
      [op hoofdhoogte;],
      [niet naast een raam, deur of luchtinlaat;],
      [niet vlak naast mensen: minstens 0,5 m#src("hse") tot 1,5 m#src("prevent").],
    ),
    place-note: [Voor slaapkamers is er geen aparte richtlijn. In een
      slaapkamer bijvoorbeeld op een kast of plank, weg van het raam en niet
      naast je kussen. #advice

      Buiten laat een meter ongeveer 400–450 ppm zien: buitenlucht is
      ongeveer #ppm(f.outdoor)#src("noaa2025"), en meters meten niet
      precies. #assumption],
    read-head: [Lees de nacht terug],
    read-intro: [De meeste meters slaan hun metingen op. Kijk de volgende
      ochtend naar de grafiek:],
    read-bullets: (
      [Wanneer begon de CO₂ te stijgen?],
      [Hoe hoog werd het?],
      [Daalde het toen een rooster of raam openging?],
    ),
    read-after: [Verander daarna steeds één ding, bijvoorbeeld één nacht met
      het rooster dicht en één nacht met het rooster open, en vergelijk. #advice],
  ),

  p6: (
    head: [Wat helpt en wat niet],
    // §12
    helps-head: [Dit helpt],
    helps: (
      [*Roosters open.* Laat ventilatieroosters open, dag en nacht, het hele
        jaar door. Ze hoeven niet helemaal open te staan. Maak ze minstens
        één keer per jaar schoon#src("mc-natuurlijke").],
      [*Geen roosters?* Zet een klein raam op een kier als je thuis
        bent#src("mc-natuurlijke").],
      [*Mechanische ventilatie.* Laat de ventilator altijd
        aanstaan#src("mc-woning"). Onderzoek in nieuwe Nederlandse woningen
        liet zien dat systemen vaak op de laagste stand stonden, deels door
        het geluid, en vaak minder lucht gaven dan
        vereist#src("bader2009", "rigo2009", "bba2011"). Laat je meter hoge
        waarden zien, zet hem dan een stand hoger. #advice],
      [*Boven #ppm(f.nl-reference)?* Zet het rooster of het raam verder
        open#src("mc-natuurlijke").],
    ),
    not-replace-head: [Dit vervangt ventileren niet],
    not-replace: (
      [*Planten.* Planten verlagen de CO₂ in huis niet merkbaar. Zelfs bij
        heel veel licht heb je honderden tot meer dan duizend planten nodig
        om de CO₂ van één persoon op te nemen, en in het donker geven
        planten juist CO₂ af#ourcalc("calc-plants", [aantal planten berekend
          uit de CO₂-opname per plant die Gubb e.a. maten bij heel veel
          licht, en ongeveer 30 g CO₂ per uur voor één persoon thuis
          (Persily & de Jonge).], "gubb2018", "persily2017").],
      [*Luchtreiniger of airco.* Die maken de lucht schoon of koel die al
        binnen is. Ze halen geen frisse buitenlucht naar binnen, en ze
        verlagen de CO₂ niet#src("epa", "rehva2021").],
      [*Hooguit twee keer per dag luchten (alleen ’s avonds, alleen
        ’s ochtends, of allebei).* Luchten ververst de lucht, maar zodra het
        raam dicht is, loopt de CO₂ weer op zolang er mensen in de kamer
        zijn. Een voorbeeld: één volwassene in een gesloten slaapkamer van
        #f.example-room-m3 m³ waar geen lucht bij komt, zorgt voor ongeveer
        #ppm(f.example-rise-per-hour) per uur
        erbij#ourcalc("calc-airing", [ongeveer 13 liter CO₂ per uur voor één
          volwassen man in rust (Persily & de Jonge), verdeeld over
          #f.example-room-m3 m³ lucht zonder luchtverversing.],
          "persily2017"). Slecht geïsoleerde kamers lekken wat lucht, dus de
        stijging gaat langzamer. In goed geïsoleerde kamers gaat de stijging
        sneller#src("signalen2024"). Laat de roosters ook open
        staan#src("mc-natuurlijke").],
    ),
    // §14
    moisture-head: [Frisse lucht en vocht in de winter],
    moisture: [Ventileren voert ook vocht af. Dat verkleint de kans op vocht
      en schimmel#src("who2009", "uba-lueften"). Een luchtvochtigheid binnen
      van #f.humidity-min–#f.humidity-max% is
      goed#src("uba-lueften", "mc-natuurlijke").

      Een raam dat in de winter urenlang wijd op de kiepstand staat, koelt
      de muur eromheen af. Daardoor kunnen condens en schimmel ontstaan. Het
      Duitse advies is om kort te luchten met het raam wijd open, en de
      roosters open te houden#src("uba-lueften").],
    // §17f
    subsidy-head: [Subsidie],
    subsidy: [Huiseigenaren kunnen € #f.isde-amount ISDE-subsidie krijgen
      voor een CO₂-gestuurd ventilatiesysteem of een systeem met
      warmteterugwinning, alleen samen met een isolatiemaatregel
      (voorwaarden #f.isde-year; kijk op rvo.nl)#src("rvo-isde").],
  ),

  p7: (
    head: [Fabels en feiten],
    table-head: ([Fabel], [Feit]),
    rows: (
      (
        [*"CO₂ is onschuldig, we ademen het toch uit."*],
        // §3, §1d
        [Deels waar: bij waarden die thuis voorkomen is CO₂ zelf niet
          giftig. Maar veel CO₂ betekent bedompte lucht: te weinig frisse
          lucht voor de mensen in de kamer#src("ashrae2025"). In onderzoeken
          sliepen mensen minder diep in zulke
          slaapkamers#src("fan2023sleep", "kang2024").],
      ),
      (
        [*"Ik merk niks, dus het zit goed."*],
        // §4
        [Je neus is geen goede gids. CO₂ heeft geen geur, en aan bedompte
          lucht wen je binnen een paar
          minuten#src("gunnarsen1992", "zhang2017"). Een meter laat zien wat
          je neus mist.],
      ),
      (
        [*"Mijn huis is oud en tochtig, dus de lucht is prima."*],
        // §7, §8
        [Niet per se. In het landelijke Nederlandse onderzoek (gemeten rond
          #f.tno-year) hadden woonkamers in huizen uit 1945–1970 juist meer
          CO₂ dan in nieuwere huizen#src("tno2007"). En veel mensen maken
          kieren dicht tegen de tocht; dan moeten roosters of ramen de lucht
          binnenbrengen#src("mc-natuurlijke").],
      ),
      (
        [*"Planten helpen een beetje."*],
        // §11
        [Niet merkbaar. Zie pagina
          #context counter(page).at(<what-helps>).first()#src("gubb2018").],
      ),
      (
        [*"Een luchtreiniger met CO₂-sensor is genoeg."*],
        // §13
        [De sensor laat het probleem zien, maar de reiniger lost het niet
          op: die haalt geen buitenlucht naar binnen#src("epa").],
      ),
    ),
    // §15
    co-title: [CO is iets anders],
    co: [CO (koolmonoxide) is een ander gas. Het kan vrijkomen bij apparaten
      die brandstof verbranden, zoals een cv-ketel, geiser, gaskachel,
      kachel of open haard, als die niet goed werken of te weinig frisse
      lucht krijgen. Het is al bij korte blootstelling giftig. Elk jaar
      overlijden in Nederland #f.co-deaths-min tot #f.co-deaths-max mensen
      eraan en gaan er honderden naar het ziekenhuis. De eerste klachten
      (hoofdpijn, duizeligheid, misselijkheid) lijken op
      griep#src("brandweer-co"). Een CO-melder meet geen CO₂, en een
      CO₂-meter waarschuwt niet voor CO: ze doen verschillend
      werk#src("co2meter2023").],
    // §16
    voc-title: [Andere stoffen],
    voc: [Dampen van verf, meubels, schoonmaakmiddelen,
      verzorgingsproducten en koken (VOS) meet een CO₂-meter ook niet.
      Ventileren verlaagt allebei#src("uba2020", "mc-woning", "epa").],
  ),

  p8: (
    head: [Meer weten?],
    links: (
      [Milieu Centraal, ventileren: #ref-url("mc-woning")],
      [RIVM, "Binnenmilieu in woningen": #ref-url("rivm-woningen")],
    ),
    qr-caption: [Meer informatie en bronnen],
    colophon-head: [Over dit boekje],
    colophon: [Uitgegeven door #f.publisher. \
      september 2026. \
      Bronnen gecontroleerd op 15 september 2026. \
      Dit boekje geeft algemene informatie. Het is geen medisch advies.],
    sources-head: [Bronnen],
    sources-note: [Wordt ook als lijst op de website gepubliceerd.],
  ),
)

#import "../../libs/peace-of-posters/lib.typ" as pop
#import "@preview/xarrow:0.3.0": xarrow
#import "@preview/fontawesome:0.6.0": fa-icon

#set page("a1", margin: 1cm)
#pop.set-poster-layout(pop.layout-a1)
#pop.set-theme(pop.psi-ch)
#set text(font: "arial", size: pop.layout-a1.at("body-size"))
#set enum(numbering: n => [*#numbering("a.", n)*])
#let box-spacing = 1.2em
#set columns(gutter: box-spacing)
#set block(spacing: box-spacing)
#pop.update-poster-layout(spacing: box-spacing)

#show bibliography: body => {
  show "_Personnellement_": [_Personnellement_]
  show "(Ed.). ": []
  body
}

#show table.cell.where(y: 0): strong
#set par(justify: true)

#v(-1.5em)
#pop.title-box(
  v(-1em)
    + [_Perso_, je trouve l'adverbe “perso” intéressant 😊 : analyse préliminaire de l'adverbe _perso_ dans les discours de réseaux sociaux],
  authors: "Shun Miyakoshi (Université de Tokyo, Japon) et Enzo Doyen (LiLPa)",
  authors-size: 0.4em,
  title-size: 1.3em,
  // institutes: "¹Center for Scientific Computing, Theory and Data, Paul Scherrer Institute, Switzerland   ²National Centre for Computational Design and Discovery of Novel Materials (MARVEL), Paul Scherrer Institute, Switzerland   ³Department of Chemistry, University of Zurich, Switzerland   ⁴Theory and Simulation of Materials, École Polytechnique Fédérale de Lausanne, Switzerland",
  logos: (
    v(1em) + image("../../media/logos/lilpa.png", width: 25%),
    box(
      image("../../media/logos/utokyo.svg", width: 20%),
    ),
    image("../../media/logos/jsps.svg", width: 13%),
  ),
  logo-gap: 5em,
  background-image: "../../media/backgrounds/sakura.svg",
  banner-height: 14.5%,
)

#v(-0.5em)

#let quote(
  content,
  fill: rgb(0, 0, 0, 40),
  stroke: none,
) = {
  box(
    fill: fill,
    stroke: stroke,
    inset: 0.5em,
    width: 100%,
  )[#content]
}

#let message(
  content,
  avatar-color: "#4A90D9",
  bg-color: rgb(0, 0, 0, 40),
) = {
  // avatar SVG src
  let svg-src = (
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
      + "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 40 40\">"
      + "<circle cx=\"20\" cy=\"20\" r=\"20\" fill=\""
      + avatar-color
      + "\"/>"
      + "<circle cx=\"20\" cy=\"15\" r=\"8\" fill=\"white\" opacity=\"0.88\"/>"
      + "<ellipse cx=\"20\" cy=\"37\" rx=\"13\" ry=\"11\" fill=\"white\" opacity=\"0.88\"/>"
      + "</svg>"
  )

  let avatar = box(
    width: 2.2em,
    height: 2.2em,
    clip: true,
    radius: 50%,
  )[#image(bytes(svg-src), format: "svg", width: 101%)]

  box(
    fill: rgb(bg-color).transparentize(25%),
    inset: 0.6em,
    width: 100%,
    radius: 5pt,
  )[
    #grid(
      columns: (2.2em, 1fr),
      column-gutter: 0.65em,
      align: (top, top),
      avatar,
      [
        #v(0.2em)
        #text(size: 0.9em)[#content]
      ],
    )
  ]
}

#let tweet(
  name: "Shun Miyakoshi",
  handle: "@shun_miyakoshi",
  avatar: "SM",
  avatar-color: rgb("#6c47d4"),
  content: [],
  time: "10:35 AM · Apr 30, 2026",
  verified: true,
) = box(
  fill: rgb("#161e27"),
  stroke: 1pt + rgb("#2f3b47"),
  radius: 16pt,
  inset: (x: 29pt, y: 16pt),
  width: 100%,
)[
  #set text(fill: rgb("#e7e9ea"))

  // Header: avatar / name / logo
  #grid(
    columns: (80pt, 1fr, 0.6fr, auto),
    column-gutter: 15pt,

    // circle avatar
    box(
      width: 80pt,
      height: 80pt,
      radius: 40pt,
      fill: avatar-color,
      clip: true,
    )[#align(center + horizon)[
      #text(fill: white, weight: "bold", size: 30pt)[#avatar]
    ]],

    // display name + handle
    align(horizon)[
      #text(weight: "bold", size: 30pt)[#name]
      #v(-0.5em)
      #text(fill: rgb("#71767b"), size: 28pt)[#handle]
    ],

    align(top)[(exemple forgé)],

    // top-right logo
    align(right + top)[
      #image("../../media/components/bsky.svg", width: 30%)
    ],
  )

  #v(12pt)

  #text(size: 70pt)[#v(-0.1em) #content]

  #v(14pt)
]

#columns(
  2,
  [
    #v(-0.7em)
    #pop.column-box(heading: "1. Introduction")[
      - Le lexème « *perso* » est une forme apocopée attestée dans plusieurs dictionnaires en ligne (Wiktionnaire, Larousse, Le Robert, Antidote, TLFi) : il peut être nom (apocope de « personnage »), adjectif (apocope de « personnel ») ou adverbe (apocope de « personnellement »), comme dans cet exemple :
      #v(-0.7em)
      #quote[*Perso*, je préfère le vin blanc du Jura ! (_exemple forgé_)]
      - Cet usage adverbial n'a, à notre connaissance, jamais été étudié spécifiquement dans les travaux portant sur les adverbes, y compris ceux traitant de « personnellement »@Molinier2003Personnellement ou « en personne »@schnedecker:hal-01353569. Seul Molinier (2003) donne l'exemple « Max joue trop perso. » (p. 367).
      - En raison de son appartenance au registre informel, nous nous appuyons sur le discours numérique@Paveau2017 des réseaux sociaux, pour comprendre et analyser cet usage.
    ]

    #v(-1em)
    #pop.column-box(heading: "2. Méthodologie")[
      - Collecte automatique de publications françaises contenant le lexème « perso » sur le réseau social #box(move(image("components/bsky.svg", width: 4%), dx: 0.1em)) BlueSky (alternative à X) via son API par la requête `"perso" lang:fr`.
      // #tweet(
      //   content: [#underline[Perso], je préfère le vin de Jura !],
      // )
      - Filtrage manuel des occurrences non adverbiales et annotation manuelle de *519* occurrences par position de l'adverbe @paillardGrammaireDiscursiveFrancais2021 et type d'emploi.
    ]

    #v(-1em)
    #pop.column-box(heading: "3. Analyse syntaxique : résultats")[
      #image("counts_d1.svg", width: 100%)
      #message(
        [#v(0.6em) *Perso* j'ai commencé à m'en défaire vers 25 ans.],
        avatar-color: "#406a91",
        bg-color: "4c78a8",
      )
      #message(
        //[Y’a rarement des bons changement de logos je trouve, mais en plus *perso* je range toutes mes appli par couleur […]],
        [[…] je ne prends *perso* aucun plaisir à afficher mes harceleurs et à dénoncer leurs contenus.],
        avatar-color: "#CC993D",
        bg-color: "f58518",
      )
      #message(
        [#v(0.6em) J’suis assez fan de ce format *perso*],
        avatar-color: "#43813C",
        bg-color: "#54a24b",
      )
    ]

    Selon *Molinier (2003, 361-363)*, « personnnellement » peut difficilement être combiné à un pronom autre que celui de 1ʳᵉ personne :

    #quote[*?* *Personnellement*, il est inquiet.]

    // Les occurrences récupérées montrent toutefois des usages différents pour « perso »…
    #v(-1em)
    #pop.column-box()[
      #v(-1.6em)
      #table(
        columns: (0.8fr, 0.9fr, 1fr, 1.35fr),
        stroke: 0.5pt,
        align: center,
        inset: 20pt,
        table.header(
          box(
            stroke: ("left": 10pt + rgb("#01295f")),
            outset: 15pt,
          )[P, je \ je, P#footnote[Inclut « P, […] me/mon/ma »…]],
          // p1s
          box(
            stroke: ("left": 10pt + rgb("ffb30f")),
            outset: 15pt,
          )[P, on \ on, P],
          // p1p
          box(
            stroke: ("left": 10pt + rgb("fd151b")),
            outset: 15pt,
          )[moi, P (je) \ P, moi (je)],
          // mp
          // pm
          box(
            stroke: ("left": 10pt + rgb("437f97")),
            outset: 15pt,
          )[P, il/ça/c'est… et ellipses],
          // other
        ),

        [464], [2], [9], [44],
      )

      // TODO: add strokes next to header, and reuse same strokes for quotes.
      // For now, just add the strokes and a few examples from the doc.
      // We'll see if we'll add more content later

      #quote(stroke: (
        "left": 10pt + rgb("#01295f"),
      ))[*Perso je* trouve que les héritiers qu’ils soient dans le luxe les affaires ou l’art ne devraient pas être]
      #quote(stroke: (
        "left": 10pt + rgb("ffb30f"),
      ))[*Perso on* coupe le TC [transport collectif] pour 5 ans  c'est juste comme ça que les crétins de quebecois peuvent comprendre]
      #quote(stroke: (
        "left": 10pt + rgb("fd151b"),
      ))[Ben ... *moi, perso*, je n'arrive pas à le voir autrement que comme une vaste blague […]]
      #quote(stroke: (
        "left": 10pt + rgb("437f97"),
      ))[Comme j'ai dit à une autre : ➡️Les médias desinforment, mesinforment. […] Et *perso*, dans cette histoire, y a pas qu’en Ehpad que les soignants doivent se vacciner. ]
    ]

    #v(-1em)
    #pop.column-box(heading: "4. Analyse sémantique")[
      « perso » présente sa portée comme repéré uniquement au locuteur au moment de l'énonciation.

      Notre analyse préliminaire met en évidence deux valeurs initiales possibles : #underline(stroke: rgb("CA6180"))[*valeur d'opinion personnelle*] et #underline(stroke: rgb("1F6F5F"))[*valeur de spécification personnelle*].

      #quote[Explosion des pistes cyclables, piétonnisation des berges […] #underline(stroke: rgb("CA6180"))[*Perso*], je trouve son bilan acceptable. 👍 | (perso $eq$ à mon avis)]

      #quote[Ce qui est marrant c'est que tu peux être trop pop pour les snobs et trop snob pour les pop, En même temps. #underline(stroke: rgb("1F6F5F"))[*Perso*] j'essaie de rester curieux sans être snobinard | (perso $eq.not$ à mon avis)]
    ]

    #pop.column-box(
      heading: "5. Bilan et perspectives",
    )[

      - Nécessité de comparer les usages de « perso » et « personnellement » dans un corpus plus large. Notre hypothèse (à creuser) est que « perso » n'est *pas* la simple forme tronquée de « personnellement », mais dispose d'autres fonctions propres.
      - D'autres adverbes formés avec la même finale *-o* seraient intéressants à étudier : _franco_, _directo_, _rapido_…
      - « perso » peut-il être considéré comme un marqueur discursif ?@paillardGrammaireDiscursiveFrancais2026 Si oui, de quel type ?
      - Possible utilisation d'outils de TAL pour une analyse automatique de la position et/ou du type.

    ]
    #v(-0.8em)
    #pop.bibliography-box(
      "../../posters/perso_sem_lilpa/perso.bib",
      //style: "../brief.csl",
      style: "../../apa-numeric.csl",
      body-size: 0.7em,
      title: [#fa-icon("books") Bibliographie],
    )
    #place(
      box(
        fill: rgb("#eee"),
        outset: 0.5em,
        width: 46em,
      )[#text(
        size: 0.7em,
      )[Cette étude est réalisée dans le cadre du JST SPRING (JPMJSP2108) et du Research Fellowship for Young Scientists (DC2, 25KJ0984) de JSPS.]],
      dy: 5.2em,
      dx: -16em,
    )
  ],
)
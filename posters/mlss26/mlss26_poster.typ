#import "../../libs/peace-of-posters/lib.typ" as pop
#import "@preview/xarrow:0.3.0": xarrow
#import "@preview/fontawesome:0.6.0": fa-icon

#set page("a0", margin: 2cm)
#pop.set-poster-layout(pop.layout-a0)
#pop.set-theme(pop.lilpa-dark)
#set text(font: "arial", size: pop.layout-a0.at("body-size"))
#set enum(numbering: n => [*#numbering("a.", n)*])
#let box-spacing = 1.2em
#set columns(gutter: box-spacing)
#set block(spacing: box-spacing)
#pop.update-poster-layout(spacing: box-spacing)

#show table.cell.where(y: 0): strong


#pop.title-box(
  [Constrained Decoding for Gender-Fair French Language Generation in LLMs],
  authors: "Enzo Doyen & Amalia Todirascu (LiLPa, University of Strasbourg)",
  authors-size: 0.6em,
  title-size: 1.6em,
  title-fill: white,
  logos: (
    image("../../media/logos/lilpa.png", width: 30%),
    box(
      image("../../media/logos/liric.svg", width: 22%),
      fill: rgb(
        "#fff",
      ).transparentize(20%),
      outset: 0.5em,
      radius: 0.5em,
      stroke: 0.08em + rgb("#bd146c").transparentize(16%),
    ),
  ),
  logo-gap: 10em,
  background-image: "../../media/backgrounds/peaks.svg",
  banner-height: 13%,
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

#let b(body, fill: black) = {
  text(weight: "bold", fill: fill)[#body]
}

#let color-short = rgb("#4C5BAD").saturate(80%)
#let color-coord = rgb("#A05828").saturate(80%)
#let color-neutral = rgb("#3E7A52").saturate(80%)

#columns(
  2,
  [
    #pop.column-box(heading: "1. " + [Introduction #fa-icon("angles-right")])[
      - Gender bias long studied in NLP, lately focusing on biases stemming from interactions with LLMs@kotekGenderBiasStereotypes2023 @ducelYoullBeNurse2024
      - One form of understudied gender bias in gender-marked languages (e.g. French, German, Polish) is the *masculine generics (MG)* bias, i.e. *the use of the masculine form as a default/neutral form to refer to mixed group of men/women*. Example in French: \ #box(
          fill: rgb(0, 0, 0, 40),
          inset: 0.5em,
          width: 100%,
        )[Les *étudiants*#super[MG] sont partis. (*Students*#super[MG] left.)]
      - Psycholinguistics studies have shown that *MG induce bias by amplifying male-centric mental representations* @gygaxExploringOnsetMaleBiased2019 @gastilGenericPronounsSexist1990 @miserskyGrammaticalGenderGerman2019
      - In generic conversational contexts, *LLMs also use MG* @doyenManMadeLanguage2025 @schmidtTacklingGenericMasculine2026 and are *reluctant to using gender-fair language (GFL)* @doyenManMadeLanguage2025. Existing mitigation to reduce MG and promote GFL (e.g. gender rewriting @doyenGeNReFrenchGenderNeutral2025 @velosoRewritingApproachGender2023) operates only via post-processing, which fails to prevent the initial generation of biased text
      - We propose a set of inference-based systems to promote GFL in French
    ]

    #v(-2em)
    #pop.column-box()[#image(
      "components/llm_inclusive_gfl_cg.pdf",
      width: 206%,
      height: 20%,
    )]

    #v(-1em)
    #pop.column-box(
      heading: "3. Preliminary Findings " + fa-icon("microscope"),
    )[
      - Tested with Llama 3.1 (8B), Ministral 3 (14B), EuroLLM (22B) & Qwen 3.5 (35B); Qwen 3.5 (2B) as context verifier model
      - Example with prompt "How much do students earn?" #text(size: 0.8em)[(_Combien les étudiants gagnent-ils ?_)]
      #v(-0.5em)
      #table(
        columns: (1fr, 1fr),
        column-gutter: 8pt,
        align: top + center,
        table.header(
          [Vanilla (Llama 3.1)],
          [Constrained (hardforward, #text(fill: color-short)[short])],
        ),
        table.cell[#text(size: 0.85em)[
          Le montant des allocations pour #highlight[les étudiants] en France peut varier en fonction de plusieurs facteurs, tels que la région d'habitation […] Cependant, en France, #highlight[les étudiants] peuvent être éligibles à plusieurs types de bourses d'études […]]],
        table.cell[#text(size: 0.85em)[
          Le montant des allocations pour #highlight[les étudiant·es] en France varie en fonction de plusieurs facteurs tels que la région d'habitation […] Cependant, en France, #highlight[les étudiant·es] peuvent bénéficier d'une aide financière appelée bourse études […]]],
      )

      - Interestingly, initial GFL forcing is sometimes enough to nudge the model to generate GFL by itself (e.g. when the constraint is applied at the beginning (first 1/2 forcings) and later fully removed)
      #v(-1em)
      #move(line(length: 100%, stroke: 3pt + black), dy: 1em)
      #v(0.5em)
      - Performance without verifier close to vanilla model; with verifier, close to double pass on same model for rewriting
      #v(-1em)
      #figure(image("overhead_plot_h.svg", width: 105%))
    ]

    #pop.column-box(heading: "2. " + [Methodology #fa-icon("arrow-progress")])[
      - *3 main constrained decoding systems* with 3 different strategies a/b/c:
        1. #b(fill: color-short)[short]: force gender-fair short suffix (e.g., 'étudiant·es')
        2. #b(fill: color-coord)[coord]: force coordinated gendered pairs (e.g. 'étudiants et étudiantes') \ #text(size: 0.8em)[(→ different forcing modes to force (1) conjunction only, (2) conjunction + first token or \ (3) conjunction + full paired word)]
        3. #b(fill: color-neutral)[neutral]: force gender-neutral form (e.g. 'corps étudiant' [_student body_])

      #table(
        columns: (1.1fr, 2.5fr, 1.5fr),
        inset: 12pt,
        stroke: .5pt + gray,
        align: center + horizon,

        table.header([*System*], [*Mechanism*], [*Strategies*]),

        [*hardforward*],
        [Forces MG about to be generated into gender-fair form],
        [
          #b(fill: color-short)[short], #b(fill: color-coord)[coord]
        ],

        [*hardbacktrack*],
        [
          Backtracks after a MG has been generated and replaces it with a gender-fair form
        ],
        [
          #b(fill: color-short)[short], #b(fill: color-coord)[coord], \ #b(fill: color-neutral)[neutral]
        ],

        [*hardexclusion*],
        [Bans MG tokens with `NoBadWordsLogitsProcessor`],
        [—],
      )
    ]

    #pop.column-box()[#v(16.4em)]

    #pop.column-box(
      heading: "4. Prospects "
        + fa-icon("person-walking-dashed-line-arrow-right"),
    )[
      - Continued development of all 3 systems, particularly hardbacktrack and hardexclusion
      - Future evaluation of all systems through a three-dimensional Pareto analysis:
        $
          hat(M) = frac("MG", "HN") #h(4cm) hat(I) = frac("I", "HN") #h(4cm) hat(N) = frac("N", "HN")
        $
        where $"HN"$ = human noun, $I$ = inclusive form, and $N$ = neutral form; minimizing $hat(M)$ and maximizing $hat(I)$, $hat(N)$
      - Comparison with vanilla models to evaluate coherent generation and LLM instruction-following abilities
      - Comparison with models fine-tuned on gender-fair instruction responses

    ]
    #v(-0.8em)
    #pop.bibliography-box(
      "../../references.bib",
      //style: "../brief.csl",
      style: "../../apa-numeric.csl",
      body-size: 0.7em,
      title: [#fa-icon("books") References],
    )

    #box(
      fill: rgb("#eee"),
      outset: 10pt,
    )[#text(
      size: 0.7em,
    )[This work of the Interdisciplinary Thematic Institute LIRIC, as part of the ITI 2021-2028 program of the University of Strasbourg, CNRS and Inserm, was supported by IdEx Unistra (ANR-10-IDEX-0002), and by SFRI-STRAT’US project (ANR-20-SFRI-0012) under the framework of the French Investments for the Future Program.]]
  ],
)

#import "../../libs/peace-of-posters/lib.typ" as pop
#import "@preview/xarrow:0.3.0": xarrow
#import "@preview/fontawesome:0.6.0": fa-icon
#import "@preview/alexandria:0.2.2": *

#show: alexandria(prefix: "x-", read: path => read(path))

#set page(height: 24in, width: 36in, margin: 1cm)
#pop.set-poster-layout(pop.layout-us-legal)
#pop.set-theme(pop.lilpa-dark)
#set text(font: "arial", size: pop.layout-us-legal.at("body-size"))
#set enum(numbering: n => [*#numbering("a.", n)*])
#let box-spacing = 1.2em
#set columns(gutter: box-spacing)
#set block(spacing: box-spacing)
#pop.update-poster-layout(spacing: box-spacing)

#show table.cell.where(y: 0): strong

#let b(body, fill: black) = {
  text(weight: "bold", fill: fill)[#body]
}

#let color-short = rgb("#4C5BAD").saturate(80%)
#let color-coord = rgb("#A05828").saturate(80%)
#let color-neutral = rgb("#3E7A52").saturate(80%)

#pop.title-box(
  [#h(1em) Constrained Decoding for Gender-Fair French Language Generation in LLMs],
  authors: [#h(1.5em) Enzo Doyen & Amalia Todirascu (LiLPa, University of Strasbourg)],
  authors-size: 0.6em,
  title-size: 1.6em,
  title-fill: white,
  logos: (
    image("../../media/logos/lilpa.png", width: 23%),
    box(
      image("../../media/logos/liric.svg", width: 18%),
      fill: rgb("#fff").transparentize(20%),
      outset: 0.5em,
      radius: 0.5em,
      stroke: 0.08em + rgb("#bd146c").transparentize(16%),
    ),
    image("../../media/logos/columbia.svg", width: 24%)
  ),
  logo-gap: 8em,
  background-image: "../../media/backgrounds/peaks.svg",
  banner-height: 23%,
)

#let inline-bibliographyx(prefix, sep: [ \/ ]) = context {
  let bib = get-bibliography(prefix)
  let items = bib.references.map(e => {
    // emit the label so in-text @x-key citations still resolve to here
    let anchor = [#metadata(none)#label(bib.prefix + e.key)]
    // box ONLY the [n] so the number never splits across a line break
    let number = if e.first-field != none { hayagriva.render(e.first-field) }
    [#box[#anchor#number]~#hayagriva.render(e.content)]
  })
  items.join(sep)
}


#v(-0.5em)

#columns(
  3,
  [
    #pop.column-box(heading: "1. " + [Introduction #fa-icon("angles-right")])[
      - Gender bias long studied in NLP, lately focusing on biases stemming from interactions with LLMs #citegroup(prefix: "x-")[@x-kotekGenderBiasStereotypes2023 @x-ducelYoullBeNurse2024]
      - An understudied bias in gender-marked languages (e.g., French, German, Polish) is the *masculine generics (MG)* bias: *using the masculine form as a default/neutral form to refer to a mixed group of men/women*. Example in French: \ #box(
          fill: rgb(0, 0, 0, 40),
          inset: 0.5em,
          width: 100%,
        )[Les *étudiants*#super[MG] sont partis. (*Students*#super[MG] left.)]
      - Psycholinguistic studies show *MG amplify male-centric mental representations* #citegroup(prefix: "x-")[@x-gygaxExploringOnsetMaleBiased2019 @x-gastilGenericPronounsSexist1990 @x-miserskyGrammaticalGenderGerman2019]
      - In generic conversational contexts, *LLMs also use MG* #citegroup(prefix: "x-")[@x-doyenManMadeLanguage2025 @x-schmidtTacklingGenericMasculine2026] and are *reluctant to use gender-fair language (GFL)*@x-doyenManMadeLanguage2025. Existing mitigations (e.g. gender rewriting #citegroup(prefix: "x-")[@x-doyenGeNReFrenchGenderNeutral2025 @x-velosoRewritingApproachGender2023]) operate only as *post-processing*, which fails to prevent the initial generation of biased text
      - *We propose a set of inference-based systems using constrained generation to promote GFL in French*
    ]

    #pop.column-box()[#v(-2.2em) #align(left)[#image(
      "components/llm_inclusive_gfl_cg_compact.pdf",
      width: 206%,
      //height: 25%,
    )]
    #box(width: 206%)[#v(-3em) #pop.column-box(heading: [#fa-icon("books") References])[
  #set text(size: 0.6em)
  #set par(justify: false)
  #load-bibliography("../../references.bib", style: "../../brief.csl")
  #inline-bibliographyx("x-")
  #line(length: 100%)
    #box(
      fill: rgb("#eee"),
      outset: 8pt,
      width: 100%
    )[#text[This work of the Interdisciplinary Thematic Institute LIRIC, as part of the ITI 2021-2028 program of the University of Strasbourg, CNRS and Inserm, was supported by IdEx Unistra (ANR-10-IDEX-0002), and by SFRI-STRAT'US project (ANR-20-SFRI-0012) under the framework of the French Investments for the Future Program.]]
]]
    ]

    #pop.column-box(heading: "2. " + [Methodology #fa-icon("arrow-progress")])[
      - *3 constrained decoding systems* with 3 strategies a/b/c:
        1. #b(fill: color-short)[short]: force a gender-fair short suffix (e.g. 'étudiant·es')
        2. #b(fill: color-coord)[coord]: force coordinated gendered pairs (e.g. 'étudiants et étudiantes') #text(size: 0.8em)[(forcing modes: (1) conjunction only, (2) conjunction + first token, (3) conjunction + full paired word)]
        3. #b(fill: color-neutral)[neutral]: force a gender-neutral form (e.g. 'corps étudiant' [_student body_])

      #table(
        columns: (1.2fr, 2.5fr, 1.3fr),
        inset: 10pt,
        stroke: .5pt + gray,
        align: center + horizon,

        table.header([*System*], [*Mechanism*], [*Strategies*]),

        [*hardforward*],
        [Forces an MG about to be generated into a gender-fair form],
        [#b(fill: color-short)[short], #b(fill: color-coord)[coord]],

        [*hardbacktrack*],
        [Backtracks after an MG has been generated and replaces it with a gender-fair form],
        [#b(fill: color-short)[short], #b(fill: color-coord)[coord], #b(fill: color-neutral)[neutral]],

        [*hardexclusion*],
        [Bans MG tokens with `NoBadWordsLogitsProcessor`],
        [—],
      )
    ]

    #pop.column-box(
      heading: "3. Preliminary Findings " + fa-icon("microscope"),
    )[
      - Tested with Llama 3.1 (8B), Ministral 3 (14B), EuroLLM (22B) & Qwen 3.5 (35B); Qwen 3.5 (2B) as context-verifier model
      - Example with prompt "How much do students earn?" #text(size: 0.8em)[(_Combien les étudiants gagnent-ils ?_)]
      #v(-0.4em)
      #table(
        columns: (1fr, 1fr),
        column-gutter: 6pt,
        align: top + center,
        table.header(
          [Vanilla #text(size: 0.8em)[(Llama 3.1)]],
          [Constrained #text(size: 0.8em)[(hardforward, #text(fill: color-short)[short])]],
        ),
        table.cell[#text(size: 0.8em)[Le montant des allocations pour #highlight[les étudiants] en France peut varier en fonction de plusieurs facteurs […] Cependant, #highlight[les étudiants] peuvent être éligibles à plusieurs types de bourses d'études […]]],
        table.cell[#text(size: 0.8em)[Le montant des allocations pour #highlight[les étudiant·es] en France varie en fonction de plusieurs facteurs […] Cependant, #highlight[les étudiant·es] peuvent bénéficier d'une aide financière appelée bourse d'études […]]],
      )
      - Initial GFL forcing is sometimes enough to *nudge the model into generating GFL on its own* (i.e., when the constraint is applied only for the first 1/2 forcings and then fully removed)
      - Performance benchmark on Llama 3.1 on H200, with 30 MG + 30 non-MG prompts, mean of 10 runs per condition:
      //#v(-0.5em)
      #table(
        columns: (1fr, auto, auto),
        align: (left, right, right),
        stroke: none,
        inset: (x: 8pt, y: 4pt),
        table.hline(stroke: 0.8pt),
        table.header([*Condition*], [*Overhead (×)*], [*ms/tok*]),
        table.hline(stroke: 0.5pt),
        [Vanilla], [1.00], [8.9],
        [GFL LogitProc. (hf)], [1.04], [9.3],
        [Post-Gen Rewrite], [2.02], [18.0],
        [GFL LogitProc. + Verifier (hf)#super[†]], [2.07], [18.4],
        [Post-Gen Rewrite (long sysprompt)], [2.07], [18.4],
        table.hline(stroke: 0.8pt),
    )
    #v(-0.5em)
    #text(size: 0.85em)[† Between 5 (MG) and 2 (non-MG) mean verifier calls.]

    ]

    #pop.column-box(
      heading: "4. Prospects "
        + fa-icon("person-walking-dashed-line-arrow-right"),
    )[
      - Evaluation via a three-dimensional Pareto analysis:
        $
          hat(M) = frac("MG", "HN") #h(1.2cm) hat(I) = frac("I", "HN") #h(1.2cm) hat(N) = frac("N", "HN")
        $
        where $"HN"$ = human noun, $I$ = inclusive form, $N$ = neutral form; minimizing $hat(M)$ and maximizing $hat(I)$, $hat(N)$
      - Comparison with vanilla models (coherent generation, instruction-following) and with models fine-tuned on gender-fair instruction responses
    ]

    // #pop.bibliography-box(
    //   "../../typst-slides-collection/phd/phd.bib",
    //   style: "../apa-numeric.csl",
    //   body-size: 0.6em,
    //   title: [#fa-icon("books") References],
    // )
  ],
)

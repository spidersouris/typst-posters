#import "../../libs/peace-of-posters/lib.typ" as pop
#import "@preview/xarrow:0.3.0": xarrow

#set page("a0", margin: 2cm)
#pop.set-poster-layout(pop.layout-a0)
#pop.set-theme(pop.psi-ch)
#set text(font: "arial", size: pop.layout-a0.at("body-size"))
#set enum(numbering: n => [*#numbering("a.", n)*])
#let box-spacing = 1.2em
#set columns(gutter: box-spacing)
#set block(spacing: box-spacing)
#pop.update-poster-layout(spacing: box-spacing)

#pop.title-box(
  "GeNRe: A French Gender-Neutral Rewriting System Using Collective Nouns",
  authors: "Enzo Doyen & Amalia Todirascu (LiLPa / University of Strasbourg, France)",
  authors-size: 0.6em,
  title-size: 1.9em,
  // institutes: "¹Center for Scientific Computing, Theory and Data, Paul Scherrer Institute, Switzerland   ²National Centre for Computational Design and Discovery of Novel Materials (MARVEL), Paul Scherrer Institute, Switzerland   ³Department of Chemistry, University of Zurich, Switzerland   ⁴Theory and Simulation of Materials, École Polytechnique Fédérale de Lausanne, Switzerland",
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
    image("components/acl_logo.png", width: 24%),
  ),
  logo-gap: 4em,
  background-image: "../../media/backgrounds/blue_dots.svg",
  banner-height: 15%,
)

#v(-0.5em)

#columns(
  2,
  [

    #pop.column-box(heading: "1. Introduction")[
      - Masculine generics (MG) in gender-marked languages (e.g., French, German, Dutch): use of the masculine form as a default/neutral form to refer to mixed group of men/women. Examples in French: \ #box(fill: rgb(0, 0, 0, 40), inset: 0.5em, width: 100%)[(a) « Les *étudiants*#super[MG] sont partis. » (*Students*#super[MG] left.)]
      - Psycholinguistics studies show that *MG induce gender bias* and *amplify male-centric mental representations* @braunCognitiveEffectsMasculine2005 @gygaxMasculineFormIts2012
      - Task of *gender rewriting*: propose alternatives to gendered sentences to balance datasets and reduce use of MG and related biases
    ]

    #pop.column-box(heading: "2. Task of Gender Rewriting")[
      - *Three types* of existing gender rewriting systems: *neutral* rewriting (English@vanmassenhoveNeuTralRewriterRuleBased2021 @sunTheyThemTheirs2021), *inclusive* rewriting (French@lernerINCLUREDatasetToolkit2024, Portuguese@velosoRewritingApproachGender2023, German@pomerenkeINCLUSIFYBenchmarkModel2022) and *gender-switching* rewriting (Arabic@habashAutomaticGenderIdentification2019)
      - *No neutral rewriting system for French*, and *collective nouns (gender-fixed in French) not tested* as potentially good candidates for gender-neutralization
      - Automatically switching from MG to collective nouns in French requires *number and gender changes, re-inflection*
      #box(
        grid(
          columns: (1fr, 1cm, 1fr),
          gutter: 0.9em,
          align: center,
          grid.header(
            [#text(weight: "bold")[Masculine generics]],
            [],
            [#text(weight: "bold")[Collective noun]],
          ),

          [#underline(offset: 0.2em)[Tous les anciens employés#super[MG] \ sont invités] au programme. #linebreak() (_#underline(offset: 0.2em)[All former employees#super[MG] \ are invited] to the program_.)],
          [#move(text(size: 2em, weight: "bold")[→], dy: 1em)],
          [#underline(offset: 0.2em)[L'ancien personnel \ est invité] au programme. #linebreak() (_#underline(offset: 0.2em)[Former staff \ is invited] to the program_.)],
        ),
        fill: rgb(0, 0, 0, 40),
        outset: (left: -0.5em, right: 0em, top: 0.5em, bottom: 0.5em),
      )
    ]

    #pop.column-box(heading: "3. Methodology")[
      1. Create a French member noun-collective noun dictionary based on the work of *Lecolle (2019)*@lecolleNomsCollectifsHumains2019, corpus search and scraping (*315* entries total)
      #v(-0.5em)
      #table(
        columns: (2fr, 2fr),
        table.header(
          text(weight: "bold")[Member noun],
          text(weight: "bold")[Collective noun],
        ),
        inset: 6pt,
        align: horizon + center,
        [employés (_employees_)], [personnel (_staff_)],
        [jurés (_jury members_)], [jury],
        [policiers (_police officers_)], [police],
        [soldats (_soldiers_)], [armée (_army_)],
        […], […],
      )
      // #v(-0.5em)
      // 2. Extract sentences containing MG member nouns in French Wikipedia and Europarl datasets (*398,954* sentences)
      #v(-0.5em)
      2. Use 3 approaches: RBS (*_spaCy_* @honnibalSpaCyIndustrialstrengthNatural2023 for syntactic dependency detection; *_inflecteur_*@chuttarsingInflecteur2021 for re-inflecting); fine-tuned models (M2M100/T5) and instruct-based model (Claude 3 Opus)
      #v(-0.5em)
      #image("figures/genre_systems.svg", width: 95%)


      // 2. Analyze MG use in 6 LLMs' outputs to generic instructions \ #text(
      //     size: 0.9em,
      //   )[#sym.dot.circle Use human/AI-written generic instruction datasets and remove specific contexts with spaCy @montaniSpaCyIndustrialstrengthNatural2024 (dependency parsing and NER)

      //     #text(size: 0.9em)[#sym.dot.circle Like instructions, filter responses to remove specific contexts]

      //     #text(size: 0.9em)[#sym.dot.circle Validate HNs in outputs using GPT-4o mini, JSON-constrained]

      //     #text(size: 0.9em)[#sym.dot.circle Compute score for each text; as well as mean (average bias per text) and overall (average bias per LLM) scores]

      //   ]

      // $ "MScore"_i = frac("mg_count"_i, "hn_count"_i) $

      // #align(
      //   center + horizon,
      //   grid(
      //     columns: 2,
      //     gutter: 5.5em,
      //     grid.cell(
      //       inset: 0em,
      //       align: center,
      //       text("Overall", size: 0.8em, weight: "bold"),
      //     ),
      //     grid.cell(
      //       inset: 0em,
      //       align: center,
      //       text("Mean", size: 0.8em, weight: "bold"),
      //     ),
      //   )
      //     + v(-1em)
      //     + grid(
      //       columns: 2,
      //       gutter: 2em,
      //       grid.cell(
      //         inset: 0.5em,
      //         align: center,
      //         $ frac("total_mg", "total_hn") $,
      //       ),

      //       grid.cell(
      //         inset: 0em,
      //         align: center,
      //         $ frac(1, "n") sum_(i=1)^n "MScore"_i $,
      //       ),
      //     ),
      // )



    ]

    #colbreak()

    #pop.column-box(heading: "4. Evaluation and Results")[
      - Evaluation dataset of 500 sentences (250 Wikipedia/250 Europarl)
      - *RBS Dependency Detection Component*: Manually annotated syntactic dependencies in evaluation sentences \ #move(dx: 1em, dy: -0.5em)[#sym.circle.dotted Objective: evaluate correct detection of syntactic dependencies of the member noun to be modified] #move(dx: 1em, dy: -1em)[#sym.circle.dotted Baseline: default spaCy-detected member noun's dependencies (excluding punctuation)]
      #v(-1.7em)
      #grid(
        columns: 1,
        gutter: 1em,
        image("figures/dep_comp_results.png", width: 100%),
        align(
          move([*RBS Dependency Detection Component Results*], dy: -1em),
          center,
        ),
      )
      #v(-1.3em)
      #line(length: 100%)
      #v(-0.5em)
      - *Generation (All Models)*: Manually gender-neutralized evaluation sentences using collective nouns \ #move(dx: 1em, dy: -0.5em)[#sym.circle.dotted Objective: evaluate correct correct conversion of sentences] #move(dx: 1em, dy: -1em)[#sym.circle.dotted Baseline: original, unconverted sentence (as per previous works)]
      #v(-1.7em)
      #grid(
        columns: 1,
        gutter: 1em,
        move(
          image("figures/gen_results.png", width: 100%),
          dx: 0em,
        ),

        align(
          move([*Global Generation Results*], dy: -0.8em),
          center,
        ),
      )
      #v(-1em)
      #line(length: 100%)
      #v(-0.7em)
      //- *Four main categories of errors*: morphosyntax; collective nouns and (coreference); semantics and other
      - *Generation Errors*: For RBS and fine-tuned models, two annotators manually annotated with subcategories (italicized in plot)
      - For Claude 3 Opus, used LLM-as-a-judge to automatically annotate in a two-step process: 1. ask to describe the error; 2. assign a subcategory
      #v(-1em)
      #grid(
        columns: 1,
        gutter: 0em,
        move(
          image("figures/genre_errors_c24_en.svg", width: 100%),
          dx: 0em,
        ),
      )
    ]

    #v(-1.9em)

    #pop.column-box(heading: "5. Takeaways")[
      - RBS and instruct-based model combined with pre-created resources achieve similar results; lower morphosyntactic errors for Claude 3 Opus
      - Collective nouns useful for gender neutralization, but limited by restrictive semantics
    ]
    #v(-1em)
    #pop.bibliography-box(
      //"../../../typst-slides-collection/phd/phd.bib",
      "../../references.bib",
      //style: "../brief.csl",
      style: "../../apa-numeric.csl",
      body-size: 0.7em,
    )
    #place(
      box(fill: rgb("2f55df"), outset: 0.5em, [#image(
          "components/qr.svg",
          height: 3.5em,
        )]),
      dy: -2.6em,
      dx: 28.5em,
    )
  ],
)
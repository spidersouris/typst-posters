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
  "Analyzing use of masculine generics by LLMs in French",
  authors: "Enzo Doyen (LiLPa, University of Strasbourg)",
  authors-size: 0.6em,
  title-size: 2.1em,
  logos: image("../../media/logos/lilpa.png", width: 35%),
  background-image: "../../media/backgrounds/star_blur.png",
  banner-height: 15%,
)

#columns(
  2,
  [
    #pop.column-box(heading: "1. Introduction")[
      - Masculine generics (MG) in gender-marked languages (e.g., French, German, Dutch): use of the masculine form as a default/neutral form to refer to (a) mixed group of men/women or (b) people whose gender is unknown. Examples in French: \ #box(fill: rgb(0, 0, 0, 40), inset: 0.5em)[(a) « Les *étudiants* sont partis. » (*Students* [masc.] left.) \ (b) « Un *athlète* doit s'entrainer régulièrement pour progresser. » \ (An *athlete* [masc.] needs to train regularly to progress.)]
      - Psycholinguistics studies show that *MG induce gender bias* and *amplify male-centric mental representations* @braunCognitiveEffectsMasculine2005 @gygaxMasculineFormIts2012 @rothermundRemindingMayNot2024
      - Gender bias widely studied in instruct-based LLMs@gallegosBiasFairnessLarge2024, but never with generic instructions or in unconstrained contexts
    ]

    #pop.column-box(heading: "2. Methodology")[
      _Focus on French, but applicable to any language with MG given \ human noun and instruction datasets_
      1. Create a French human noun (HN) dataset from available French lexical resources to detect occurrences of MG and evaluate the ratio of MG to HN uses \ #text(size: 0.9em)[#sym.dot.o Filter with custom ML binary HN classification pipeline]
      #align(
        center + horizon,
        grid(
          columns: 3,
          column-gutter: 0.2em,
          grid.cell(
            inset: 0.2em,
            align: center + horizon,
            [#box(fill: pop.psi-yellow, height: 0.7em, width: 0.7em) #text(
                "Golden",
                size: 0.8em,
              )],
          ),
          grid.cell(
            inset: 0.2em,
            align: center + horizon,
            [#box(fill: pop.psi-pink, height: 0.7em, width: 0.7em) #text(
                "Filtered",
                size: 0.8em,
              )],
          ),
          grid.cell(
            inset: 0.2em,
            align: center + horizon,
            [#box(fill: gray, height: 0.7em, width: 0.7em) #text(
                "Not used for classification",
                size: 0.8em,
              )],
          ),
        ),
      )
      #align(
        center + horizon,
        grid(
          columns: 8,
          column-gutter: 0.2em,
          grid.cell(
            inset: 0.4em,
            align: center,
            fill: pop.psi-yellow,
            colspan: 1,
            text("NHUMA", size: 0.5em, weight: "bold"),
          ),
          grid.cell(
            inset: 0.4em,
            align: center,
            fill: pop.psi-yellow,
            colspan: 1,
            text("Wikidata", size: 0.5em, weight: "bold"),
          ),
          grid.cell(
            inset: 0.4em,
            align: center,
            fill: pop.psi-yellow,
            colspan: 1,
            text("Wiktionary", size: 0.5em, weight: "bold"),
          ),
          grid.cell(
            inset: 0.4em,
            align: center,
            fill: pop.psi-pink,
            colspan: 1,
            text("Demonette", fill: white, size: 0.5em, weight: "bold"),
          ),
          grid.cell(
            inset: 0.4em,
            align: center,
            fill: pop.psi-pink,
            colspan: 1,
            text("TLFi (Recursive)", fill: white, size: 0.5em, weight: "bold"),
          ),
          grid.cell(
            inset: 0.1em,
            align: center,
            colspan: 1,
            text("+", size: 0.5em, weight: "bold"),
          ),
          grid.cell(
            inset: 0.4em,
            align: center,
            fill: gray,
            colspan: 1,
            text("TLFi", fill: white, size: 0.5em, weight: "bold"),
          ),
        ),
      )


      2. Analyze MG use in 6 LLMs' outputs to generic instructions \ #text(size: 0.9em)[#sym.dot.o Use human/AI-written generic instruction datasets and remove specific contexts with spaCy @honnibalSpaCyIndustrialstrengthNatural2023 (dependency parsing and NER)

          #figure(image("figures/instr.svg", width: 90%))

          #text(size: 0.9em)[#sym.dot.o Sample 10,000 instructions and send them to LLMs]

          #align(center + horizon, grid(
            columns: 8,
            column-gutter: 0.2em,
            grid.cell(
              inset: 0.4em,
              align: center,
              fill: rgb(78, 170, 153, 95),
              colspan: 1,
              text("Gemini", size: 0.5em, weight: "bold"),
            ),
            grid.cell(
              inset: 0.4em,
              align: center,
              fill: rgb(8, 8, 8),
              colspan: 1,
              text("GPT-4o mini", fill: white, size: 0.5em, weight: "bold"),
            ),
            grid.cell(
              inset: 0.4em,
              align: center,
              fill: rgb(204, 120, 92),
              colspan: 1,
              text("Claude 3 Haiku", size: 0.5em, weight: "bold"),
            ),
            grid.cell(
              inset: 0.4em,
              align: center,
              colspan: 1,
              text("|", size: 0.5em, weight: "bold"),
            ),
            grid.cell(
              inset: 0.4em,
              align: center,
              fill: rgb(0, 97, 218),
              colspan: 1,
              text("Llama 3 8B", fill: white, size: 0.5em, weight: "bold"),
            ),
            grid.cell(
              inset: 0.4em,
              align: center,
              fill: rgb(255, 141, 51),
              colspan: 1,
              text("Ministral", size: 0.5em, weight: "bold"),
            ),
            grid.cell(
              inset: 0.4em,
              align: center,
              fill: rgb(255, 68, 51),
              colspan: 1,
              text("Mistral Small 3", fill: white, size: 0.5em, weight: "bold"),
            ),
          ))
          #v(-1em)
          #align(center + horizon, grid(
            columns: 2,
            column-gutter: 8.5em,
            grid.cell(
              inset: 0.4em,
              align: center,
              colspan: 1,
              text("proprietary", size: 0.5em, weight: "bold"),
            ),
            grid.cell(
              inset: 0.4em,
              align: center,
              colspan: 1,
              text("local", size: 0.5em, weight: "bold"),
            ),
          ))

          #text(size: 0.9em)[#sym.dot.o Like instructions, filter responses to remove specific contexts]

          #text(size: 0.9em)[#sym.dot.o Validate HNs in outputs using GPT-4o mini, JSON-constrained]

          #text(size: 0.9em)[#sym.dot.o Compute score for each text; as well as mean (average bias per text) and overall (average bias per LLM) scores]

        ]

      $ "MScore"_i = frac("mg_count"_i, "hn_count"_i) $

      #align(
        center + horizon,
        grid(
          columns: 2,
          gutter: 5.5em,
          grid.cell(
            inset: 0em,
            align: center,
            text("Overall", size: 0.8em, weight: "bold"),
          ),
          grid.cell(
            inset: 0em,
            align: center,
            text("Mean", size: 0.8em, weight: "bold"),
          ),
        )
          + v(-1em)
          + grid(
            columns: 2,
            gutter: 2em,
            grid.cell(
              inset: 0.5em,
              align: center,
              $ frac("total_mg", "total_hn") $,
            ),

            grid.cell(
              inset: 0em,
              align: center,
              $ frac(1, "n") sum_(i=1)^n "MScore"_i $,
            ),
          ),
      )



    ]

    #colbreak()

    #pop.column-box(heading: "3. Results and Findings")[
      - LLMs use MG in $approx$39.5% of all their responses on average \ ($approx$73.1% of responses with HNs)
      - GPT-4o mini and Ministral generally the most biased models
      - Llama 3 8B, Claude 3 Haiku and Mistral Small 3 generally the least biased models
      - LLMs reluctant to using gender-fair language (GFL) spontaneously, \ Llama 3 8B being the model with highest GFL use (see preprint for details)
      #grid(
        columns: 1,
        gutter: 0em,
        [*MScore*],
        move(image("figures/m_score_llmonly.svg", width: 100%), dx: 0em),
      )
      #grid(
        columns: 1,
        gutter: 0em,
        [*MG Use Rate*],
        move(
          image("figures/mg_use_rate_llmonly.svg", width: 100%),
          dx: 0em,
        ),
      )
    ]

    #v(-1.3em)

    #pop.column-box(heading: "4. Takeaways")[
      - LLMs largely exhibit MG bias when generating responses to generic, contextually unconstrained instructions
      - Fairness in language should be attentively considered when training LLMs in heavily gender-marked languages
    ]
  ],
)

#v(-2em)
#pop.bibliography-box(
  "../../references.bib",
  //style: "../../brief.csl",
  style: "../../apa-numeric.csl",
  body-size: 0.7em,
)

#v(-1.8em)
#pop.bottom-box()[
  #grid(
    columns: 4,
    align: horizon + center,
    column-gutter: 3em,
    align(
      horizon + left,
    )[Read our full preprint for more details: \ #text("Doyen, E. & Todirascu, A. (2025).", weight: 0) #text("Man Made Language Models? Evaluating LLMs’ Perpetuation of Masculine Generics Bias", weight: 0, style: "italic")#text(". arXiv: 2502.10577.", weight: 0)],
    move(grid.cell(image("components/qr.svg", height: 5em)), dx: 1em),
    move(grid.cell(image("components/alps.png", height: 3em)), dx: 2em),
    move(
      box([ALPS 2025], fill: rgb("#4f4f4f"), height: 3em, width: 6em),
      dx: -1em,
    ),
  )
]

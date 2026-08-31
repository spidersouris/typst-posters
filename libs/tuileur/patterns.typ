#import "lib.typ": make_palette, palettes, tiler, use_tileset

#let tiler-blue = tiler.with(
  cols: 1,
  rows: 1,
  tileset: use_tileset("Lem"),
  colors: make_palette((rgb("#1b3a63"), rgb("#3f86cc")), steps: 5),
  background_colors: (rgb("#0b1c33"),),
  fill: false,
  stroke_width: 2,
  perlin_colors: true,
  perlin_colors_scale: 6,
  seed: "blue",
)

#let tiler-mesh = tiler.with(
  cols: 1,
  rows: 1,
  tileset: use_tileset("Atwood"),
  colors: make_palette(
    (rgb("#5b3fa8"), rgb("#c04bd8"), rgb("#3f7fd8")),
    steps: 6,
  ).map(c => c.transparentize(35%)),
  background_colors: (rgb("#101020"),),
  fill: false,
  stroke_width: 1.3,
  perlin_colors: true,
  perlin_colors_scale: 7,
  seed: "mesh",
)

#let tiler-ember = tiler.with(
  cols: 1,
  rows: 1,
  tileset: use_tileset("King"),
  colors: make_palette(
    (rgb("#7a1f0d"), rgb("#f07019"), rgb("#f6c445")),
    steps: 5,
  ).map(c => c.transparentize(40%)),
  background_colors: (rgb("#1a0705"),),
  fill_coef: 0.45,
  stroke_width: 1.2,
  perlin_colors: true,
  perlin_colors_scale: 4,
  seed: "ember",
)

#let tiler-enigma = tiler.with(
  cols: 23, rows: 5,
  tileset: use_tileset("Benjamin"),
  colors: make_palette((rgb("#2f6fb0"), rgb("#8ac6ff")), steps: 4),
  background_colors: (rgb("#0b1c33"),),
  fill: false, stroke_width: 1.4,
  seed: "enigma",
)

#let tiler-rising = tiler.with(
  cols: 23, rows: 5,
  tileset: use_tileset("Wells"),
  colors: make_palette((rgb("#3a1220"), rgb("#8c2f52"), rgb("#5a3a7a")), steps: 5),
  background_colors: (rgb("#120309"),),
  fill: false, stroke_width: 1.6,
  perlin_colors: true, perlin_colors_scale: 4,
  seed: "risingC",
)

#let tiler-matrix = tiler.with(
  cols: 23, rows: 5,
  tileset: use_tileset("King"),
  colors: make_palette((rgb("#0f3d2e"), rgb("#2fbf85")), steps: 5)
    .map(c => c.transparentize(25%)),
  background_colors: (rgb("#06170f"),),
  fill_coef: 0.3, stroke_width: 1.3,
  perlin_colors: true, perlin_colors_scale: 3.5,
  seed: "matrix",
)
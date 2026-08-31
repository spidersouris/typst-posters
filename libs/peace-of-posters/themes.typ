#let _state-poster-theme = state(
  "poster-theme",
  (
    "body-box-args": (
      inset: 0.6em,
      width: 100%,
    ),
    "body-text-args": (:),
    "heading-box-args": (
      inset: 0.6em,
      width: 100%,
      fill: rgb(50, 50, 50),
      stroke: rgb(25, 25, 25),
    ),
    "heading-text-args": (
      fill: white,
    ),
  ),
)

#let lilpa-red = rgb("#e2001a")

#let psi-pink = rgb("#dc005a")
#let psi-yellow = rgb("#f0f500")

#let psi-ch = (
  "colors": (
    primary: psi-pink,
    secondary: psi-yellow,
  ),
  "body-box-args": (
    inset: (x: 0.0em, y: 0.6em),
    width: 100%,
    stroke: none,
  ),
  "body-text-args": (:),
  "title-box-args": (
    inset: 1em,
    width: 100% + 2cm,
    fill: psi-pink,
    stroke: psi-pink,
  ),
  "heading-box-args": (
    inset: 0em,
    width: 100%,
    stroke: none,
  ),
  "heading-text-args": (
    fill: lilpa-red,
    weight: "bold",
  ),
  "bottom-box-args": (
    fill: psi-pink,
  ),
  "bottom-text-args": (
    fill: white,
    stroke: white,
    weight: "bold",
  ),
)

#let lilpa-black = rgb("#2eaadc")

#let lilpa-dark = (
  "colors": (
    primary: lilpa-black,
    secondary: psi-yellow,
  ),
  "body-box-args": (
    inset: (x: 0.0em, y: 0.6em),
    width: 100%,
    stroke: none,
  ),
  "body-text-args": (:),
  "title-box-args": (
    inset: 1em,
    width: 100% + 2cm,
    fill: lilpa-black,
    stroke: psi-pink,
  ),
  "heading-box-args": (
    inset: 0em,
    width: 100%,
    stroke: none,
  ),
  "heading-text-args": (
    fill: lilpa-black.darken(30%),
    weight: "bold",
  ),
  "bottom-box-args": (
    fill: psi-pink,
  ),
  "bottom-text-args": (
    fill: white,
    stroke: white,
    weight: "bold",
  ),
)

#let uni-fr = (
  "body-box-args": (
    inset: 0.6em,
    width: 100%,
  ),
  "body-text-args": (:),
  "heading-box-args": (
    inset: 0.6em,
    width: 100%,
    fill: rgb("#1d154d"),
    stroke: rgb("#1d154d"),
  ),
  "heading-text-args": (
    fill: white,
  ),
)

#let update-theme(..args) = {
  for (arg, val) in args.named() {
    _state-poster-theme.update(pt => {
      pt.insert(arg, val)
      pt
    })
  }
}

#let set-theme(theme) = {
  _state-poster-theme.update(pt => {
    pt = theme
    pt
  })
}

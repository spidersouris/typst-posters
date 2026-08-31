# typst-posters

This repository includes examples of academic posters made in [Typst](https://typst.app) using the [peace-of-posters](https://jonaspleyer.github.io/peace-of-posters/) package.

The codebase was extended from that of @elinscott, who [himself added new functionalities to the peace-of-posters package](https://github.com/jonaspleyer/peace-of-posters/discussions/6) for his [Total Energies 2025 poster template](https://jonaspleyer.github.io/peace-of-posters/showcase/2025-psi/).

## Posters

The following posters are included, along with the Typst code and all relevant assets:
1. [`posters/alps25`](posters/alps25): a poster created for the [ALPS 2025](https://alps-2025.imag.fr/) winter school,
2. [`posters/acl25`](posters/acl25): a poster created for the [ACL 2025](https://2025.aclweb.org/) conference,
3. [`posters/perso_sem_lilpa`](posters/perso_sem_lilpa): a poster created for a [LiLPa](https://lilpa.unistra.fr/) seminar, with A0/A0_tuileur/A1 versions,
4. [`posters/mlss26`](posters/mlss26): a poster created for the [Columbia University Machine Learning Summer School 2026](https://cfe.columbia.edu/content/mlss2), with A0 and 24x36in (landscape) versions.

## Using tuileur

One of the major extensions compared to peace-of-posters is an enhanced header banner with multiple logos and the ability to have Typst-embedded custom backgrounds (without external images) using [tuileur](https://github.com/avivi55/tuileur), a tiling engine in Typst.

Several themes specifically designed for poster headers were defined in [`libs/tuileur/patterns.typ`](libs/tuileur/patterns.typ). They can be used as follows:

```typ
#pop.title-box(
  [Poster Title],
  authors: "",
  authors-size: 0.6em,
  title-size: 1.6em,
  logos: (),
  logo-gap: 5em,
  banner-height: 16%,
  tiler-fn: tiler-matrix, // define the tuileur theme here, e.g. "tiler-matrix"
)
```

An example of rendered tiler can be found in the [`posters/perso_sem_lilpa/perso_sem_lilpa_a0_tuileur.pdf`](posters/perso_sem_lilpa/perso_sem_lilpa_a0_tuileur.pdf) file.
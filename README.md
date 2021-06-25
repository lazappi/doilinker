# doilinker

<!-- badges: start -->
[![R-CMD-check](https://github.com/lazappi/doilinker/workflows/R-CMD-check/badge.svg)](https://github.com/lazappi/doilinker/actions)
[![Codecov test coverage](https://codecov.io/gh/lazappi/doilinker/branch/main/graph/badge.svg)](https://codecov.io/gh/lazappi/doilinker?branch=main)
<!-- badges: end -->

**{doilinker}** allows you to link related DOIs.
Usually this is to find the published version of a preprint (or the reverse).
It does this by querying the Crossref database using **{rcrossref}** and matching DOIs using the method described by Cabanac, Oikonomidi and Boutron (see citation below).

Documentation for the package can be viewed at http://lazappi.github.io/doilinker.

## Installation

The package can be installed from GitHub:

```r
# install.packages("remotes")
remotes::install_github("lazappi/doilinker")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(doilinker)

search_doi_links("10.1101/133173")
```

## Code of Conduct
  
Please note that the doilinker project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.

## Citation

If you use this package please cite the original publication for the linking method
(if you want to cite the package directly as well that would be great 😉 but crediting the original authors is the important part):

> Cabanac G, Oikonomidi T, Boutron I. "Day-to-day discovery of preprint-publication links." **Scientometrics**. 2021;1–20. DOI: [10.1007/s11192-021-03900-7](https://doi.org/10.1007/s11192-021-03900-7)
>

```bibtex
@ARTICLE{Cabanac2021-ge,
  title    = "Day-to-day discovery of preprint-publication links",
  author   = "Cabanac, Guillaume and Oikonomidi, Theodora and Boutron, Isabelle",
  journal  = "Scientometrics",
  pages    = "1--20",
  month    =  apr,
  year     =  2021,
  language = "en"
}
```

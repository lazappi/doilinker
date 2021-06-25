# doilinker

<!-- badges: start -->
<!-- badges: end -->

**{doilinker}** allows you to link related DOIs.
Usually this is to find the published version of a preprint (or the reverse).
It does this by querying the Crossref database using **{rcrossref}** and matching DOIs using the method described by Cabanac, Oikonomidi and Boutron (see citation below).

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
## basic example code
```

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


# {surveyDesigner} <img src="https://raw.githubusercontent.com/unhcr-americas/surveyDesigner/master/inst/hex-surveyDesigner.png" align="right" width="120"/>

<!-- badges: start -->
[![Codecov test coverage](https://codecov.io/gh/unhcr-americas/surveyDesigner/branch/main/graph/badge.svg)](https://codecov.io/gh/unhcr-americas/surveyDesigner?branch=main)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->


`{surveyDesigner}` is a shinyApp to parse a master XlsForm to generate a contextualized questionnaire.

The app is build using [`{golem}` framework](https://thinkr-open.github.io/golem) and following the tutorial: [Engineering Production-Grade Shiny Apps](https://engineering-shiny.org//).

Read more on the rationale for this app in the [vignette](https://unhcr-americas.github.io/surveyDesigner/docs/articles/surveyDesigner.html)

## Installation

You can install the development version from [GitHub](https://github.com/Thinkr-open/golem) with:

``` r
# install.packages("remotes")
remotes::install_github("unhcr-americas/surveyDesigner")
```

## Run the app  
This script allows you to display the app

``` r
# Run the application
surveyDesigner::run_app()
```

## Update the app  
This script allows you to quickly rebuild and display the app

``` r
# Detach all loaded packages and clean your environment
golem::detach_all_attached()

# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run the application
surveyDesigner::run_app()
```



## Update the package documentation

This script allows to update the package documentation

``` r
devtools::document()

devtools::check(document = FALSE)

pkgdown::build_site()
```

## Code of Conduct

Please note that the surveyDesigner project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.

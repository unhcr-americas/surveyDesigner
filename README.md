
# {surveyDesigner} <img src="https://raw.githubusercontent.com/unhcr-americas/surveyDesigner/master/inst/hex-surveyDesigner.png" align="right" width="120"/>

`{surveyDesigner}` is a shinyApp to parse a master XlsForm to generate a contextualized questionnaire.

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



# {surveyDesigner} <img src="https://raw.githubusercontent.com/unhcr-americas/surveyDesigner/master/inst/surveyDesigner.png" align="right" width="120"/>

`{surveyDesigner}` is an opinionated framework for building production-grade shiny applications.

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


#######################################################
## This file will guide you in the creation of your app
#######################################################

## Install the required dev dependencies ----
golem::install_dev_deps()

## Make sure to update imported libraries in the package namespace
attachment::att_amend_desc()

### Initial set up for Documentation ----------

## Connect to github to enable documentation and collaboratio
rstudioapi::navigateToFile("dev/githublink.R")
## Set up the README
usethis::use_readme_rmd(open = FALSE)
## Start documenting the project objectives in the readme file
rstudioapi::navigateToFile("README.Rmd")
## Now build it
devtools::build_readme()

### Back office ----------

## Go to function_documentation.Rmd to build your back office functions with Fusen
rstudioapi::navigateToFile("dev/function_documentation.Rmd")
## Get your function and then build your package with
fusen::inflate(flat_file = "dev/function_documentation.Rmd", vignette_name = "Development")

# Your goal is to to get :
#  > 0 errors ✔ | 0 warnings ✔ | 0 notes ✔

## Set up a globals.R with
# remotes::install_github("thinkr-open/checkhelper")
# checkhelper::print_globals()

## Build the html package documentation for your utilities functions
pkgdown::build_site()


### Start Building the app ----------

## Init Testing Infrastructure
golem::use_recommended_tests()
## Ensure the empty dashboard loads correctly
golem::run_dev()

## Now start adding modules from console
# Modules are like the pipe between your back-office functions and your user
# Name of the module - "my_first_module"
# graveler::level_up(name = "my_first_module")
# graveler::level_up(name = "context")
# graveler::level_up(name = "content")
# graveler::level_up(name = "collection")
# graveler::level_up(name = "forms")


### Deploy the app ----------

## Add manifest for CI/CD
rsconnect::writeManifest()
## For deployment use the app.R file at the root of your project and then use
# the deployment button in blue to publish your project http://rstudio.unhcr.org


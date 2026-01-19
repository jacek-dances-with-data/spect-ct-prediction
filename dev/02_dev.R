###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Amend DESCRIPTION with dependencies read from package code parsing
attachment::att_amend_desc()

## Add modules ----
## Create a module infrastructure in R/
golem::add_module(name = "model_predictions", with_test = FALSE)
golem::add_module(name = "app_info", with_test=FALSE)

## Add helper functions ----
## Creates fct_* and utils_*
golem::add_fct("model_predictions", with_test = TRUE)

## Tests ----
## Add one line by test you want to create
usethis::use_test("app")

# Documentation

## Vignette ----
usethis::use_vignette("SPECTCTCalculator")
devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
#usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
#covrpage::covrpage()

## CI ----
#usethis::use_github()

# GitHub Actions
# TODO

# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")

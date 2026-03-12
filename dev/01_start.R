########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################
golem::fill_desc(
  pkg_name = "SPECTCTCalculator",
  pkg_title = "Predicting results of hybrid imaging in primary hyperparathyroidism using machine learning",
  pkg_description = "The package calculates predicted probability of a positive SPECT-CT
scintigraphy result based on clinical parameters of patient provided as inputs.
  The predictive models are based on Drynda, A., Podlewski, J., Kucharczyk, K., Sokołowski, G.,
  Sowa-Staszczak, A., Hubalewska-Dydejczyk, A. and Trofimiuk- Müldner, M., 2025, 'Evaluation of multiple machine learning models predicting the results of hybrid imaging in primary hyperparathyroidism', Nuclear Medicine Review, vol. 28, pp. 47–54, doi:10.5603/nmr.105377",
  authors = person(
    given = "Jacek",
    family = "Podlewski",
    email = "podlewski.jacek@gmail.com",
    role = c("aut", "cre")
  ),
  repo_url = "https://github.com/jacek-dances-with-data/spect-ct-prediction/blob/main/R/fct_model_predictions.R",
  pkg_version = "0.0.0.91",
  set_options = TRUE
)

## Install the required dev dependencies ----
golem::install_dev_deps()

## Create Common Files ----
usethis::use_mit_license("Jacek Podlewski")
golem::use_readme_rmd(open = FALSE)
devtools::build_readme()
usethis::use_code_of_conduct(contact = "Jacek Podlewski")
usethis::use_lifecycle_badge("Experimental")

## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()

## Favicon ----
golem::use_favicon()

## Add helper functions ----
golem::use_utils_ui(with_test = TRUE)
golem::use_utils_server(with_test = TRUE)

## Use git ----
#usethis::use_git()
## Sets the remote associated with 'name' to 'url'
#usethis::use_git_remote(
#  name = "origin",
#  url = "https://github.com/<OWNER>/<REPO>.git"
#)

rstudioapi::navigateToFile("dev/02_dev.R")

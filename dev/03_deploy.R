# Building a Prod-Ready, Robust Shiny Application.
#
######################################
#### CURRENT FILE: DEPLOY SCRIPT #####
######################################

## Run checks ----
## Check the package before sending to prod
devtools::check()

# Deploy

## Local, CRAN or Package Manager ----
## This will build a tar.gz that can be installed locally,
## sent to CRAN, or to a package manager
devtools::build()

## Posit ----
## If you want to deploy on Posit related platforms
golem::add_positconnect_file()

## Deploy to Posit Connect

## Add/update manifest file (optional; for Git backed deployment on Posit )
rsconnect::writeManifest()

#Create renv.lock
renv::snapshot(type="implicit")


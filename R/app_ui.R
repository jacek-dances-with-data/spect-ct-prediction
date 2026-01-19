#' The application user interface
#'
#' @param request Internal parameter for `{shiny}`.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    golem_add_external_resources(),
    # Application UI logic
    fluidPage(
      class="model_predictions",
      title_ui("app_title"),
      mod_model_predictions_ui("model_predictions"),
      footer_ui("dalex_info")
    )
  )
}

#' Adding external resources to the application
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "SPECT-CT Calculator"
    )
  )
}

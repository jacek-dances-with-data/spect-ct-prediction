#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  r <- reactiveValues(data=data.frame(), output=renderTable(data.frame()))
  mod_model_predictions_server(input, output, session, r)
}

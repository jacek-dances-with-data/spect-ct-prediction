#' App info UI Functions
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom shinyBS bsButton bsPopover
title_ui <- function(id) {
  ns <- NS(id)
  titlePanel(tags$span("Positive Scintigraphy Prediction",
              #Info button
              bsButton("app-info", label = "", icon = icon("info"), style = "info", size = "extra-small"),
              bsPopover(
                  id = "app-info",
                  title = "App information",
                  content = "This application implements machine learning diagnostic model described in A.Drynda et al., Evaluation of multiple machine learning models predicting the results of hybrid imaging in primary hyperparathyroidism, Nuclear Medicine Review 28:47-54 (2025)",
                  placement = "right",
                  trigger = "hover"
              )))
}

footer_ui <- function(id) {
  ns <- NS(id)
  tagList(
    div(
      style="margin-top:0px; font-size:12px",
      align="right",
      tagList("Prediction explanations powered by DALEX: ", a("https://dalex.drwhy.ai/", href="https://dalex.drwhy.ai/"))
    )
  )
}

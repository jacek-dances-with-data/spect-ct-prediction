#library(shinyjs)

#' model_predictions UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom shinyjs show hide
mod_model_predictions_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(
      style="height:95%",
      sidebarLayout(
        sidebarPanel(
          sliderInput(
            "PTH",
            "PTH [pg/mL]",
            min=0,
            max=500,
            value=200,
          ),
          sliderInput(
            "Ca",
            "Calcium [mmol/L]",
            min=1.,
            max=4.,
            value=2.,
            step=0.1,
          ),
          sliderInput(
            "Pi",
            "Pi [mmol/L] ",
            min=0.1,
            max=1.6,
            value=1.,
          ),
          sliderInput(
            "vit_D",
            "Vitamin D [ng/mL]",
            min=0,
            max=80.,
            value=30.,
          ),
          sliderInput(
            "max_diameter",
            "Max. lesion diameter [cm]",
            min=0.,
            max=4.,
            value=0.,
            step=0.05
          ),
          fluidRow(
            align = 'center',
            style="margin-bottom:1px",
            actionButton("predict","Predict",icon("chart-gantt")),
            actionButton("reset","Reset", icon("rotate-right"))
          )
        ),
        mainPanel(
          id="outputs",
          div(tableOutput("data"), style = "font-size:130%"),
          plotOutput("shap_plot")
        )
      )
    )
  )
}


#' model_predictions Server Functions
#'
#' @noRd
mod_model_predictions_server <- function(input, output, session, reactive_values){
    ns <- session$ns

    observeEvent(input$predict, {
      input_features <- data.frame("PTH"=as.numeric(input$PTH),
                                   "Ca"=as.numeric(input$Ca),
                                   "max_diameter"=as.numeric(input$max_diameter),
                                   "vit_D"=as.numeric(input$vit_D),
                                   "Pi"=as.numeric(input$Pi))

      probs <- prediction_probs(model, input_features)

      reactive_values$data <- input_features
      reactive_values$output <- probs

      output$data <- renderTable(reactive_values$output)
      output$shap_plot <- renderPlot(plot_prediction_explanation(model, explainer, reactive_values$data))
      show("outputs")

      reactive_values$data$prediction <- probs[1,1]
      reactive_values$data$prob <- probs[1,2]

    })

    observeEvent(input$reset,{
      reactive_values <- reactiveValues(data=data.frame(), output=NULL)
      output$data <- renderTable(data.frame())
      output$shap_plot  <- NULL
      hide("outputs")
    })
}

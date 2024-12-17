#' start UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_start_ui <- function(id) {
  ns <- NS(id)

  tagList(fluidRow(
    column(
      4,

      # instructions box ---------------------------------------------------------
      shinydashboard::box(
        title = strong("Definitions"),
        width = NULL,
        status = "primary",
        collapsible = TRUE,
        solidHeader = TRUE
        # includeMarkdown(normalizePath(
        #   "inst/app/www/rmd/exploreDefinitions.md"
        # ))
      ),

      # filter box --------------------------------------------------------------
      shinydashboard::box(
        title = tagList(span(strong("Import the data"))),
        # title = tagList(span(strong("Import the data")),
        #                 span(fct_helpBtn(
        #                   id = ns("filterHelp")
        #                 ))),
        width = NULL,
        status = "primary",
        collapsible = TRUE,
        solidHeader = TRUE,
        shinyWidgets::virtualSelectInput(
          inputId = ns("county"),
          label = strong("Step 1. County"),
          placeholder = "Select counties",
          choices = c("A", "B", "C"),
          multiple = TRUE,
          search = TRUE,
          position = "bottom",
          showValueAsTags = TRUE,
          optionsCount = 5
        )
      )
    )
  ))
}


#' start Server Functions
#'
#' @noRd
mod_start_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_start_ui("start_1")

## To be copied in the server
# mod_start_server("start_1")

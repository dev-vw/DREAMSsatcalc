#' national_ui UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_national_ui <- function(id) {
  ns <- NS(id)
  tagList(

  )
}

#' national_ui Server Functions
#'
#' @noRd
mod_national_ui_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_national_ui_ui("national_ui_1")

## To be copied in the server
# mod_national_ui_server("national_ui_1")

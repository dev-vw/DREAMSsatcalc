#' dsnu_ui UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_dsnu_ui <- function(id) {
  ns <- NS(id)
  tagList(

  )
}

#' dsnu_ui Server Functions
#'
#' @noRd
mod_dsnu_ui_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_dsnu_ui_ui("dsnu_ui_1")

## To be copied in the server
# mod_dsnu_ui_server("dsnu_ui_1")

#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      #theme = theme,
      navbarPage(
        title = span(
          "DREAMS Saturation Calculator"
        ),
        collapsible = TRUE,
        tabPanel(
          title = "Start Here",
          mod_start_ui("start_tab")
        ),
        tabPanel(
          title = "National-level Estimator",
          mod_national_ui("nat-estimate_tab")
        ),
        tabPanel(
          title = "DSNU-level Estimator",
          mod_dsnu_ui("dsnu-estimate_tab")
        ),
        tabPanel(
          title = "About",
          column(10,
                 offset = 1,
                 shinydashboard::box(
                   width = NULL, status = "primary"
                   #includeMarkdown(normalizePath("inst/app/www/rmd/about.md"))
                 )
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
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
      app_title = "DREAMSsatcalc"
    ),
    shinyjs::useShinyjs(),
    shinyWidgets::useShinydashboard(),
    shinyWidgets::setBackgroundColor(color = "#faf9f0")
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

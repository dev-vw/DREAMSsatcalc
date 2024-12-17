#' theme
#' @description define theme for shiny app
#' @noRd
theme <- bslib::bs_theme(
  version = 5,
  primary = "#f2cc8f", secondary = "#f2cc8f", success = "#81B29A",
  warning = "#f2cc8f", danger = "#E07A5F", royal = "#3d405b",
  base_font = bslib::font_google("Source Sans Pro"), font_scale = NULL,
  `enable-shadows` = TRUE, `enable-rounded` = TRUE, bootswatch = "lumen"
)

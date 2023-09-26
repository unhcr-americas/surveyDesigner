#' UI Body
#'
#' This function is internally used to manage the body
#'
#' @import shiny
#' @import shinydashboard
#' @importFrom unhcrshiny theme_shinydashboard_unhcr
#' @noRd
#' @keywords internal

body <- function() {
  shinydashboard::dashboardBody(
    unhcrshiny::theme_shinydashboard_unhcr(),
    golem::activate_js(),
    tags$head(
      tags$script(src = "custom.js")
    ),
    shinydashboard::tabItems(
      #Add ui module here - separated with a coma!
      mod_home_ui("home_ui_1"),
      mod_context_ui("context_ui_1"),
      mod_content_ui("content_ui_1"),
      mod_collection_ui("collection_ui_1"),
      mod_forms_ui("forms_ui_1")

    )
  )
}

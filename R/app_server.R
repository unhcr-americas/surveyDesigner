#' Server
#'
#' This function is internally used to manage the shinyServer
#'
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal
app_server <- function(input, output, session) {

  ## add a reactive value object to pass by elements between objects
  AppReactiveValue <-  reactiveValues()
  # pins::board_register() # connect to pin board if needed
  callModule(mod_home_server, "home_ui_1")
  callModule(mod_context_server, "context_ui_1", AppReactiveValue)
  callModule(mod_content_server, "content_ui_1", AppReactiveValue)
  callModule(mod_collection_server, "collection_ui_1", AppReactiveValue)
  callModule(mod_forms_server, "forms_ui_1", AppReactiveValue)
}

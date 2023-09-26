#' UI Side menau
#'
#' This function is internally used to manage the side menu
#'
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal
#'
sidebar <- function() {
  shinydashboard::dashboardSidebar(
    shinydashboard::sidebarMenu(
      ## Here the menu item entry to the first module
      shinydashboard::menuItem("About",tabName = "home",icon = icon("bookmark")),
      shinydashboard::menuItem("  Define Context", tabName = "context", icon = icon("location-dot")),
      shinydashboard::menuItem("  Configure Content", tabName = "content", icon = icon("arrows-to-circle")),
      shinydashboard::menuItem("  Set up Collection", tabName = "collection", icon = icon("list-check")),
      shinydashboard::menuItem("  Publish Surveys", tabName = "forms", icon = icon("share-from-square"))
      # - add more - separated by a comma!
      ## For icon search on https://fontawesome.com/search?o=r&m=free - filter on free
    )
  )
}

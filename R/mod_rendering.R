#' rendering UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_rendering_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' rendering Server Functions
#'
#' @noRd 
mod_rendering_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_rendering_ui("rendering_ui_1")
    
## To be copied in the server
# mod_rendering_server("rendering_ui_1")

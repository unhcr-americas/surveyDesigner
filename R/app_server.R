#' Server
#'
#' This function is internally used to manage the shinyServer
#'
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal
app_server <- function(input, output, session) {
  
  ## load the refrential

  ## add a reactive value object to pass by elements between objects
  AppReactiveValue <-  reactiveValues(
    title = "Title for your data collection project",
    year = "2023",
    abstract="Provide an abstract for the data collection activities",
    country = "PAN", 
    coverage = "yes",
    survey = readxl::read_xlsx(system.file("SurveyDesigner_Referential.xlsx",
                                           package = "surveyDesigner"),
                               sheet = "survey"),
    choices = readxl::read_xlsx(system.file("SurveyDesigner_Referential.xlsx",
                                           package = "surveyDesigner"),
                               sheet = "choices"),
    indicator = readxl::read_xlsx(system.file("SurveyDesigner_Referential.xlsx",
                                            package = "surveyDesigner"),
                                sheet = "indicator"),
    indicator_survey = readxl::read_xlsx(system.file("SurveyDesigner_Referential.xlsx",
                                            package = "surveyDesigner"),
                                sheet = "indicator_survey"),
    indicator_choices = readxl::read_xlsx(system.file("SurveyDesigner_Referential.xlsx",
                                            package = "surveyDesigner"),
                                sheet = "indicator_choices"),
    indicator_population = readxl::read_xlsx(system.file("SurveyDesigner_Referential.xlsx",
                                            package = "surveyDesigner"),
                                sheet = "indicator_population"),
    indicator_disaggregation = readxl::read_xlsx(system.file("SurveyDesigner_Referential.xlsx",
                                            package = "surveyDesigner"),
                                sheet = "indicator_disaggregation") ,
    
    ## get list of indicator topic
    
    
    
    
    
  )
  # pins::board_register() # connect to pin board if needed
  callModule(mod_home_server, "home_ui_1")
  callModule(mod_context_server, "context_ui_1", AppReactiveValue)
  callModule(mod_content_server, "content_ui_1", AppReactiveValue)
  callModule(mod_collection_server, "collection_ui_1", AppReactiveValue)
  callModule(mod_forms_server, "forms_ui_1", AppReactiveValue)
}

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
      h1("surveyDesigner"),
      
      # titlePanel("surveyDesigner"),
      # sidebarLayout(
      #   sidebarPanel(
      #     helpText("Generate your survey questionnaire based on a curated  
      #          question bank.")
      #   ), 
      # mainPanel(
      
          fluidRow(
            
            column(3,
                   h3("Buttons"),
                   actionButton("action", "Action"),
                   br(),
                   br(), 
                   submitButton("Submit")),
            
            column(3,
                   h3("Single checkbox"),
                   checkboxInput("checkbox", "Choice A", value = TRUE)),
            
            column(3, 
                   checkboxGroupInput("checkGroup", 
                                      h3("Checkbox group"), 
                                      choices = list("Choice 1" = 1, 
                                                     "Choice 2" = 2, 
                                                     "Choice 3" = 3),
                                      selected = 1)),
            
            column(3, 
                   dateInput("date", 
                             h3("Date input"), 
                             value = "2014-01-01"))   
          ),
          
          fluidRow(
            
            column(3,
                   dateRangeInput("dates", h3("Date range"))),
            
            column(3,
                   fileInput("file", h3("File input"))),
            
            column(3, 
                   h3("Help text"),
                   helpText("Note: help text isn't a true widget,", 
                            "but it provides an easy way to add text to",
                            "accompany other widgets.")),
            
            column(3, 
                   numericInput("num", 
                                h3("Numeric input"), 
                                value = 1))   
          ),
          
          fluidRow(
            
            column(3,
                   radioButtons("radio", h3("Radio buttons"),
                                choices = list("Choice 1" = 1, "Choice 2" = 2,
                                               "Choice 3" = 3),selected = 1)),
            
            column(3,
                   selectInput("select", h3("Select box"), 
                               choices = list("Choice 1" = 1, "Choice 2" = 2,
                                              "Choice 3" = 3), selected = 1)),
            
            column(3, 
                   sliderInput("slider1", h3("Sliders"),
                               min = 0, max = 100, value = 50),
                   sliderInput("slider2", "",
                               min = 0, max = 100, value = c(25, 75))
            ),
            
            column(3, 
                   textInput("text", h3("Text input"), 
                             value = "Enter text..."))   
          )
    #    )
   #   )
     # p("Design your contextualised survey based on a curated question bank")
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
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'surveyDesigner'
    ),
    
    golem::favicon(),
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    htmltools::htmlDependency(
      "notifyjs", version = "0.1.0",
      src = system.file('app/www', package = 'surveyDesigner'),
      script = "notify.js"
    )
  )
}


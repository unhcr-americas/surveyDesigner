#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' 
#' @return Front end of app
#' 
#' @noRd
app_ui <- function(request) {

  
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    theme_dashboard(),
    # List the first level UI elements here
    dashboardPage(
      dashboardHeader(title = "Survey Designer (wireframe)"),
      dashboardSidebar(
        sidebarMenu(
          menuItem("  Define Context", tabName = "Context", icon = icon("location-dot")),
          menuItem("  Configure Content", tabName = "Content", icon = icon("arrows-to-circle")),
          menuItem("  Set up Collection", tabName = "Collection", icon = icon("list-check")),
          menuItem("  Export Forms", tabName = "Forms", icon = icon("share-from-square"))
        )
      ),
      
      dashboardBody(
        tabItems(
            # Context #####
            tabItem(tabName = "Context",  
                    p("A context reflects the implementation of the referential within a specific country or operation."),
                    fluidRow( 
                      tags$div(title="Interview",
                               selectInput("library", label =  "Methodology" , 
                                           choices = list("Household Survey (Representative Stock)" = "household_survey", 
                                                          "Flow Monitoring (People not aiming to establish residence)" = "flow_monitoring",
                                                          "Key Informant (Persons with knowledge)" = "key_informant",
                                                          "Beneficiary Monitoring (Participant to an assistance program)" = "beneficiary_monitoring"), 
                                           selected = "household_survey" )  ),
                      
                      tags$div(title="Select your country - this will pull up automatically the Case Load that should be covered based on your annual statistical report and implement the languages translation and geographic breakdown required for the country",
                                       selectInput("context", 
                                                   label = "Country, defining then required languages & geographic Pcodes", 
                                                   choices = list("Panama" = "Panama", 
                                                                  "Colombia" = "Colombia",
                                                                  "Ecuador" = "Ecuador" ), 
                                                   selected = "Panama")  ),
                      
                      tags$div(title="Population Group to cover",
                               checkboxGroupInput("population", 
                                           label = "Target Population", 
                                           choices = list("Refugees (REF) & Asylum seekers (ASY)"="RAS", 
                                                          "Internally displaced persons (IDP)"="IDP",
                                                          "Other people in need of international protection (OIP)"="OIP",
                                                          "Stateless Persons (STA)"="STA", 
                                                          "Others of concern to UNHCR (OOC)"="OOC",
                                                          "Returnee (RET)"="RET",
                                                          "Host community (HCT)"="HCT"  ), 
                                           selected = "Panama")  ),
                      tags$div(title="Required Disaggregation for Crosstabulation",
                               checkboxGroupInput("Disaggregation", 
                                           label = "Disaggregation", 
                                           choices = list("Age"="Gender", 
                                                          "Gender"="Gender", 
                                                          "Disability"="Disability", 
                                                          "Site"="Site" ), 
                                           selected = "Age")  )
                      ),
                    
                    br(),
                    p(" Next let's configure the content!") 
                    ),
            
            # Content #####
            tabItem(tabName = "Content",  
                    
                    checkboxGroupInput("topic", 
                                       label = "Select the Topics and/or indicators to prioritise", 
                                       choiceNames = list(
                                         list(
                                           icon("gavel") ,
                                           "Rights"  
                                         ), 
                                         list(
                                           icon("home"),
                                           "Trajectory"  
                                         ), 
                                         list(
                                           icon("thermometer-full"),
                                           "Intention"  
                                         ), 
                                         list(
                                           icon("check-circle"),
                                           "Basic Needs"  
                                         ), 
                                         list(
                                           icon("certificate"),
                                           "Coping Capacity"  
                                         ), 
                                         list(
                                           icon("users"),
                                           "Well-Being"  
                                         ), 
                                         list(
                                           icon("blind"),
                                           "Victimisation"
                                         ), 
                                         list(
                                           icon("usd"),
                                           "Livelihood"  
                                         ), 
                                         list(
                                           icon("book"),
                                           "Education"  
                                         ), 
                                         list(
                                           icon("medkit"),
                                           "Health-Nutrition"  
                                         ), 
                                         list(
                                           icon("eye"),
                                           "Accountability" 
                                         ), 
                                         list(
                                           icon("info-circle"),
                                           "Information" 
                                         )),
                                       choiceValues =  list("Rights"  ,
                                                            "Trajectory"  , 
                                                            "Intention"  ,  
                                                            "Basic Needs"  , 
                                                            "Coping Capacity"  , 
                                                            "Well-Being"  ,
                                                            "Victimisation"  , 
                                                            "Livelihood"  ,
                                                            "Education"  ,
                                                            "Health-Nutrition"  , 
                                                            "Accountability",
                                                            "Information"  )),
                    
                    
                    br(),
                    p("As a result of this stage, below is a documentation of your survey-based indicators annual plan") ,
                    
                    
                    ),
            
            # Collection ####
            tabItem(tabName = "Collection" ,
                             
                    tags$div(title="Using multiple data collection mode in parallel can help minimizing 
                             non-reponse and increase coverage.",
                             checkboxGroupInput("mode", 
                                                label =  "What Data Collection Modes can be used for this annual cycle?" , 
                                                # choiceNames = list("Face-to-face CAPI"  ,
                                                #                "Phone-Interview CATI"  ,
                                                #                "Self-administered CAWI"  ),
                                                
                                                choiceNames = list(
                                                  list(
                                                    icon("clipboard-question"),
                                                    "Face-to-face CAPI"="CAPI"
                                                  ), 
                                                  list(
                                                    icon("phone-square") ,
                                                    "Phone-Interview CATI"="CATI"  
                                                  ), 
                                                  list(
                                                    icon("wifi"),
                                                    "Self-administered CAWI"= "CAWI"  
                                                  )),
                                                
                                                choiceValues =  list("Face-to-face"  , 
                                                                     "Phone-Interview"  ,
                                                                     "Self-administered" ))),
                    tags$div(title="Define how many data collection waves you can manage within the year.
                             The more data collection wave the more indicators can be collected. ",
                             selectInput("wave", 
                                         label = "How many data collection waves for this annual cycle?", 
                                         choices = list("One Wave" = "One-wave", 
                                                        "Two Waves" = "Two-waves",
                                                        "Three Waves" = "Three-waves",
                                                        "Four Waves" = "Four-waves" ), 
                                         selected = "Two-waves") ),  
                    
                    br(),
                    p("As a result of this stage, below is an estimation of Interview lenght per questionnaire")
                 ),
            
            # Forms ####
            tabItem(tabName = "Forms", 
                    
                    p("Add the script to introduce the survey ") ,
                    p("Eventually change module sequences ") ,  
                    br(),
                    p("The resulting XlsForms can either be adjusted manually or 
                       pushed directly to UNHCR Kobo server. 
                       You can download the files for each data collection wave ")  
                    )
        ) #end items
      ) # end body
    ) # end page
  ) # end tag
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
    golem::activate_js(),
    golem::favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "surveyDesigner"
    )
    # Add here other external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}







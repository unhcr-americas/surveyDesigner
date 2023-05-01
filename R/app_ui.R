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
    
    
    # enable alert messages
    #shinyWidgets::useSweetAlert(),
    
    # Leave this function for adding external resources
    golem_add_external_resources(),
    theme_dashboard(),
    # List the first level UI elements here
    dashboardPage(
      dashboardHeader(title = "Survey Designer"),
      dashboardSidebar(
        #minified = FALSE, 
        #collapsed = FALSE,
        #width = "10vw",
        sidebarMenu(
          menuItem("  Introduction", tabName = "Intro", icon = icon("circle-info")),
          menuItem("  Step 1. Define Context", tabName = "Context", icon = icon("location-dot")),
          menuItem("  Step 2. Configure Content", tabName = "Content", icon = icon("arrows-to-circle")),
          menuItem("  Step 3. Set up Collection", tabName = "Collection", icon = icon("list-check")),
          menuItem("  Step 4. Publish Surveys", tabName = "Forms", icon = icon("share-from-square"))
        )
      ),
      
      dashboardBody(
        tabItems(
          tabItem(
            tabName = "Intro",
            fluidRow( 
              "--WARNING - you are now viewing the prototype wireframe - the application is not yet functional--",
              tags$a(href="https://github.com/unhcr-americas/surveyDesigner", "Please check the github repo for more info and to provide feedback!"),
              
              box(title = "",
                  width = NULL,
                  collapsible = FALSE,
                  status = "info",
                  
                  
                  tags$div(class = "jumbotron text-left", 
                           style = "margin-bottom:15px;margin-top:15px;margin-left:15px",
                           tags$h1(style = 'color:#0072BC;',
                                   style = 'margin-bottom:0px;margin-top:0px',
                                   'As the Survey Coordinator in an Operation, integrating, configuring and tailoring multiple surveys at once 
                  is often challenging!'),
                           tags$p(class = 'jumbotron-heading', 
                                   style = 'margin-left:25px',
                                   'How can you confirm that you will not miss a specific data point to calculate your final indicators and disaggregation?... 
                  How can you make sure to enforce all existing standards and good practises while also contextualising the labels?... 
                  How can you maximise your resources to collect your data in a smart way, through multiple waves and modes?...  ' )
                  ), ## end jumbotron..
                  tags$br(), 
                  "This app is brought to you to address those complex challenges and aims to help to:" ,
                  tags$ol(
                    tags$li(" Enforce a questionnaire design process that starts from a",tags$b(" selection of indicators ") ,"that needs
                            to be measured and pre-select automatically all the required standardized survey modules and
                            questions in order to measure them. Not only this shall ensure that standards are actually used, 
                            but it will also minimize the risk of questionnaire design mistakes" ), 
                    tags$li(" Ease the",tags$b(" contextualization process ") ,"from the global referential to the actual implementation 
                            in each country (i.e translating and adjusting the labels as per the specific context) and
                            facilitate the feedback loop so that if the same ad-hoc questions are used in multiple context,
                            they can be considered for inclusion in the global referential "), 
                    tags$li(" Support the usage of  mixed-mode (CAPI/CATI/CAWI) and multiple data collection waves
                            to collect the final dataset within an",tags$b(" annual survey data collection cycle") ,", all of
                            this allowing both to promote survey integration and to maximize the financial 
                            resources invested in those activities" )
                     ) 
                  #tags$br(), 
                  ) 
            ),
            fluidRow( 
              # Valid statuses are: primary, success, info, warning, danger.
              column(
                3,
                box(title = " Step 1. Define Context",
                    width = NULL,
                    collapsible = FALSE,
                    status = "warning",
                    "First, document the operational purpose of the data that you will need to collect for the incoming cycle.",
                    tags$br(), 
                    "This will be the first be the first filter of the design process",
                    tags$br(),
                    actionButton(inputId="start",
                                 label="Start now!",
                                 icon("location-dot") )
                )
               ),
              column(
                3,
                box(title = " Step 2. Configure Content", 
                    width = NULL, 
                    status = "warning",
                    "Second, based on the consultation with partners and sectoral experts, select the topics and indicators 
                      that needs to be covered for your annual survey cycle",
                    tags$br()  ) 
              ),
              column(
                  3,
                box(title = " Step 3. Set up Collection", 
                    width = NULL, 
                    collapsible = FALSE, 
                    status = "warning",
                    "Third, provides information about your data collection capacity, what kind
                      of mode can you use, how many waves can you afford, what sampling approach can you use...",
                    tags$br()  ) 
              ),
              column(
                3,
                box(title = " Step 4. Publish Surveys", 
                    width = NULL, 
                    collapsible = FALSE, 
                    status = "warning",
                    "Last, revise as pretty print word documents & export as xlsforms and the single or multiples 
                    questionnaires that you will be required to implement your annual survey cycle. 
                    You maybe need to then revise some questions labels. 
                    Once done, you will get all the files needed to collect the data through kobotoolbox ")
              )
            ) # End fluid row
          ),
          # Context #####
          tabItem(tabName = "Context",  
                  fluidRow( 
                    # Valid statuses are: primary, success, info, warning, danger.
                    column(
                      4,
                      box(title = " 1. Methodology / Operational Purpose",
                          width = NULL,
                          collapsible = FALSE,
                          status = "warning",
                          "  ",
                          tags$div(title="Interview",
                                   radioButtons("library",
                                              label =  " What global referential to use?" , 
                                               choices = list("Household Survey (Representative Stock)" = "household_survey", 
                                                              "Flow Monitoring (People not aiming to establish residence)" = "flow_monitoring",
                                                              "Key Informant (Persons with knowledge)" = "key_informant",
                                                              "Beneficiary Monitoring (Participant to an assistance program)" = "beneficiary_monitoring"), 
                                               selected = "household_survey" )  ),
                          tags$br(),
                          " Referentials are globally managed. They are based on international standards when possible") 
                    ),
                    column(
                      4,
                      box(title = " 2. Country", 
                          width = NULL, 
                          status = "warning",
                          " ",
                          tags$div(title="Select your country ",
                                   selectInput("context", 
                                               label = "Country, defining then required languages & geographic Pcodes", 
                                               choices = list("Panama" = "Panama", 
                                                              "Colombia" = "Colombia",
                                                              "Ecuador" = "Ecuador" ), 
                                               selected = "Panama")  ),
                          tags$br(),
                          
                          tags$div(title="Geographic Coverage ",
                                   selectInput("context", 
                                               label = "Are you aiming for a full national coverage?", 
                                               choices = list("yes" = "Yes", 
                                                              "no" = "No" ), 
                                               selected = "yes")  ),
                          
                          "- this will pull up automatically the caseload that should be 
                          covered based on your annual statistical report and implement 
                          the languages translation and geographic breakdown required for the country",
                          br(),
                          br(),
                          br(),
                          hr(),
                          " Global referentials are contextualised for each country through the regional survey support capacity in the bureau",
                          br(),
                          "if your country does not appear in the that list, ignite a contextualisation request",
                          br(),
                          actionButton(inputId="contextualisationRequest",
                                       label="Request Contextualisation",
                                       icon("gears"))  ,
                          tags$br(),
                          tags$br()  ) 
                    ),
                    column(
                      4,
                      box(title = " 3. Population Groups to Cover", 
                          width = NULL, 
                          collapsible = FALSE, 
                          status = "warning",
                          " ",
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
                          tags$br()  ))
                       )
                    )
                  ) ,                 
                  fluidRow( 
                    # Valid statuses are: primary, success, info, warning, danger.
                    column(
                      12,
                      box(title = " Context Summary",
                          width = NULL,
                          collapsible = FALSE,
                          status = "success",
                          " ",
                          hr(),
                          actionButton(inputId="start",
                                   label="Configure Content",
                                   icon("arrows-to-circle"))
                    ) 
                    )
                  )# End fluid row
          ), ## end context tiem
          
          # Content #####
          tabItem(tabName = "Content",  
                  fluidRow( 
                    # Valid statuses are: primary, success, info, warning, danger.
                    column(
                      3,
                      box(title = " 1. Topics",
                          width = NULL,
                          collapsible = FALSE,
                          status = "warning",
                          checkboxGroupInput("topic", 
                                             label = "Select the Topics  to prioritise", 
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
                          tags$br(),
                          p(" This will filters the corresponding indicators") ,
                          tags$br()  ) 
                    ),
                    column(
                      3,
                      box(title = " 2. Indicators", 
                          width = NULL, 
                          status = "warning",
                          " Now select the indicators from the filtered list ",
                          " ",
                          tags$br()  ) 
                    ),
                    column(
                      3,
                      box(title = " 3. Disaggregation", 
                          width = NULL, 
                          collapsible = FALSE, 
                          status = "warning",
                          " Required disaggregation for crosstabulations",
                          tags$div(title="Required Disaggregation for Crosstabulation",
                                   checkboxGroupInput("Disaggregation",
                                                      label = "Disaggregation",
                                                      choices = list("Age"="Gender",
                                                                     "Gender"="Gender",
                                                                     "Disability"="Disability",
                                                                     "Site"="Site" ),
                                                      selected = "Age")  ),
                                                      tags$br()  )
                      ),
                    column(
                      3,
                      box(title = " 4. Context-specific Questions", 
                          width = NULL, 
                          status = "warning",
                          " You can add context specific questions- 
                          i.e. Questions that have not been defined in the global referential. 
                          Thoses questions will be shared back with the global referential manager
                          for potential inclusion in the next release of the referential",
                          " ",
                          tags$br()  ) 
                    )
                  ) ,                 
                  fluidRow( 
                    # Valid statuses are: primary, success, info, warning, danger.
                    column(
                      12,
                      box(title = " Indicator Plan -- Analysis",
                          width = NULL,
                          collapsible = FALSE,
                          status = "success",
                          " ",
                          hr(),
                          actionButton(inputId="start",
                                   label="Set up Collection",
                                   icon("list-check"))
                     ) 
                    )
                  )# End fluid row
          ),  # end content item...
          
          # Collection ####
          tabItem(tabName = "Collection" ,                 
            fluidRow( 
            # Valid statuses are: primary, success, info, warning, danger.
            column(
              4,
              box(title = " 1. Modes",
                  width = NULL,
                  collapsible = FALSE,
                  status = "warning",
                  "Using multiple data collection mode in parallel can help minimizing 
                             non-reponse and increase coverage.",
                  checkboxGroupInput("mode", 
                                     label =  "What Data Collection Modes do you have capacity to implement for this annual cycle?" , 
                                     choiceNames = list(
                                                list(
                                                  icon("clipboard-question"),
                                                  "CAPI"="CAPI, i.e. Face-to-face "
                                                ), 
                                                list(
                                                  icon("phone-square") ,
                                                  "CATI"="CATI, i.e. Phone-Interview "  
                                                ), 
                                                list(
                                                  icon("wifi"),
                                                  "CAWI"= "CAWI, i.e. Self-administered "  
                                                )),
                                              choiceValues =  list("CAPI"  , 
                                                                   "CATI"  ,
                                                                   "CAWI" )),
                  tags$br() ) 
            ),
            column(
              4,
              box(title = " 2.Waves", 
                  width = NULL, 
                  status = "warning",
                  " Define how many data collection waves you can manage within the year.
                  The more data collection wave the more indicators can be collected. ",
                  " ",
                  selectInput("wave", 
                              label = "How many data collection waves for this annual cycle?", 
                              choices = list("One Wave" = "One-wave", 
                                             "Two Waves" = "Two-waves",
                                             "Three Waves" = "Three-waves",
                                             "Four Waves" = "Four-waves" ), 
                              selected = "Two-waves"),
                  "As a result of this stage, below is an estimation of Interview lenght per questionnaire",
                  tags$br()  ) 
            ),
            column(
              4,
              box(title = " 3. Sampling approach", 
                  width = NULL, 
                  collapsible = FALSE, 
                  status = "warning",
                  " ",
                  tags$div(title="Required Disaggregation for Crosstabulation",
                           checkboxGroupInput("Disaggregation",
                                              label = "Disaggregation",
                                              choices = list("Age"="Gender",
                                                             "Gender"="Gender",
                                                             "Disability"="Disability",
                                                             "Site"="Site" ),
                                              selected = "Age")  ),
                  tags$br()  )
            )
          ) ,                 
          fluidRow( 
            # Valid statuses are: primary, success, info, warning, danger.
            column(
              12,
              box(title = " Data Collection Plan -- Analysis",
                  width = NULL,
                  collapsible = FALSE,
                  status = "success",
                  "Feedback on your data collection analysis plan based on estimated interview duration",
              hr(),
              actionButton(inputId="start",
                           label="Publish Survey",
                           icon("share-from-square")
                           )
              ))
            )# End fluid row
          ), # end collection item
          # Forms ####
          tabItem(tabName = "Forms", 
                  fluidRow( 
                    # Valid statuses are: primary, success, info, warning, danger.
                    column(
                      3,
                      box(title = " 1. Survey Introduction Scripts",
                          width = NULL,
                          collapsible = FALSE,
                          status = "warning",
                          " Add the script to introduce the survey",
                         tags$br(),  ) 
                    ),
                    column(
                      3,
                      box(title = " 2. Survey Modules Sequence", 
                          width = NULL, 
                          status = "warning",
                          " Adjust sequences ",
                          tags$br()  ) 
                    ),
                    column(
                      3,
                      box(title = " 3. Preview Questionnaires", 
                          width = NULL, 
                          collapsible = FALSE, 
                          status = "warning",
                          " Get a word version of the different questionnaires for an easy revision with field colleagues",
                          actionButton(inputId="start",
                                       label="Pretty Print",
                                       icon("file-word"))
                      )
                    ) ,
                    column(
                      3,
                      box(title = " 4. Labels Review Request", 
                          width = NULL, 
                          collapsible = FALSE, 
                          status = "warning",
                          " You may then request changes in the contextualised referentials.... ",
                          actionButton(inputId="start",
                                       label="Request Changes",
                                       icon("gears"))
                      )
                    )
                  ),
                  fluidRow( 
                    column(
                      6,
                    box(title = " Document", 
                        width = NULL, 
                        collapsible = FALSE, 
                        status = "success",
                        "Download the documentation for your annual survey data collection cycle",
                        actionButton(inputId="start",
                                     label="Annual survey data collection cycle",
                                     icon("boxes-packing"))
                      ) 
                    ),
                    column(
                      6,
                      box(title = " and Publish", 
                          width = NULL, 
                          collapsible = FALSE, 
                          status = "success",
                          "Publish all Surveys directly on kobotoolbox: ",
                          br(),
                          actionButton(inputId="start",
                                       label="Publish on Kobo",
                                       icon("paper-plane")),
                          br(),
                          " or download the corresponding xlsform files to upload on kobotoolbox: ",
                          br(),
                          actionButton(inputId="start",
                                       label="XlsForm",
                                       icon("file-excel"))
                        )
                      )
                )# End fluid row
          ) # end publish item
        ) #end all items
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

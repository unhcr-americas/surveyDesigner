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
          menuItem("  Step 4. Publish Surveys", tabName = "Forms", icon = icon("share-from-square")),
          menuItem(" -- Save or Load Session", icon = icon("floppy-disk"),
                                   menuSubItem("Save session Unique ID", tabName = "subitem1", icon = icon("angles-right")),
                                   menuSubItem("Load session using unique ID", tabName = "subitem2", icon = icon("angles-left")))
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
                           style = "margin-bottom:5px;margin-top:5px;margin-left:5px",
                           tags$h1(style = 'color:#0072BC;',
                                   style = 'margin-bottom:0px;margin-top:0px',
                                   'As Local Survey Coordinator, integrating, configuring and tailoring multiple surveys at once 
                  is often challenging!'),
                           tags$i(class = 'jumbotron-heading', 
                                   style = 'margin-left:25px',
                                   'How can you confirm that you will not miss a specific data point to calculate your final indicators and disaggregation?... 
                  How can you make sure to enforce all existing statistical standards and good practices while also contextualizing correctly questions labels?... 
                  How can you maximise your resources to collect your data smarty, through multiple waves and modes?...  ' )
                  ), ## end jumbotron..
                  "This app aims at addressing the complex challenges associated with the design of integrated surveys. It is expected to help:" ,
                  tags$ol(
                    tags$li(" Standardizing a questionnaire design process that starts with a",tags$b(" selection of indicators ") ,"that needs
                            to be measured and thenpre-select automatically all the required standardized survey modules and
                            questions in order to measure them, aka 'collect only what you need and use everything that you collected'.
                            This will ensure that standards are applied, 
                            but it will also minimize the risk of questionnaire design mistakes" ), 
                    tags$li(" Easing the",tags$b(" contextualization process ") ,"from the global referential to the actual implementation 
                            in each country (i.e translating and adjusting the labels as per the specific context) and
                            facilitate a feedback loop so that if the same ad-hoc questions are used in multiple context,
                            they can be considered for inclusion in the global referential "), 
                    tags$li(" Supporting the usage of  mixed-mode (e.g.CAPI/CATI/CAWI) and multiple data collection waves
                            to collect the final dataset within an",tags$b(" annual survey data collection cycle") ,", all of
                            this allowing both to promote survey integration and to maximize the financial 
                            resources invested in those activities" )
                     ) 
                  #br(), 
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
                    br(), 
                    "This will be the first be the first filter of the design process",
                    br(),
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
                    br()  ) 
              ),
              column(
                  3,
                box(title = " Step 3. Set up Collection", 
                    width = NULL, 
                    collapsible = FALSE, 
                    status = "warning",
                    "Third, provides information about your data collection capacity, what kind
                      of mode can you use, how many waves can you afford, what enumeration capacity can you afford...",
                    br()  ) 
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
                      3,
                      box(title = " 1. Metadata", 
                          width = NULL, 
                          collapsible = FALSE, 
                          status = "warning",
                          " ",
                          textInput("caption",
                                    label="Title for your data collection project",
                                    value="short title"),
                          tags$div(title="  ",
                                   selectInput("context", 
                                               label = "Year for your data collection", 
                                               choices = list("2025" = "2025",
                                                              "2024" = "2024",
                                                              "2023" = "2023" ), 
                                               selected = "2023")  ),
                          textAreaInput("caption",
                                        label="Provide an abstract for the data collection activities",
                                        value="Who will collect? What sample frame can be used? What are the main field access constraints?", 
                                        width = "100%",
                                        height = "300px") 
                      )
                    ) ,
                    
                    column(
                      3,
                      box(title = " 2. Methodology / Operational Purpose",
                          width = NULL,
                          collapsible = FALSE,
                          status = "warning",
                          "  ",
                          tags$div(title="Interview",
                                   radioButtons("library",
                                              label =  " What global referential to use?" , 
                                               choices = list("Household Survey (Ideally representative of stable population in a protracted situation)" = "household_survey", 
                                                              "Flow Monitoring (People not aiming to establish their habitual residence in the place of interview)" = "flow_monitoring",
                                                              "Key Informant (Persons with local qualitative knowledge in an emergency situation)" = "key_informant"), 
                                               selected = "household_survey" )  ),
                          br(),
                          " Referentials are centrally managed by UNHCR Global Data Service. They are based on most appropriate international statistical standards (EGRISS, UN Stat Commissions, etc.)") 
                    ),
                    column(
                      3,
                      box(title = " 3. Country", 
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
                          br(),
                          
                          tags$div(title="Geographic Coverage ",
                                   selectInput("context", 
                                               label = "Are you aiming for a full national coverage?", 
                                               choices = list("yes" = "Yes", 
                                                              "no" = "No" ), 
                                               selected = "yes")  ),
                          
                          hr(),
                          "This will pull up the languages translation and geographic breakdown required for the country.",
                          " Global referentials are contextualised for each country through the regional survey support capacity in the bureau.",
                          "If your country does not appear in the that list, ignite a contextualisation request",
                          br(),
                          actionButton(inputId="contextualisationRequest",
                                       label="Contextualisation",
                                       icon("gears"))  ,
                          br()) 
                    ),
                    column(
                      3,
                      box(title = " 4. Targeted Groups", 
                          width = NULL, 
                          collapsible = FALSE, 
                          status = "warning",
                          " ",
                          tags$div(title="Population Group to cover",
                                   checkboxGroupInput("population", 
                                                      label = "Target Group", 
                                                      choices = list("Refugees (REF) & Asylum seekers (ASY)"="RAS", 
                                                                     "Internally displaced persons (IDP)"="IDP",
                                                                     "Other people in need of international protection (OIP)"="OIP",
                                                                     "Stateless Persons (STA)"="STA", 
                                                                     "Others of concern to UNHCR (OOC)"="OOC",
                                                                     "Returnee (RET)"="RET",
                                                                     "Host community (HCT)"="HCT"  ),  
                                                      
                          br()  ))
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
                                   label="Go to Configure Content",
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
                     6,
                      box(title = " 1. Apply filters ",
                          width = NULL,
                          collapsible = FALSE,
                          status = "warning",
                          " One indicator might be linked to mulitple topics and framewoks. 
                          You can use the different filters below to narrow down the list indicators
                          to search in",
                          br(),
                          
                          
                          fluidRow( 
                            # Valid statuses are: primary, success, info, warning, danger.
                            column(
                              6,
                              box(title = " Filters on Topics",
                                  width = NULL,
                                  collapsible = FALSE,
                                  status = "warning",
                                  checkboxGroupInput("topic", 
                                                     label = " Tick to filter", 
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
                                                                          "Information"  ))
                                  ) 
                            ),
                            column(
                              6,
                              box(title = " Filters on Framework", 
                                  width = NULL, 
                                  status = "warning",
                                  tags$div(title="Standard Indicators",
                                           checkboxGroupInput("Disaggregation",
                                                              label = " Tick to filter ",
                                                              choices = list("UNHCR Compass / RBM"="RBM",
                                                                             "UN Stat Commission / EGRISS"="EGRISS",
                                                                             "Sustainable Development Goal / SDG"="SDG",
                                                                             "Global Compact on Refugee / GCR"="GCR",
                                                                             "Humanitarian Sphere Standards"="Sphere",
                                                                             "Post Distribution & Assistance Monitoring"="PDM",
                                                                             "Assistance Targeting / Excellence Hub"="targeting",
                                                                             "Framework on Durable Solutions /IASC "="Durable",
                                                                             "Protection Mainstreaming / ECHO "="Durable",
                                                                             "Composite Indicator / Index"="Index"
                                                              )    ) )  
                              )
                            )
                            )
                          
                          
                          
                          
                          
                          )
                     ),
                    column(
                      3,
                      box(title = " 2. Select Indicators", 
                          width = NULL, 
                          status = "warning",
                          "Note that one indicator might requires multiples questions 
                          within the final survey to be calculated. 
                          Do not worry the app will take care of that complex step",
                          tags$div(title="Standard Indicators",
                                   checkboxGroupInput("indicator",
                                                      label = "Select indicators - to be turned to autocomplete-multiple selection..",
                                                      choices = list("Access to drinking water"="outcome12_1",
                                                                     "Residing in physically safe and secure settlements with access to basic facilities"="impact2_2",
                                                                     "Could access health facilities"="impact2_3",
                                                                     "Feeling safe walking alone"="impact3_3",
                                                                     "Children under 5 birth registered with civil authorities"="outcome1_2",
                                                                     "Has legally recognized documents"="outcome1_3",
                                                                     "Proportion of PoC who know where to access available GBV services"="outcome4_1",
                                                                     "Do not accept violence against women"="outcome4_2",
                                                                     "With primary reliance on clean (cooking) fuels and technology"="outcome8_2",
                                                                     "Living in Habitable and affordable shelter"="outcome9_1",
                                                                     "Access to energy to ensure lighting"="outcome9_2",
                                                                     "With access to a safe household toilet"="outcome12_2",
                                                                     "With a bank account or mobile-money service provider"="outcome13_1",
                                                                     "Working age individuals who are unemployed"="outcome13_3",
                                                                     "With secure tenure and/or property rights"="outcome16_1",
                                                                     "Covered by social protection floors/systems"="outcome16_2",
                                                                     "and so on..."="oo"
                                                      )    ) )  
                      )
                    ),
                    column(
                      3,
                      box(title = " 3. Context-specific Questions", 
                          width = NULL, 
                          status = "warning",
                          " You may here add context specific questions, that is to say questions for which
                          the equivalent statistical construct is not (yet) available within the global referential. 
                          Thoses questions will be shared back with the global referential manager
                          for potential inclusion in the next release of the referential", 
                          br()  ,
                          hr(),
                          actionButton(inputId="start",
                                       label="Select  / Define Ad-hoc Questions",
                                       icon("gears"))) 
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
                          " A small summary review will be automatically generated below. 
                          it's not for data entry but rather to output a summary 
                          of the decision points that have been set up above.. 
                          For instance - indicating how many unique questions 
                          would be required in order to compile all the indicators
                          that got selected..", 
                          br(),
                          hr(),
                          actionButton(inputId="start",
                                   label="Next Set up Collection",
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
                  "Using multiple data collection modes can help minimizing 
                             non-reponse and increase coverage. ",
                  tags$a(href="https://www.youtube.com/watch?v=qRmy2OAnyWc", "Learn more on mixed-mode here"),
                  br(),
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
                  br() ) 
            ),
            column(
              4,
              box(title = " 2. Waves", 
                  width = NULL, 
                  status = "warning",
                  " Define how many data collection waves you can manage within the year.",
                  
                  "Using multiple data collection waves can provide an opportunity for
                  more indicators to be collected. ",
                  tags$a(href="https://openknowledge.worldbank.org/server/api/core/bitstreams/e80ce277-f8d0-58aa-87b7-288c2895e87a/content#page=4", "Learn more on multi-waves here"),
                  
                  br(),
                  selectInput("wave", 
                              label = "How many data collection waves for this annual cycle?", 
                              choices = list("One Wave" = "One-wave", 
                                             "Two Waves" = "Two-waves",
                                             "Three Waves" = "Three-waves",
                                             "Four Waves" = "Four-waves" ), 
                              selected = "One-waves"),
                  "As a result of this stage, below is an estimation of Interview lenght per questionnaire",
                  br()  ) 
            ),
            column(
              4,
              box(title = " 3. Enumeration Capacity", 
                  width = NULL, 
                  collapsible = FALSE, 
                  status = "warning", 
                  # tags$div(title="Budget",
                  #          numericInput("budget in $",
                  #                       label = "Available Annual Budget for Data Collection (in US$)",
                  #                       30000, 
                  #                       min = 5000, 
                  #                       max = 500000) ),
                  "The Maximum monthly data collection  depends on the capacity of the 
                  organisation that partners or on the company that got contracted for that activity",
                 
                  hr(),
                  tags$div(title="Face1",
                           numericInput("face",
                                        label = "Total Cost per Interview (in US$) for Face to face",
                                        50, min = 20, max = 300) ),
                  tags$div(title="Face2",
                           numericInput("face",
                                        label = "Max Capacity of monthly working day for Face to face enumerators",
                                        50, min = 1, max = 100) ),
                  hr(),
                  tags$div(title="Face1",
                           numericInput("face",
                                        label = "Total Cost per Interview (in US$) for Telephone",
                                        20, min = 5, max = 100) ),
                  
                  tags$div(title="Call Center enumerators",
                           numericInput("face",
                                        label = "Max Capacity of monthly working day for Call Center enumerators",
                                        20, min = 1, max = 100) ),
                  br()  )
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
                  "Feedback on your data collection analysis plan based on 
                  estimated interview duration, budget and enumeration capacity 
                  will be automatically generated below. 
                   indication of the suggested length of the interview given the mode: 
                   CAPI, 60-90 min; CATI; 30-45 min…and that dictates the number 
                   of questions that are able to be included.
                  function for that  https://edouard-legoupil.github.io/XlsFormPrettyPrint/reference/interview_duration.html",
              hr(),
              actionButton(inputId="start",
                           label="Now Publish Survey",
                           icon("share-from-square")
                           )
              ))
            )# End fluid row
          ), # end collection item
          # Forms ####
          tabItem(tabName = "Forms", 
                  fluidRow( 
                    # Valid statuses are: primary, success, info, warning, danger.
                    # column(
                    #   3,
                    #   box(title = " 1. Survey Introduction Scripts",
                    #       width = NULL,
                    #       collapsible = FALSE,
                    #       status = "warning",
                    #       " This is the text that enumerator shold use to introduce the interview. 
                    #       It is important for it to be context sensitive... ",
                    #       textAreaInput("caption",
                    #                     label="Add the script",
                    #                     value=" Hello, my name is .. and we would like to interview you for.... 
                    #                     Data will be used by.. You will be able to see aggregated results here...", 
                    #                     width = "100%"),
                    #       br()    ) 
                    # ),
                    column(
                      4,
                      box(title = " 1. Survey Modules Sequence", 
                          width = NULL, 
                          status = "warning",
                          " You can adjust the default sequence between modules and
                          then between questions within modules.",
                          br(),
                          "Note that the design already comes with suggested sequence of modules.
                          For instance depending on the mode, sensitive or longer/more complicated
                          questions comes towards the end for CAPI while they are more at the begining for CATI. 
                          Also not all sequences can be changed as the questionnaire logic comes with hard constraints
                          to be respected.",
                          br(),
                          actionButton(inputId="start",
                                       label="Change Sequence",
                                       icon("gears")) ) 
                    ),
                    column(
                      4,
                      box(title = " 2. Preview Questionnaires", 
                          width = NULL, 
                          collapsible = FALSE, 
                          status = "warning",
                          " Get a word version of the different questionnaires for a review with field colleagues",
                          br(),
                          actionButton(inputId="start",
                                       label="Pretty Print",
                                       icon("file-word"))
                      )
                    ) ,
                    column(
                      4,
                      box(title = " 3. Labels Review", 
                          width = NULL, 
                          collapsible = FALSE, 
                          status = "warning",
                          " Building on expert review, use this function to apply changes in the contextualisable content.... ",
                          br(),
                          actionButton(inputId="start",
                                       label="Labels",
                                       icon("gears"))
                      )
                    )
                  ),
                  fluidRow( 
                    column(
                      6,
                    box(title = " Documentation", 
                        width = NULL, 
                        collapsible = FALSE, 
                        status = "success",
                        "Download the documentation for your annual survey data collection cycle",
                        actionButton(inputId="start",
                                     label="Annual Survey Cycle",
                                     icon("boxes-packing"))
                      ) 
                    ),
                    column(
                      6,
                      box(title = " Publication", 
                          width = NULL, 
                          collapsible = FALSE, 
                          status = "success",
                          "Publish all Surveys directly on the data collection server: ",
                          br(),
                          actionButton(inputId="start",
                                       label="Publish on Kobo",
                                       icon("paper-plane")),
                          br(),
                          " or download the corresponding xlsform files to upload them yourself on kobotoolbox: ",
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

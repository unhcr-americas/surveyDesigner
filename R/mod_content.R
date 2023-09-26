#' Module UI

#' @title mod_content_ui and mod_content_server
#' @description A shiny module.
#' @description A shiny module.
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @import shiny
#' @import shinydashboard
#' @keywords internal

mod_content_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "content",
		fluidRow(
				 column(
				 width = 12,
						 h2('Step 2. Configure Content'),
						 p("Second, based on the consultation with partners and sectoral
						   experts, select the topics and indicators that needs to be covered
						   for your annual survey cycle ")
					 )
				 ),

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
		                checkboxGroupInput(inputId = ns("topic"),
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
		                         checkboxGroupInput(inputId = ns("Disaggregation"),
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
		                 checkboxGroupInput(inputId = ns("indicator"),
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
		        actionButton(inputId = ns("start"),
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
		        actionButton(inputId = ns("start"),
		                     label="Next Set up Collection",
		                     icon("list-check"))
		    )
		)# End fluid row

		)
	)
}

#' Module Server
#' @noRd
#' @import shiny
#' @import tidyverse
#' @keywords internal

mod_content_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns
## add here the server logic part of your module....
}

## copy to body.R
# mod_content_ui("content_ui_1")

## copy to sidebar.R
# shinydashboard::menuItem("displayName",tabName = "content",icon = icon("user"))

## and copy to app_server.R
# callModule(mod_content_server, "content_ui_1", AppReactiveValue)


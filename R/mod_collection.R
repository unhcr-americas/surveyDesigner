#' Module UI

#' @title mod_collection_ui and mod_collection_server
#' @description A shiny module.
#' @description A shiny module.
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @import shiny
#' @import shinydashboard
#' @keywords internal

mod_collection_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "collection",
		fluidRow(
				 column(
				 width = 12,
						 h2('Step 3. Set up Collection'),
						 p("Third, provides information about your data collection capacity,
						   what kind of mode can you use, how many waves can you afford,
						   what enumeration capacity can you afford... ")
					 )
				 ),

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
		        checkboxGroupInput(inputId = ns("mode"),
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
		        selectInput(inputId = ns("wave"),
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
		                 numericInput(inputId = ns("face1"),
		                              label = "Total Cost per Interview (in US$) for Face to face",
		                              50, min = 20, max = 300) ),
		        tags$div(title="Face2",
		                 numericInput(inputId = ns("face2"),
		                              label = "Max Capacity of monthly working day for Face to face enumerators",
		                              50, min = 1, max = 100) ),
		        hr(),
		        tags$div(title="Tel1",
		                 numericInput(inputId = ns("Tel1"),
		                              label = "Total Cost per Interview (in US$) for Telephone",
		                              20, min = 5, max = 100) ),

		        tags$div(title="Call Center enumerators",
		                 numericInput(inputId = ns("callcenter"),
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
		        actionButton(inputId = ns("start"),
		                     label="Now Publish Survey",
		                     icon("share-from-square")
		        )
		    ))
		)# End fluid row
	)
}

#' Module Server
#' @noRd
#' @import shiny
#' @import tidyverse
#' @keywords internal

mod_collection_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns
## add here the server logic part of your module....
}

## copy to body.R
# mod_collection_ui("collection_ui_1")

## copy to sidebar.R
# shinydashboard::menuItem("displayName",tabName = "collection",icon = icon("user"))

## and copy to app_server.R
# callModule(mod_collection_server, "collection_ui_1", AppReactiveValue)


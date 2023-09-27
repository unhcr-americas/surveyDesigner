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
						 h2('Step 3. Optimizing Data Collection, the "Cost-Quality" Tradeoff'),
						 p("High-quality survey data collection is getting more expensive to 
						 conduct because of decreasing response rates and rising data collection costs. 
						 Based data collection capacity and data collection mode opportunity, 
						 efforts can be optimised through one or many data collection waves... "),
				 "Using multiple data collection waves can provide an opportunity for
                  more indicators to be collected. ",
				 tags$a(href="https://openknowledge.worldbank.org/server/api/core/bitstreams/e80ce277-f8d0-58aa-87b7-288c2895e87a/content#page=4", "Learn more on multi-waves here"),
				 
					 )
				 ),

		fluidRow(
		  # Valid statuses are: primary, success, info, warning, danger.
		  column(
		    3,
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
		                                                "CAWI" )) 
		        )
		  ),
		  column(
		    4,
		    box(title = " 2. Survey Respondant Attrition",
		        # https://academic.oup.com/jssam/advance-article-abstract/doi/10.1093/jssam/smad028/7255957?redirectedFrom=fulltext
		        # https://academic.oup.com/jssam/advance-article-abstract/doi/10.1093/jssam/smad007/7111262?redirectedFrom=fulltext&login=false
		        width = NULL,
		        collapsible = FALSE,
		        status = "warning",
		        "Survey respondent attrition is the loss of participants during the 
		        course of a survey, often due to factors like survey length or lack of motivation. 
		        It directly influences the total cost of the survey and can be used to optimise survey design", 
		        
		        hr(),
		        
		        fluidRow(
		          column(
		            6,
		            "Face to face",
		            sliderInput( inputId =   ns("attemptcapi"),
		                         label = "Define average number of attempt per interview",
		                         value = 2,  min = 0 , max = 10, step = 1 ,
		                         width = '100%'),	
		            sliderInput( inputId =   ns("responsecorrelationcapi"),
		                         label = "Define correlation between response rate and interview duration ",
		                         value = 0.4,  min = 0 , max = 1, step = 0.1 ,
		                         width = '100%')
		          ),
		          column(
		            6,
		            "Telephone",
		            sliderInput( inputId =   ns("attemptcati"),
		                         label = "Define average number of attempt per interview",
		                         value = 4,  min = 0 , max = 10, step = 1 ,
		                         width = '100%'),	
		            sliderInput( inputId =   ns("responsecorrelationcati"),
		                         label = "Define correlation between response rate and interview duration ",
		                         value = 0.6,  min = 0 , max = 1, step = 0.1 ,
		                         width = '100%')
		          )
		        )
		    )
		  ),
		  
		  column(
		    4,
		    box(title = " 2. Enumeration Capacity",
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
		        
		        fluidRow(
		          column(
		            6,
		            "Face to face",
		        tags$div(title="Face1",
		                 sliderInput(inputId = ns("face1"),
		                              label = "Total Cost per Interview (in US$) for Face to face",
		                              50, min = 20, max = 300) ),
		        tags$div(title="Face2",
		                 sliderInput(inputId = ns("face2"),
		                              label = "Max Capacity of monthly working day for Face to face enumerators",
		                              50, min = 1, max = 100) ) 
		          ),
		        column(
		          6,
		          "Telephone",
		        tags$div(title="Tel1",
		                 sliderInput(inputId = ns("Tel1"),
		                              label = "Total Cost per Interview (in US$) for Telephone",
		                              20, min = 5, max = 100) ),

		        tags$div(title="Call Center enumerators",
		                 sliderInput(inputId = ns("callcenter"),
		                              label = "Max Capacity of monthly working day for Call Center enumerators",
		                              20, min = 1, max = 100) ) 
		           )
		        )
		    )
		  )
		  ),
		 fluidRow(
		    column(
		      12,
		      box(title = " Data Collection Plan Review",
		          width = NULL,
		          collapsible = FALSE,
		          status = "success",
		          actionButton(inputId = ns("ApplyCollection"),
		                       label="Optimise Collection",
		                       icon("calculator")),
		          hr(),
		          "See below some feedback on your data collection plan based on
                  estimated interview duration, budget and enumeration capacity.
               Indication of the suggested length of the interview given the mode:
               can help informing and spliting the content of questionnaires in multiple wave.",
		          
		          verbatimTextOutput( outputId = ns("collectionsummary"))
		          )
		      )
		) ,
		fluidRow(
		  # Valid statuses are: primary, success, info, warning, danger.
		  column(
		    12,
		    box(title = " Set up number of Waves",
		        width = NULL,
		        status = "warning",
		        " Based on simulation above, decide on how many data collection waves you can manage within the year.",
		        br(),
		        sliderInput( inputId =   ns("wave"),
		                     label = "Set final # data collection waves for this annual cycle",
		                     value = 1,  min = 1 , max = 4, step = 1 ,
		                     width = '400px'),
		        
		        # selectInput(inputId = ns("wave"),
		        #             label = "How many data collection waves for this annual cycle?",
		        #             choices = list("One Wave" = "One-wave",
		        #                            "Two Waves" = "Two-waves",
		        #                            "Three Waves" = "Three-waves",
		        #                            "Four Waves" = "Four-waves" ),
		        #             selected = "One-waves"),
		        "As a result of this stage, the app will generate one or more than one xlsform files!",
		        br()  )
		  )
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


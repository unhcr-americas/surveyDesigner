#' Module UI

#' @title mod_forms_ui and mod_forms_server
#' @description A shiny module.
#' @description A shiny module.
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @import shiny
#' @import shinydashboard
#' @keywords internal

mod_forms_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "forms",
		fluidRow(
				 column(
				 width = 12,
						 h2('Step 4. Publish Surveys'),
						 p("Last, revise as pretty print word documents & export as xlsforms
						   and the single or multiples questionnaires that you will be
						   required to implement your annual survey cycle.
						   You maybe need to then revise some questions labels.
						   Once done, you will get all the files needed to collect the data
						   through kobotoolbox ")
					 )
				 ),

		fluidRow(
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
		        actionButton(inputId = ns("changeseq"),
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
		        actionButton(inputId = ns("pretty"),
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
		        actionButton(inputId = ns("revlabel"),
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
		        actionButton(inputId = ns("document"),
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
		        actionButton(inputId = ns("publishkobo"),
		                     label="Publish on Kobo",
		                     icon("paper-plane")),
		        br(),
		        " or download the corresponding xlsform files to upload them yourself on kobotoolbox: ",
		        br(),
		        actionButton(inputId = ns("getxlsform"),
		                     label="XlsForm",
		                     icon("file-excel"))
		    )
		  )
		)# End fluid row
	)
}

#' Module Server
#' @noRd
#' @import shiny
#' @import tidyverse
#' @keywords internal

mod_forms_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns
## add here the server logic part of your module....
}

## copy to body.R
# mod_forms_ui("forms_ui_1")

## copy to sidebar.R
# shinydashboard::menuItem("displayName",tabName = "forms",icon = icon("user"))

## and copy to app_server.R
# callModule(mod_forms_server, "forms_ui_1", AppReactiveValue)


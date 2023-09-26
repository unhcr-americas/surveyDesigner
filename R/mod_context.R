#' Module UI

#' @title mod_context_ui and mod_context_server
#' @description A shiny module.
#' @description A shiny module.
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#' @import shiny
#' @import shinydashboard
#' @keywords internal

mod_context_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "context",
		fluidRow(
				 column(
				 width = 12,
						 h2(' Step 1. Define Context'),
						 p("First, document the operational purpose of the data that you will need to collect for the incoming cycle.
This will be the first be the first filter of the design process ")
					 )
				 ),

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
		                 selectInput(inputId = ns("context"),
		                             label = "Year for your data collection",
		                             choices = list("2025" = "2025",
		                                            "2024" = "2024",
		                                            "2023" = "2023" ),
		                             selected = "2023")  ),
		        textAreaInput(inputId = ns("caption"),
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
		                 radioButtons(inputId = ns("library"),
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
		                 selectInput(inputId = ns("context"),
		                             label = "Country, defining then required languages & geographic Pcodes",
		                             choices = list("Panama" = "Panama",
		                                            "Colombia" = "Colombia",
		                                            "Ecuador" = "Ecuador" ),
		                             selected = "Panama")  ),
		        br(),

		        tags$div(title="Geographic Coverage ",
		                 selectInput(inputId = ns("context"),
		                             label = "Are you aiming for a full national coverage?",
		                             choices = list("yes" = "Yes",
		                                            "no" = "No" ),
		                             selected = "yes")  ),

		        hr(),
		        "This will pull up the languages translation and geographic breakdown required for the country.",
		        " Global referentials are contextualised for each country through the regional survey support capacity in the bureau.",
		        "If your country does not appear in the that list, ignite a contextualisation request",
		        br(),
		        actionButton(inputId = ns("contextualisationRequest"),
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
		                 checkboxGroupInput(inputId = ns("population"),
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
		        actionButton(inputId = ns("start"),
		                     label="Go to Configure Content",
		                     icon("arrows-to-circle"))
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

mod_context_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns
## add here the server logic part of your module....
}

## copy to body.R
# mod_context_ui("context_ui_1")

## copy to sidebar.R
# shinydashboard::menuItem("displayName",tabName = "context",icon = icon("user"))

## and copy to app_server.R
# callModule(mod_context_server, "context_ui_1", AppReactiveValue)


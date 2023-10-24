# Module UI Home

#' @title mod_home_ui and mod_home_server
#' @description A shiny module.
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal

mod_home_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "home",
		absolutePanel(  ## refers to a css class
		  id = "splash_panel", top = 0, left = 0, right = 0, bottom = 0,
		  ### Get the name for your tool
		  p(
		    tags$span("Survey Designer ", style = "font-size: 80px"),
		    tags$span("alpha-version", style = "font-size: 34px")
		  ),
		  br(),
		  ### Then a short explainer
		  p( "As Local Survey Coordinator, integrating, configuring and tailoring
		  multiple surveys at once is often challenging!
		  Including all data points expected by indicators calculations,
		  contextualizing correctly questions labels, maximising
		  resources for smarter data collect over multiple waves and modes are not straightforward processes... ",
		     style = "font-size: 20px"),
		  br(),
		  p( "This ",tags$span("companion app", style = "color:#00B398"), " aims at addressing the complex challenges associated with the design of integrated surveys. It is expected to help:" ,
		  tags$ol(
		    tags$li(" Standardizing a questionnaire design process that starts with a",tags$b(" selection of indicators ") ,"that needs
                            to be measured and thenpre-select automatically all the required standardized survey modules and
                            questions in order to measure them, aka 'collect only what you need and use everything that you collected'.
                            This will ensure that standards are applied,
                            but it will also minimize the risk of questionnaire design mistakes",
		            style = "font-size: 16px; text-align: left;" ),
		    tags$li(" Easing the",tags$b(" contextualization process ") ,"from the global referential to the actual implementation
                            in each country (i.e translating and adjusting the labels as per the specific context) and
                            facilitate a feedback loop so that if the same ad-hoc questions are used in multiple context,
                            they can be considered for inclusion in the global referential ",
		            style = "font-size: 16px; text-align: left;"),
		    tags$li(" Supporting the usage of  mixed-mode (e.g.CAPI/CATI/CAWI) and multiple data collection waves
                            to collect the final dataset within an",tags$b(" annual survey data collection cycle") ,", all of
                            this allowing both to promote survey integration and to maximize the financial
                            resources invested in those activities",
		            style = "font-size: 16px; text-align: left;" )
		  ) ,
		  style = "font-size: 16px; text-align: left;"),
		  br(),
		  p("This app is part of a ",tags$span("comprehensive app toolkit", style = "color:#00B398"),
		    " to mainstream knowledge & enhance the process of survey implementation through Kobotoolbox. It includes: ",
		    tags$a(href="https://rstudio.unhcr.org/rmsSampling/", "rmsSampling"), " to help designing sampling strategies, ",
		    tags$a(href="https://rstudio.unhcr.org/Survey_Designer", "SurveyDesigner"), " to help integrating annual survey needs, ",
		    tags$a(href="https://rstudio.unhcr.org/XlsFormUtil/", "XlsFormUtil"), " to help reviewing form contextualisation, ",
		    tags$a(href="https://rstudio.unhcr.org/HighFrequencyChecks/", "HighFrequencyChecks"), " to monitor data collection quality, ",
		    tags$a(href="https://rstudio.unhcr.org/kobocruncher/", "KoboCruncher"), " to perform rapid data exploration and compile indicators.",
		    style = "font-size: 12px"),
		  p(tags$i( class = "fa fa-github"),
		    "App built with ",
		    tags$a(href="https://edouard-legoupil.github.io/graveler/",
		           "{graveler}" ),
		    " -- report ",
		    tags$a(href="https://github.com/unhcr-americas/surveyDesigner/issues/new/choose",
		           "issues here." ,
		    ),
		    style = "font-size: 10px")
		)
	)
}

# Module Server
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal

mod_home_server <- function(input, output, session) {
	ns <- session$ns
	# This create the links for the button that allow to go to the next module
	observeEvent(input$go_to_firstmod, {
	  shinydashboard::updateTabItems(
	    session = parent_session,
	    inputId = "tab_selected",
	    selected = "firstmod"
	  )
	})
}

## copy to body.R
# mod_home_ui("home_ui_1")

## copy to app_server.R
# callModule(mod_home_server, "home_ui_1")

## copy to sidebar.R
# menuItem("displayName",tabName = "home",icon = icon("user"))


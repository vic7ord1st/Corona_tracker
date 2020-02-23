## ui.R ##
library(shinydashboard)
library(plotly)

dashboardPage(
  dashboardHeader(title = "Corona Virus Stats"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
    fluidRow(
      infoBoxOutput('currentlyInfected'),
      infoBoxOutput('mild_condition'),
      infoBoxOutput('recovered'),
    ),
    fluidRow(
      infoBoxOutput('cases_with_outcome'),
      infoBoxOutput('critical'),
      infoBoxOutput('deaths')
    ),
    fluidRow(column(
      box(
        title = "Corona Virus By Country",
        plotlyOutput('cases_by_country', height = 400, width = '100%'),
        width = '100%'
      ),
      width = 6
    ),
    column(
      box(
        title = "Total Deaths By Corona Virus",
        plotlyOutput('total_deaths', height = 400, width = '100%'),
        width = '100%'
        
      ),
      width = 6
      
    ))
  )
)
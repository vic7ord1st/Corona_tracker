## ui.R ##
library(shinydashboard)
library(plotly)

dashboardPage(
    dashboardHeader(title = "Corona Virus Stats"),
    dashboardSidebar(disable = TRUE),
    dashboardBody(
      fluidRow(
        column(
          box( title = "Corona Virus By Country",
            plotlyOutput('cases_by_country', height = 250, width = '100%')
              ), width = 6
        ),
        column(
          box(title = "Total Deaths By Corona Virus",  
            plotlyOutput('total_deaths', height = 250, widht = '100%')
        ), width = 6
        
      )
    )
  )
)
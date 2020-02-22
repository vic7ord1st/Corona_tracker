## app.R ##
library(shiny)
library(shinydashboard)
library(plotly)
library(httr)
library(jsonlite)


totalDeaths <-
  GET('http://localhost:3000/totalDeaths') %>% content('text') %>% fromJSON() %>%
  as.data.frame()
casesByRegion <-
  GET('http://localhost:3000/casesByRegion') %>% content('text') %>% fromJSON() %>%
  as.data.frame()

totalDeaths$date <- as.Date(totalDeaths$date, format = "%b. %d")
totalDeaths$total_deaths <- as.integer(paste(gsub(",", "", totalDeaths$total_deaths)))
casesByRegion$count <- as.integer(paste(gsub(",", "", casesByRegion$count)))

server <- function(input, output) {
  output$cases_by_country <- renderPlotly(
    plot_ly(
      x = casesByRegion$country,
      y = log(casesByRegion$count),
      type = 'bar',
      text = casesByRegion$count,
      textposition = 'auto'
    ) %>% layout(
      xaxis = list(tickangle = 90, title = 'Countries'),
      yaxis = list(title = 'Log (Count)')
    )
  )
  
  output$total_deaths <- renderPlotly(
    plot_ly(
      x = totalDeaths$date,
      y = totalDeaths$total_deaths,
      type = 'scatter',
      mode = 'lines'
    )
  )
}

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

casesWithOutcome <-
  GET('http://localhost:3000/casesWithOutcome') %>% content('text') %>% fromJSON() %>%
  as.data.frame()

currentlyInfected <-
  GET('http://localhost:3000/currentlyInfected') %>% content('text') %>% fromJSON() %>%
  as.data.frame()




totalDeaths$date <- as.Date(totalDeaths$date, format = "%b. %d")
totalDeaths$total_deaths <-
  as.integer(paste(gsub(",", "", totalDeaths$total_deaths)))
casesByRegion$count <-
  as.integer(paste(gsub(",", "", casesByRegion$count)))

server <- function(input, output) {
  output$cases_by_country <- renderPlotly(
    plot_ly(
      x = casesByRegion$country,
      y = log(casesByRegion$count),
      type = 'bar',
      text = casesByRegion$count,
      textposition = 'auto',
      marker = list(color = 'rgb(126,132,134)')
    ) %>% layout(
      xaxis = list(tickangle = 90),
      yaxis = list(title = 'Log (Count)')
    )
  )
  
  output$total_deaths <- renderPlotly(
    plot_ly(
      x = totalDeaths$date,
      y = totalDeaths$total_deaths,
      type = 'scatter',
      mode = 'lines',
      color = I('red')
    )
  )
  
  output$currentlyInfected <- renderInfoBox({
    infoBox("Currently Infected",
            paste0(currentlyInfected$currently_infected), icon = icon('bug'))
  })
  
  output$mild_condition <- renderInfoBox({
    infoBox("Mild Condition",
            paste0(currentlyInfected$mild_condition), icon = icon('first-aid'))
  })

 
  output$cases_with_outcome<- renderInfoBox({
    infoBox("Cases with Outcome", paste0(casesWithOutcome$cases_with_outcome), icon = icon('procedures'))
  })
  
  output$critical <- renderInfoBox({
    infoBox("Critical", paste0(currentlyInfected$critical), icon = icon('ambulance'))
  })
  
  output$recovered<- renderInfoBox({
    infoBox("Recovered", paste0(casesWithOutcome$recovered), icon = icon('capsules'), color = 'green')
  })
  
  output$deaths<- renderInfoBox({
    infoBox("Deaths", paste0(casesWithOutcome$deaths), icon = icon('skull'), color = 'red')
  })
}

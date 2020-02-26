## app.R ##
library(shiny)
library(shinydashboard)
library(plotly)
library(httr)
library(jsonlite)


totalDeaths <-
  GET('https://vast-waters-77927.herokuapp.com/totalDeaths') %>% content('text') %>% fromJSON() %>%
  as.data.frame()
casesByRegion <-
  GET('https://vast-waters-77927.herokuapp.com/casesByRegion') %>% content('text') %>% fromJSON() %>%
  as.data.frame()

casesWithOutcome <-
  GET('https://vast-waters-77927.herokuapp.com/casesWithOutcome') %>% content('text') %>% fromJSON() %>%
  as.data.frame()

currentlyInfected <-
  GET('https://vast-waters-77927.herokuapp.com/currentlyInfected') %>% content('text') %>% fromJSON() %>%
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
      text = ~ paste(
        'Location:',
        casesByRegion$country,
        '</br> Cases:',
        casesByRegion$count
      ),
      marker = list(color = 'rgb(126,132,134)')
    ) %>% layout(
      xaxis = list(tickangle = 90),
      yaxis = list(title = 'Log (Count)')
    ) %>% add_annotations(
      x = casesByRegion$country,
      y = log(casesByRegion$count) + 0.5,
      text = paste(
        formatC(
          casesByRegion$count,
          format = "f",
          big.mark = ",",
          digits = 0
        )
      ),
      valign = 'middle',
      font = list(family = 'Roboto', color = 'rgb(126,132,134)'),
      showarrow = FALSE
    )
  )
  
  output$total_deaths <- renderPlotly(
    plot_ly(
      x = totalDeaths$date,
      y = totalDeaths$total_deaths,
      type = 'scatter',
      mode = 'lines',
      color = I('red')
    ) %>% layout(xaxis = list(
      tickangle = 90,
      type = 'date',
      tickformat = '%d %B'
    ))
  )
  
  output$currentlyInfected <- renderInfoBox({
    infoBox("Currently Infected",
            paste0(
              formatC(
                currentlyInfected$currently_infected,
                format = "f",
                big.mark = ",",
                digits = 0
              )
            ),
            icon = icon('bug'))
  })
  output$mild_condition <- renderInfoBox({
    infoBox("Mild Condition",
            paste0(
              formatC(
                currentlyInfected$mild_condition,
                format = "f",
                big.mark = ",",
                digits = 0
              )
            ),
            icon = icon('first-aid'))
  })
  
  
  output$cases_with_outcome <- renderInfoBox({
    infoBox("Cases with Outcome",
            paste0(
              formatC(
                casesWithOutcome$cases_with_outcome,
                format = "f",
                big.mark = ",",
                digits = 0
              )
            ),
            icon = icon('procedures'))
  })
  
  output$critical <- renderInfoBox({
    infoBox("Critical",
            paste0(
              formatC(
                currentlyInfected$critical,
                format = "f",
                big.mark = ",",
                digits = 0
              )
            ),
            icon = icon('ambulance'))
  })
  
  output$recovered <- renderInfoBox({
    infoBox("Recovered",
            paste0(
              formatC(
                casesWithOutcome$recovered,
                format = "f",
                big.mark = ",",
                digits = 0
              )
            ),
            icon = icon('capsules'),
            color = 'green')
  })
  output$deaths <- renderInfoBox({
    infoBox("Deaths",
            paste0(
              formatC(
                casesWithOutcome$deaths,
                format = "f",
                big.mark = ",",
                digits = 0
              )
            ),
            icon = icon('skull'),
            color = 'red')
  })
}

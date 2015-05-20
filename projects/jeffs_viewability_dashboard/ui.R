library(shiny)
library(dygraphs)

shinyUI(fluidPage(
  titlePanel(
    img(src = 'logo.png'),
    tags$head(
      tags$title("Rocket Fuel - vPacer"))),
  hr(),
  sidebarPanel(
    width = 3,
    uiOutput('campaignControls'),
    uiOutput('lineItemControls'),
    uiOutput('flightControls'),
    dateRangeInput('dateUI', label = 'Date Range', 
                   start = Sys.time() - (120*24*60*60), 
                   end = Sys.time(), 
                   format = "yyyy-mm-dd", 
                   startview = "month", weekstart = 0,
                   language = "en", separator = " to "),
    uiOutput('vImpControls'),
    uiOutput('vCPMControls'),
    numericInput('paceMult', label = 'Pacing Multiplier (rfiImp/vImp)', value = 2.0, step = NA),
    br(),
    br(),
    br(),
    hr(),
    br(),
    helpText('vPacer v 0.1')
  ),
  
  mainPanel(width = 9,
    dygraphOutput('chart_out')
  )
  
  #######################################
  )  #fluidPage
) #shinyUI





#     dateRangeInput('dateUI', label = 'Date Range', 
#                    start = max(data$data_date) - 7, 
#                    end = max(datax$data_date), 
#                    format = "yyyy-mm-dd", 
#                    startview = "month", weekstart = 0,
#                    language = "en", separator = " to "),
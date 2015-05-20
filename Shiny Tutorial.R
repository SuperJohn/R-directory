## Shiny Tutorial

library(shiny)

runExample("01_hello")

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hello Shiny!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 20)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]  # Old Faithful Geyser data
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
})
View(unique(query1[, c("campaign_name","action_name")]))

system.file("examples", package="shiny")

# Lesson 5: Use R Scripts & Data 
# http://shiny.rstudio.com/tutorial/lesson5/
library(UScensus2010)
counties <- readRDS("shiny_examples/jh_census-app/data/counties.rds")
head(counties)
install.packages(c("maps", "mapproj"))
library(maps)
library(mapproj)
source("shiny_examples/jh_census-app/helpers.R")
counties <- readRDS("shiny_examples/jh_census-app/data/counties.rds")
percent_map(counties$white, "darkgreen", "% white")



# Examples: Shiny Examples
library(shiny)
runExample("01_hello") # a histogram
runExample("02_text") # tables and data frames
runExample("03_reactivity") # a reactive expression
runExample("04_mpg") # global variables
runExample("05_sliders") # slider bars
runExample("06_tabsets") # tabbed panels
runExample("07_widgets") # help text and submit buttons
runExample("08_html") # shiny app built from HTML
runExample("09_upload") # file upload wizard
runExample("10_download") # file download wizard
runExample("11_timer") # an automated timer

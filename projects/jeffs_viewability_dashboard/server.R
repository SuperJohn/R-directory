# Immediate goal is to get user adoption. Keep it simple. Solve a real problem. Address a pain point. Cut the fluff.
# Pain point is iterative calculation of rfi_impressions to pace when reporting is infrequent.
  # automate a lot of the calculations, and request as few mandatory inputs as possible. Autoload impressions.
# Pain point is flying blind, no great prediction engine.
  # pacing curve should be flexible based on past viewability rate, with minimum threshold.
# Pain point is anxiety around whether or not we're pacing (flying blind)
  # create a tool that is trustworthy and does its job consistently.

#######################################
# IMPORT LIBRARIES
#######################################

library(data.table)
library(plyr)
library(dplyr)
library(reshape2)
library(dygraphs)
library(shiny)

#######################################
# IMPORT DATA, GLOBALLY, FIRST TIME
#######################################

# Import data
 mydata <- read.csv("C:/Users/john/Google Drive/R Directory/projects/jeffs_viewability_dashboard/query_result.csv", stringsAsFactors = FALSE)

# Initialize currentVersion data table
dt <- data.table(mydata, key = 'campaign_label_id')
# change date to data format
library(lubridate)
dt$data_date<-mdy(dt$data_date)

currentVersion <- dt[, list(data_date=max(data_date)), 
                       by=c('campaign_label_id','line_item_label','flight_label','objective_impressions','vCPM')]
rm(dt)

# Initialize UI Selection Lists
uniqueCLIF <- 
  unique(
    data.frame(
      data$campaign_label_id,
      data$line_item_label,
      data$flight_label, 
      stringsAsFactors = FALSE)
    )
colnames(uniqueCLIF) <- c("campaign_label_id","line_item_label","flight_label")

uiCampaignLabelId <- unique(uniqueCLIF$campaign_label_id)

#######################################
# BEGIN 'EACH SESSION' SERVER
#######################################

# Define reactive input & output functionality
shinyServer(function(input, output, session) {
  
#######################################
# CLIF REACTIVE UIOUTPUT
#######################################

# First UI input
# uiCampaignLabelId generated from data set.  Static.

getCampaignLabelId <- reactive({
  if(is.null(input$uiCampaignLabelId))
    return(NULL)
  if(!is.null(input$uiCampaignLabelId))
    return(input$uiCampaignLabelId)
})

# Second UI input
# uiLineItemLabel generated based on uiCampaignLabelId.
getLineItemLabel <- reactive({
  dat <- getCampaignLabelId()
  if(is.null(dat))
    return(NULL)
  if(!is.null(input$uiCampaignLabelId))
    dat <- uniqueCLIF %>%
    filter(campaign_label_id == input$uiCampaignLabelId)
  return(dat)
})

# Third UI input
# uiFlightLabel generated based on LineItemId.
getFlightLabel <- reactive({
  dat <- getLineItemLabel()
  if(is.null(dat))
    return()
  if(!is.null(input$uiLineItemLabel))
    dat <- dat %>%
    filter(line_item_label == input$uiLineItemLabel)
  return(dat)
})

output$campaignControls <- renderUI({
  selectInput('uiCampaignLabelId',
                 label = NULL,
                 choices = uiCampaignLabelId,
                 multiple = FALSE,
                 selectize = TRUE)
})

output$lineItemControls <- renderUI({
  selectInput('uiLineItemLabel',
               label = NULL,
               choices = getLineItemLabel()$line_item_label,
               multiple = FALSE,
               selectize = TRUE)
})

output$flightControls <- renderUI({
  selectInput('uiFlightLabel',
                 label = NULL,
                 choices = getFlightLabel()$flight_label,
                 multiple = FALSE,
                 selectize = TRUE)
})

#######################################
# NUMERIC REACTIVE UIOUTPUT
#######################################

# TODO(jwenzinger): value of numeric input autoloads with reactive, only recomputes when flight changes.
# If campaign or line item change, then flight changes as well.

# Need objective_impression for max(day) for uniqueCLIF

getObjectiveImpressions <- reactive({
    #TODO(jwenzinger): error handling
    dat <- currentVersion %>%
           filter(campaign_label_id %in% input$uiCampaignLabelId) %>%
           filter(line_item_label   %in% input$uiLineItemLabel)   %>%
           filter(flight_label      %in% input$uiFlightLabel)     %>%
           select(objective_impressions)
    return(dat)
})

output$vImpControls <- renderUI({
  numericInput('objectiveImpressions',
               label = 'Viewable Impression Goal',
               value = getObjectiveImpressions(), 
               step = NA)
})

getVCPM <- reactive({
  #TODO(jwenzinger): error handling
  dat <- currentVersion %>%
    filter(campaign_label_id %in% input$uiCampaignLabelId) %>%
    filter(line_item_label   %in% input$uiLineItemLabel)   %>%
    filter(flight_label      %in% input$uiFlightLabel)     %>%
    select(vCPM)
  return(dat)
})

output$vCPMControls <- renderUI({
  numericInput('vCPM',
               label = 'vCPM ($)',
               value = getVCPM(), 
               step = NA)
})



#######################################
# CHART SERVER
#######################################
  
# filter and reshape data based on user inputs  
  # Create xts objects, 'wide' data for dygraph
  # xts uses rownames of dataframe
  # http://stackoverflow.com/questions/4297231/r-converting-a-data-frame-to-xts

  impData <- reactive({
    wideData <- data %>%
         filter(campaign_label_id %in% input$uiCampaignLabelId) %>%
         filter(line_item_label   %in% input$uiLineItemLabel)   %>%
         filter(flight_label      %in% input$uiFlightLabel)     %>%
         select(data_date, rfiImps, vImps, vPct)
    
    rownames(wideData) <- wideData$data_date      
    return(wideData)
    })

# create chart if minimum number of inputs are present
  # campaign_id and line_item_id
  # flight start date; flight end date?
  # vCPM and impressions?
  
  chart <- reactive({
       d <- dygraph(impData(), main = 'Viewable Impression Pacing') %>%
            dySeries('rfiImps', stepPlot = FALSE, fillGraph = TRUE) %>%
            dySeries('vImps', stepPlot = FALSE, fillGraph = TRUE) %>%
            dySeries('vPct', stepPlot = FALSE, axis = 'y2', strokeWidth = 2, strokePattern = 'dashed') %>%
            dyAxis("y", label = "Impression Delivery") %>%
            dyAxis("y2", label = "Viewability Rate (%)", valueRange = c(0, 1)) %>%
            dyOptions(labelsKMB = TRUE, fillAlpha = 0.15,  includeZero = TRUE) %>%
            dyRangeSelector(height = 20) %>%
            dyLegend(show = 'onmouseover') %>%
            dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.5)
    return(d)
  })

# TODO(jwenzinger): chart should only load data and aggregate for chosen date range

# modify chart if optional inputs are changed
  # pacing curve
  # ops check ins

# output chart
  output$chart_out <- renderDygraph({
    chart()
  })
  
  


#######################################
# DATA TABLE SERVER
#######################################

# Top Data Table should have the following attributes:
  # Flexible # of columns = number of Ops Check-ins + X static columns
    # Must construct the data frame based on User input
  # Flight revenue budget calculated based on user input of vCPM and Impressions



}) #shinyServer

#######################################

# Next version:
# need second data feed of flight attributes.
# campaign_id, line_item_id, flight_id, flight_start_date, flight_end_date
# ability to download table of data.  If this is running the query, then the user should be able to download if desired.
# real-time query of data
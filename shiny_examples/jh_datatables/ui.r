library(shiny)
library(ggplot2)  # for the diamonds dataset

shinyUI(fluidPage(
  title = 'Examples of DataTables',
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "diamonds"',
        checkboxGroupInput('show_vars', 'Columns in diamonds to show:',
                           names(diamonds), selected = names(diamonds))
      ),
      conditionalPanel(
        'input.dataset === "mtcars"',
        helpText('Click the column header to sort a column.')
      ),
      conditionalPanel(
        'input.dataset === "iris"',
        helpText('Display 5 records by default.')
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel('diamonds', dataTableOutput('mytable1')),
        tabPanel('mtcars', dataTableOutput('mytable2')),
        tabPanel('iris', dataTableOutput('mytable3'))
      )
    )
  )
))
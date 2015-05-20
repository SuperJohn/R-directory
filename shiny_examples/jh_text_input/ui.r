shinyUI(fluidPage(
  
  # Copy the line below to make a text input box
  textInput("text", label = h3("Enter Action IDs Here"), value = "20525217,20524903"),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
  
))
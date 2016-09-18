library(shiny)
shinyUI(fluidPage(
  titlePanel("File Input"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file","Upload a CSV file"), # fileinput() function is used to get the file upload contorl option
      tags$hr(),
      h5(helpText(h5("Select the read.table parameters below"))),
      checkboxInput(inputId = 'header', label = 'Header', value = T),
      checkboxInput(inputId = "stringAsFactors", "stringAsFactors", FALSE),
      br(),
      #date Range
      dateRangeInput("dates", label = h4("Date range")),
     uiOutput("xaxis"),
     uiOutput("yaxis"),
     uiOutput("zaxis")#,
    # hr(),
   #  verbatimTextOutput("value")
    ),
    mainPanel(
      plotOutput("graph"),
      plotOutput("graph1")
      )
    )
    
  )
)
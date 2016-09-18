library(shiny)

shinyServer(function(input,output){
  
  # This reactive function will take the inputs from UI.R and use them for read.table() to read the data from the file. 
  #It returns the dataset in the form of a dataframe.
  # file$datapath -> gives the path of the file
  data <- reactive({
    file1 <- input$file
    if(is.null(file1)){return()} 
    read.csv(file=file1$datapath, sep=',', header = input$header, stringsAsFactors = input$stringAsFactors)
  })
  
  #for select input Y-axis
  output$yaxis <- renderUI({
    selectInput("yvar", "Select Y Var - Graph Against Time", 
                choices=colnames(data())[-1],selected = (data())[2])
  })
  
  #for select input x-axis
  output$xaxis <- renderUI({
    selectInput("xvar", "Graph #1 Against Time", 
                choices=names(data())[1], selected = (data())[1])
  })
  
  #for select input z-axis
  output$zaxis <- renderUI({
    selectInput("zvar", "Graph #2 Against Module Temp / Any", 
                choices=names(data())[-1])
  })  
  
  output$value <- renderPrint({ input$dates })  
  
  # this reactive output contains the various details of the dataset 
  output$filedf <- renderTable({
    if(is.null(data())){return ()}
    input$file
  })

  
  # this reactive output contains the summary of the dataset and display the summary in table format
  output$sum <- renderTable({
    if(is.null(data())){return ()}
    summary(data())
  })
  
  # This reactive output contains the dataset and display the dataset in table format
  output$table <- renderTable({
    if(is.null(data())){return ()}
    data()
  })

  #To plot the dynamic graph against Time
  output$graph <- renderPlot({
    if(is.null(data()))
     {return ()}
    else
      plot(x = strptime(data()[,input$xvar],"%m/%d/%Y %H:%M"), 
           y= as.numeric(data()[,input$yvar]),ann=FALSE, col = "green",
           panel.first = grid(nx = 10, ny = 10))
    box()
    title(main= c(colnames(data()[input$xvar]), " VS ", colnames(data()[input$yvar])), col.main="red", font.main=4)
    title(xlab= colnames(data()[input$xvar]), col.lab=rgb(0,0.5,0))
    title(ylab= colnames(data()[input$yvar]), col.lab=rgb(0,0.5,0))
  })
  
  #To plot the dynamic graph against Module Temp / Any  
  output$graph1 <- renderPlot({
    if(is.null(data()))
    {return ()}
    else
      plot(x = as.numeric(data()[,input$zvar],"%m/%d/%Y %H:%M"), 
           y= as.numeric(data()[,input$yvar]),ann=FALSE, col = "blue",
           panel.first = grid(nx = 10, ny = 10))
    box()
    title(main= c(colnames(data()[input$zvar]), " VS ", colnames(data()[input$yvar])), col.main="red", font.main=4)
    title(xlab= colnames(data()[input$zvar]), col.lab=rgb(0,0.5,0))
    title(ylab= colnames(data()[input$yvar]), col.lab=rgb(0,0.5,0))
  })  
})
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
observeEvent(input$button,{
    #XIndex is a function which evaluate the x variable between the 3 columns in the data trees
    XIndex <- reactive({
        xvalue <- input$textX
        
        if(xvalue == "Girth"){
            xindex = 1
        } else{
            if(xvalue == "Height"){
                xindex = 2
            } else{xindex = 3}
        }
    })
    
    #YIndex is a function which evaluate the y variable between the 3 columns in the data trees
    YIndex <- reactive({
        yvalue <- input$textY
        if(yvalue == "Girth"){
            yindex = 1
        } else{
            if(yvalue == "Height"){
                yindex = 2
            } else{yindex = 3}
        }
    })
    
    #here the model is created.
    model <- reactive({
        #here i assign the texts inputs for more convenience in the code
        xvalue <- input$textX
        yvalue <- input$textY
        
        #here i call the functions to get the index in the data.
        xindex = XIndex()
        yindex = YIndex()
        
        #here the dataBrushed is created, which is a data with the points that are seleceted in the plot
         dataBrushed <- brushedPoints(trees, input$brush1, xvar = xvalue , yvar = yvalue)
         if(nrow(dataBrushed) < 2){
            return(NULL)
         }
         #the model is created
        lm(dataBrushed[,yindex] ~ dataBrushed[,xindex], dataBrushed)
    })
    #here the ouputs for slop and interception are collected and sent to the screen
    output$slopeOutput <- renderText({
        if(is.null(model())){
            "Model not found"
        } else{
            model()[[1]][2]
        }
    })
    output$intOutput <- renderText({
        if(is.null(model())){
            "Model not found"
        } else{
            model()[[1]][1]
        }
    })
    
    #here the plot is created
    output$plot1 <- renderPlot({
        xvalue <- input$textX
        yvalue <- input$textY
        
        xindex = XIndex()
        yindex = YIndex()
        
        #the plot is created with the index that we got from their functions
        plot(trees[,xindex], trees[,yindex], xlab = xvalue,
            ylab = yvalue, main = paste0("Comparision between ",xvalue," vs ",yvalue),
            cex = 1, pch = 19, col= "aquamarine")
        
        #here the line of the slope is drawn in the plot.
        if(!is.null(model())){
            abline(model(),col="darkviolet",lwd=2)
        }
    })

})    
})

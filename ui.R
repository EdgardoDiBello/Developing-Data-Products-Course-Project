
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Developing Data Producs Course Project"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            #Slope of the linear model calculated
            h3("Slope"),
            textOutput("slopeOutput"),
            #intercept of the linear model calculated
            h3("Intercept"),
            textOutput("intOutput"),
            hr(),
            #Text input for the x variable in the tree data
            textInput("textX",label = 'Type the X field for the plot, between "Girth", "Height", "Volume"', value="Type your text here..."),
            #Text input for the y variable in the tree data
            textInput("textY",label = 'Type the y field for the plot, between "Girth", "Height", "Volume"',value = "Type your text here..."),
            #action button, I decided to use the actionButton because that way the program has to wait for
            #the values to be entered in order to start doing the calculations and so on.
            actionButton("button","Apply changes!")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("plot1", brush = brushOpts(id="brush1"))
        )
    )
))

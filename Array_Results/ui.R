library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    titlePanel("Scatter Plot of Array Data"),
    
    sidebarLayout(
        sidebarPanel(
            
            helpText("Please type in an adjusted p-value of interest."),
            helpText("Transcripts with an adjusted p-value less than the specified ",
                     "value will be displayed in the dropdown box below."),
            
            #textInput("userP", "Adjusted p-value", "0.05"),
            textInput("userP", "Adjusted p-value", "0.6"),
            
            #actionButton("getP", "Select Transcripts"),
            
            helpText("Please select a transcript of interest to display"),
            uiOutput("choose_dataset"),
            
            br(),
            a(href = "https://github.com/NZGL", "NZGL GitHub")
        ),
        
        mainPanel(
            h3("Testing Scatter Plot of X vs Y"),
            h5("Please note that this may take a minute to load."),
            p(textOutput("transcriptID")),            
            p(textOutput("OGS")), 
            p(textOutput("EGenes")), 
            p(textOutput("Pvalue")), 
            p(textOutput("Adj.P")), 
            tableOutput("data_table"),
            plotOutput("scatterPlot"),
            plotOutput("boxPlot")
           
        ) #end mainPanel
    ) # end sidebarLayout
    
))
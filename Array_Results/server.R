library(shiny)

# load in results file
#arrayData.df <- read.table("data/array_result.txt", sep="\t", row.names=1, header=TRUE)
arrayData.df <- read.table("data/array_res2.txt", sep="\t", row.names=1, header=TRUE)
transcriptsFull <- rownames(arrayData.df)
#data_sets <- head(arrayData.df)


# Define server logic required to draw a histogram
#data_sets <- c("mtcars", "morley", "rock")

    shinyServer(function(input, output) {
        

        # Drop-down selection box for which data set
        output$choose_dataset <- renderUI({
            input$getP
            
            #    selectInput("dataset", "Data set", as.list(transcripts), selected=1)
            #isolate({
                indexTranscripts <- which(arrayData.df$adj.P.Val <= input$userP)
                #cat(indexTranscripts)
                #transcriptsOfInterest <- rownames(arrayData.df)[indexTranscripts]
                transcriptsOfInterest <- transcriptsFull[indexTranscripts]
            #    cat(transcriptsOfInterest)
             #   transcriptsOfInterest <- rownames(arrayData.df)[1]
                
                
                #selectInput("dataset", "Data set", as.list(transcriptsOfInterest), selected="11715112_at")
            selectInput("dataset", "Data set", as.list(transcriptsOfInterest), selected=1)
                #selectInput("dataset", "Data set", as.list(transcriptsOfInterest))
            #})
            
        }) # end output$choose_dataset
        
        # get row containing all info on transcript
        transcriptData <- reactive({
            # Get the transcript info
            tt <- input$dataset
            
            # If missing input, return to avoid error later in function
            if(is.null(tt))
                return()
            
            cat(tt, " ")        
            # select the row with the affyID
            #tData <- arrayData.df[grep(tt, transcripts),]
            if(tt == ""){
                return()
            } else {
                tData <- arrayData.df[grep(tt, transcriptsFull),]    
            }
            
        })
        # get basic info on transcripts
        transcriptOverview <- reactive({
            # Get the transcript overview
            
            overviewData <- transcriptData()[,c(1:3, 19:24)]
        })
        # get transcript expression values
        transcriptValues <- reactive({
            # Get the transcript overview
            
            transcriptV <- transcriptData()[,c(4:15)]
        })
        
        # ------ print transcript overview data -------
        output$transcriptID <- renderText({ 
            tOverview <- transcriptOverview()
            paste("You have selected transcript:\t", rownames(tOverview))            
        })
        output$OGS <- renderText({ 
            tOverview <- transcriptOverview()
            paste("Official gene symbol:\t", tOverview$HGNC)            
        })
        output$EGenes <- renderText({ 
            tOverview <- transcriptOverview()
            paste("Official gene symbol:\t", tOverview$Ensembl.Gene)            
        })
        output$Pvalue <- renderText({ 
            tOverview <- transcriptOverview()
            paste("P-value:\t", tOverview$P.Value)            
        })
        output$Adj.P <- renderText({ 
            tOverview <- transcriptOverview()
            paste("Adjusted p-value:\t", tOverview$adj.P.Val)            
        })
        
        
        # ------ end transcript overview printing --------
        
        
        # --- output the data ---
        
        # Output the data
        output$data_table <- renderTable({
            dat <- transcriptValues()
            
        }) # end output$data_table
        
        
        # get treatment values
        trt1.data <- reactive({
            data <- transcriptValues()
            trt1 <- data[,c(1, 5, 9)]
        })
        trt2.data <- reactive({
            data <- transcriptValues()
            trt2 <- data[,c(2, 6, 10)]
        })
        trt3.data <- reactive({
            data <- transcriptValues()
            trt3 <- data[,c(3, 7, 11)]
        })
        trt4.data <- reactive({
            data <- transcriptValues()
            trt4 <- data[,c(4, 8, 12)]
        })
        
        # Output scatterplot of data
        output$scatterPlot <- renderPlot({
            data <- transcriptValues()
            if(is.null(data))
                return()
            
            
            #par(mar=c(6,4,8,3))
            plotTitle = paste("Control siRNA + Vehicle - RAD21 siRNA + Vehicle")
            
            trtLabels = c("Ctl.siRNA.E", "Ctl.siRNA.V", "RAD21.siRNA.E", "RAD21.siRNA.V")
            
            dataRange = range(data, na.rm=TRUE)
            ymax = (dataRange[2] + 1)
            ymin = max((dataRange[1]-1), 0)
            #ymax=7
            
            cat("ymax, ", ymax)
            trt1 <- trt1.data()
            trt1.x <- rep(1, 3)
            trt2 <- trt2.data()
            trt2.x <- rep(2, 3)
            trt3 <- trt3.data()
            trt3.x <- rep(3, 3)
            trt4 <- trt4.data()
            trt4.x <- rep(4, 3)
            #browser()
            
            plot(x=trt1.x, y=trt1, xaxt="n", xlim=c(0,5), ylim=c(ymin, ymax), col="red", 
                 xlab="", ylab="", xaxt="n", yaxt="n", pch=3, cex=1.5); par(new=TRUE)
            plot(x=trt2.x, y=trt2, xlim=c(0,5), ylim=c(ymin, ymax), xaxt="n", col="blue", 
                 xlab="", ylab="", xaxt="n", yaxt="n", pch=3, cex=1.5);par(new=TRUE)
            plot(x=trt3.x, y=trt3, xaxt="n", xlim=c(0,5), ylim=c(ymin, ymax), col="green", 
                 xlab="", ylab="", xaxt="n", yaxt="n", pch=3, cex=1.5); par(new=TRUE)
            plot(x=trt4.x, y=trt4, xaxt="n", xlim=c(0,5), ylim=c(ymin, ymax), pch=3, cex=1.5, col="orange", 
                 xlab="Treatments", ylab="Intensity", main=plotTitle)
            axis(side=1, at=c(1:4), labels=trtLabels)
        })
        
        output$boxPlot <- renderPlot({
            trt1.data <- trt1.data()
            trt2.data <- trt2.data()
            trt3.data <- trt3.data()
            trt4.data <- trt4.data()
            
            if(is.null(trt1.data))
                return()
            #trt1 <- rbind("Trt1", trt1.data)
            #trt2 <- rbind("Trt2", trt2.data)
            #trt3 <- rbind("Trt3", trt3.data)
            #trt4 <- rbind("Trt4", trt4.data)
            #trt1 <- rbind("Trt1", trt1.data())
            #trt2 <- rbind("Trt2", trt2.data())
            #trt3 <- rbind("Trt3", trt3.data())
            #trt4 <- rbind("Trt4", trt4.data())
            #browser()
            
            #values <- c(trt1,trt2,trt3,trt4)
            values <- unlist(c(trt1.data,trt2.data,trt3.data,trt4.data))
    
            trts <- c(rep("Ctl.siRNA.E",3), rep("Ctl.siRNA.V",3), rep("RAD21.siRNA.E",3), rep("RAD21.siRNA.V",3))
            #data <- data.frame(rbind(trts, as.double(values)))
            #browser()
            data <- data.frame(trts, values)
            #data$values <- as.numeric(data$values)
            boxplot(values~trts, data=data)
        })

})
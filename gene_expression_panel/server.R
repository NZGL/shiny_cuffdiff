# source("https://bioconductor.org/biocLite.R")
# biocLite("cummeRbund")
# install.packages("shiny")
library(shiny)
library(cummeRbund)


shinyServer(function(input, output) {
# This section defines a CuffGeneSet for a specific gene which is used in the subsequent display steps
# This is to avoid re-loading the CuffGeneSet many times
  
  my_gene <- reactive({
    mycufflinksdata <- readCufflinks(dir =  input$cuffdiff_dir,
                                     genome = input$cuffdiff_genome, 
                                     gtfFile = input$cuffdiff_gtf,
                                     rebuild = input$rebuild)
    getGenes(mycufflinksdata,geneIdList = input$gene_id, sampleIdList = input$sns)
    })
  
# Now the CuffGeneSet is defined

# The first text box displays some text-based information about the CuffGeneSet
  
# Display the gene short name

   output$gsn <- renderText({
      if (input$gene_id != "") {
          paste("Gene short name: ", as.character(featureNames(my_gene())$gene_short_name))
      }
    })

# Display the XLOC_XXXXXX tracking ID
   
   output$id <- renderText({
     if (input$gene_id != "") {
       paste("Tracking ID : ", as.character(featureNames(my_gene())$tracking_id))
     }
   })
   
# Display the number of isoforms
   
   output$iso <- renderText({
     if (input$gene_id != "") {
       paste("Number of isoforms : ", as.character(length(isoforms(my_gene()))))
     }
   })
   
   
# Display the number of TSS groups   
   
   output$tss <- renderText({
     if (input$gene_id != "") {
       paste("Number of transcription start sites : ", as.character(length(TSS(my_gene()))))
     }
   })

# Display the number of cDNAs
   
   output$cds <- renderText({
     if (input$gene_id != "") {
       paste("Number of cDNAs: ", as.character(length(CDS(my_gene()))))
     }
   })
   
#     output$sample_names <- renderTable({
#       if (input$gene_id != "") {
#         as.data.frame(samples(my_gene()))
#       }
#     })
   
   output$sample_name_selector <- renderUI({
     if (input$gene_id != "") {
       sample_names_for_checkbox<-as.character(samples(my_gene()))
       checkboxGroupInput("sns","Restrict plot to these conditions (uncheck all to reset)", sample_names_for_checkbox)
       }
     }) 
   
# Display tabbed outputs at the bottom of the page
   
   output$rawplotdatagene <- renderTable({
     if (input$gene_id != "") {
       as.data.frame(fpkm(my_gene()))
     }
   })
   
   output$rawplotdataiso <- renderTable({
     if (input$gene_id != "") {
       as.data.frame(fpkm(isoforms(my_gene())))
     }
   })
   
   output$isoforminfo <- renderTable({
     if (input$gene_id != "") {
       as.data.frame(annotation(isoforms(my_gene())))
     }
   })
  
# The main panel displays tabbed expression plot of the gene and isoforms
  output$expression_plot_primary_isoform <- renderPlot({
    if (input$gene_id != "") {
      if (input$plottype == 1) {
        expressionPlot(my_gene(), replicates = input$reps)
      }
      else if (input$plottype == 2) {
        expressionBarplot(my_gene(), replicates = input$reps)
      }
    }
    })
  
  output$expression_plot_all_isoforms <- renderPlot({
    if (input$gene_id != "") {
      if (input$plottype == 1){
      expressionPlot(isoforms(my_gene()), replicates = input$reps)
      }
      else if (input$plottype == 2){
      expressionBarplot(isoforms(my_gene()), replicates = input$reps)
      }
    }
  })
  
  output$expression_plot_all_TSS <- renderPlot({
    if (input$gene_id != "") {
      if (input$plottype == 1){
        expressionPlot(TSS(my_gene()), replicates = input$reps)
      }
      else if (input$plottype == 2){
        expressionBarplot(TSS(my_gene()), replicates = input$reps)
      }
    }
  })
  
  output$expression_plot_all_CDS <- renderPlot({
    if (input$gene_id != "") {
      if (input$plottype == 1){
        expressionPlot(CDS(my_gene()), replicates = input$reps)
      }
      else if (input$plottype == 2){
        expressionBarplot(CDS(my_gene()), replicates = input$reps)
      }
    }
  })
  
})

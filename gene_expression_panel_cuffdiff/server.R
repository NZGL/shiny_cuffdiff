source("load_packages.R")

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

# Display the number of cDNAs (Clumsy error handling here, as many cuffdiff databases will not have this information)
   
   output$cds <- renderText({
     if (input$gene_id != "") {
       paste("Number of cDNAs: ", as.character(length(CDS(my_gene()))))
     }
   })
   
   # Obtain the sample names from the cuffdiff database, and use them in a dynamic UI element
   # This allows the plots to be restricted by sample and re-plotted
   
   output$sample_name_selector <- renderUI({
     if (input$gene_id != "") {
       sample_names_for_checkbox<-as.character(samples(my_gene()))
       checkboxGroupInput("sns","Restrict plot to these conditions (uncheck all to reset)", sample_names_for_checkbox)
       }
     }) 
   
# Display tabbed outputs at the bottom of the page

   # Data frame of FPKM values
   
   output$rawplotdatagene <- renderTable({
     if (input$gene_id != "") {
       as.data.frame(fpkm(my_gene()))
     }
   })
   # Data frame of FPKM values by isoform
   output$rawplotdataiso <- renderTable({
     if (input$gene_id != "") {
       as.data.frame(fpkm(isoforms(my_gene())))
     }
   })
   # Names of isoforms
   output$isoforminfo <- renderTable({
     if (input$gene_id != "") {
       as.data.frame(annotation(isoforms(my_gene())))
     }
   })
   # Expression plot of the primary isoform only
   
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
  # Expression plot of all isoforms
  
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
  # Expression plot of all TSS groups
  
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
  # Expression plot of all CDS groups: again, this will often fail since this information is often not in cuffdiff databases
  
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

### This file is part of shiny_cuffdiff.

### shiny_cuffdiff is free software: you can redistribute it and/or modify
### it under the terms of the GNU General Public License as published by
### the Free Software Foundation, either version 3 of the License, or
### (at your option) any later version.

### shiny_cuffdiff is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
### GNU General Public License for more details.

### You should have received a copy of the GNU General Public License
### along with shiny_cuffdiff.  If not, see <http://www.gnu.org/licenses/>.

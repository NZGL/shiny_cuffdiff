source("load_packages.R")

shinyServer(function(input, output) {
# This section defines a CuffGeneSet for a specific gene which is used in the subsequent display steps
# This is to avoid re-loading the CuffGeneSet many times
  
  my_genes <- reactive({
    mycufflinksdata <- readCufflinks(dir =  input$cuffdiff_dir,
                                     genome = input$cuffdiff_genome, 
                                     gtfFile = input$cuffdiff_gtf,
                                     rebuild = input$rebuild)
    mylist<-unlist(strsplit(input$gene_list, " "))
    getGenes(mycufflinksdata,geneIdList=mylist, sampleIdList = input$sns)
    })
  
# Now the CuffGeneSet is defined

# The first text box displays some text-based information about the CuffGeneSet
  
# Display the gene short name

   output$gsn <- renderText({
      if (input$gene_list != "") {
          paste("Gene short name: ", as.character(featureNames(my_genes())$gene_short_name))
      }
    })

# Display the XLOC_XXXXXX tracking ID
   
   output$id <- renderText({
     if (input$gene_list != "") {
       paste("Tracking ID : ", as.character(featureNames(my_genes())$tracking_id))
     }
   })
   
   output$sample_name_selector <- renderUI({
     if (input$gene_list != "") {
       number_of_samples<-length(samples(my_genes()))/length(unlist(strsplit(input$gene_list, " ")))
       sample_names_for_checkbox<-as.character(samples(my_genes())[1:number_of_samples])
       checkboxGroupInput("sns","Restrict plot to these conditions (uncheck all to reset)", sample_names_for_checkbox)
     }
   }) 
#     ()
  
# The main panel displays tabbed expression plot of the gene and isoforms
   
   # Display heatmap
  output$heatmap <- renderPlot({
    if (input$gene_list != "") {
        csHeatmap(my_genes(), replicates = input$reps)
    }
    })
  # Display barplot
  output$barplot <- renderPlot({
    if (input$gene_list != "") {
      expressionBarplot(my_genes(), replicates = input$reps)
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
source("load_packages.R")

shinyServer(function(input, output) {
# This section defines a CuffSet which is used in the subsequent display steps
  
#  mycufflinksdata <- 
  my_CuffSet <- reactive({readCufflinks(dir =  input$cuffdiff_dir,
                                     genome = input$cuffdiff_genome, 
                                     gtfFile = input$cuffdiff_gtf,
                                     rebuild = input$rebuild)
    })
  
# Now the CuffSet is defined

# Create density plot
  output$dens <- renderPlot({
    if (input$iso == FALSE) {
      csDensity(genes(my_CuffSet()), replicates = input$reps)
    }
    else if (input$iso == TRUE) {
      csDensity(isoforms(my_CuffSet()), replicates = input$reps)
      }
  })
  
# Create SCV plot
  output$scv <- renderPlot({
    if (input$iso == FALSE) {
      fpkmSCVPlot(genes(my_CuffSet()))
    }
    else if (input$iso == TRUE) {
      fpkmSCVPlot(isoforms(my_CuffSet()))
    }
  })
  
  # Create Dispersion plot
  output$disp <- renderPlot({
    if (input$iso == FALSE) {
      dispersionPlot(genes(my_CuffSet()))
    }
    else if (input$iso == TRUE) {
      dispersionPlot(isoforms(my_CuffSet()))
    }
  })
  
  # Create significance matrix
  output$sigmat <- renderPlot({
    if (input$iso == FALSE) {
      sigMatrix(my_CuffSet(), level="genes", alpha=0.05)
    }
    else if (input$iso == TRUE) {
      sigMatrix(my_CuffSet(), level="isoforms", alpha=0.05)
    }
  })
  
  # Create MDS plot
  output$mds <- renderPlot({
    if (input$iso == FALSE) {
      MDSplot(genes(my_CuffSet()), replicates=input$reps)
    }
    else if (input$iso == TRUE) {
      MDSplot(isoforms(my_CuffSet()), replicates=input$reps)
    }
  })
  
  # Create PCA plot
  output$pca <- renderPlot({
    if (input$iso == FALSE) {
      PCAplot(genes(my_CuffSet()), "PC1", "PC2", replicates = input$reps)
    }
    else if (input$iso == TRUE) {
      PCAplot(isoforms(my_CuffSet()), "PC1", "PC2", replicates = input$reps)
    }
  })

})

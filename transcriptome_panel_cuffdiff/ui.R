#!/bin/R

shinyUI(fluidPage(
  titlePanel("Transcriptome Assessment"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("cuffdiff_dir", label = "Full path to your Cuffdiff directory", value = "~/Dropbox/384/cuffdiff"),
      checkboxInput("rebuild", label = "Rebuild cuffdiff database (very slow) ?", value = FALSE),
      conditionalPanel(
        condition = "input.rebuild == true",
        textInput("cuffdiff_gtf", label = "Full path to your GTF file (optional, but recommended)"),
        textInput("cuffdiff_genome", label = "Genome name (Optional, free text)")
      ),
      checkboxInput("reps", label="Include replicates ? (Not relevant for some plots)", value = FALSE),
      checkboxInput("iso", label="Include isoforms ? (Not relevant for some plots)", value = FALSE)
    ),
  
  mainPanel(position = "right",
    tabsetPanel(
      tabPanel("Density",plotOutput("dens")),
      tabPanel("Scaled Coefficient of Variation", plotOutput("scv")),
      tabPanel("Dispersion (slow to plot!)", plotOutput("disp")),
      tabPanel("Significance Matrix", plotOutput("sigmat")),
      tabPanel("Multi-dimensional Scaling", plotOutput("mds")),
      tabPanel("Principal Component", plotOutput("pca"))
    )
))))

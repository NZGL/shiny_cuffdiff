#!/bin/R

shinyUI(fluidPage(
  titlePanel("Gene expression plot"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("cuffdiff_dir", label = "Full path to your Cuffdiff directory"),
      checkboxInput("rebuild", label = "Rebuild cuffdiff database (very slow)", value = FALSE),
      conditionalPanel(
        condition = "input.rebuild == true",
        textInput("cuffdiff_gtf", label = "Full path to your GTF file (optional, but recommended)"),
        textInput("cuffdiff_genome", label = "Genome name (Optional, free text)")
      ),
      textInput("gene_id", label = "Gene short name or XLOC number", value = ""),
      radioButtons("plottype", label="Plot type", choices = list("Line" = 1, "Bar" = 2),
                   selected = 1),
      checkboxInput("reps", label="Include replicates ?", value = FALSE)
      ),
 
 
    sidebarPanel(strong("Gene information"),
                          textOutput("gsn"), 
                          textOutput("id"),
                          textOutput("iso"),
                          textOutput("tss"),
                          textOutput("cds"))
  ),
  
  mainPanel(position = "right",
    tabsetPanel(
      tabPanel("Primary isoform",plotOutput("expression_plot_primary_isoform")),
      tabPanel("All isoforms", plotOutput("expression_plot_all_isoforms")),
      tabPanel("TSS groups",plotOutput("expression_plot_all_TSS")),
      tabPanel("CDS groups", plotOutput("expression_plot_all_CDS")),
      tabPanel("Raw plot data (Gene)", tableOutput("rawplotdatagene")),
      tabPanel("Raw plot data (Isoforms)", tableOutput("rawplotdataiso")),
      tabPanel("Isoform information", tableOutput("isoforminfo"))
    )
)))

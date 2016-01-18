#!/bin/R

shinyUI(fluidPage(
  titlePanel("Multi-gene comparison plots"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("cuffdiff_dir", label = "Full path to your Cuffdiff directory", value = "~/Dropbox/384/cuffdiff"),
      checkboxInput("rebuild", label
                    = "Rebuild cuffdiff database (very slow)", value = FALSE),
      conditionalPanel(
        condition = "input.rebuild == true",
        textInput("cuffdiff_gtf", label = "Full path to your GTF file (optional, but recommended)"),
        textInput("cuffdiff_genome", label = "Genome name (Optional, free text)")
      ),
      radioButtons("inputtype", "Input type:",
                   c("List" = "list",
                     "File" = "file")),
      conditionalPanel(
        condition = "input.inputtype == 'list'",
        textInput("gene_list", label = "Gene list", value = "HBB ACTB")
      ),
      conditionalPanel(
        condition = "input.inputtype == 'file'",
        fileInput("gene_list_file", label = "Gene list file")
      ),
      checkboxInput("reps", label="Include replicates ?", value = FALSE)
      ),
    sidebarPanel(strong("Gene information"),
                          textOutput("gsn"), 
                          textOutput("id"),
                          uiOutput("sample_name_selector"))
  ),
  
  mainPanel(position = "right",
    tabsetPanel(
      tabPanel("Heatmap",plotOutput("heatmap")),
      tabPanel("Barplot", plotOutput("barplot"))
    )
)))

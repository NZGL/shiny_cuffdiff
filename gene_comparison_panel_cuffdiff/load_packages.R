#The following code will download, install and load all the required packages for the R script. Place R packages in the list of R
# packages, and bioconductor packages in the list of biocondictor packages.

source("https://bioconductor.org/biocLite.R")

list_of_R_packages <- c("shiny")
list_of_bioconductor_packages <- c("cummeRbund")

new_R_packages <- list_of_R_packages[!(list_of_R_packages %in% installed.packages()[,"Package"])]
if(length(new_R_packages)) install.packages(new_R_packages)

new_bioconductor_packages <- list_of_bioconductor_packages[!(list_of_bioconductor_packages %in% installed.packages()[,"Package"])]
if(length(new_bioconductor_packages)) biocLite(new_bioconductor_packages)

invisible(lapply(c(list_of_bioconductor_packages, list_of_R_packages), library, character.only = TRUE))
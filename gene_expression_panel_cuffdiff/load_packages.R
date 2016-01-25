#The following code will download, install and load all the required packages for the R script. Place R packages in the list of R
# packages, and bioconductor packages in the list of biocondictor packages.

source("http://bioconductor.org/biocLite.R")

list_of_R_packages <- c("shiny")
list_of_bioconductor_packages <- c("cummeRbund")

new_R_packages <- list_of_R_packages[!(list_of_R_packages %in% installed.packages()[,"Package"])]
if(length(new_R_packages)) install.packages(new_R_packages)

new_bioconductor_packages <- list_of_bioconductor_packages[!(list_of_bioconductor_packages %in% installed.packages()[,"Package"])]
if(length(new_bioconductor_packages)) biocLite(new_bioconductor_packages)

invisible(lapply(c(list_of_bioconductor_packages, list_of_R_packages), library, character.only = TRUE))

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

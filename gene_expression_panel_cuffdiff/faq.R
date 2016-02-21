# FAQ page
# text to go in the FAQ tabsetpanel
faqOutput <- function(){
    paste("<h4>Frequently Asked Questions</h4><br/><br/>
        <b>Disclaimer</b>
        <p>
            shiny_cuffdiff is free software: you can redistribute it and/or modify
            it under the terms of the GNU General Public License as published by
            the Free Software Foundation, either version 3 of the License, or
            (at your option) any later version.
          
            shiny_cuffdiff is distributed in the hope that it will be useful,
            but WITHOUT ANY WARRANTY; without even the implied warranty of
            MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
            GNU General Public License for more details.
          
            You should have received a copy of the GNU General Public License
            along with shiny_cuffdiff.  If not, see 
            <a href=\"http://www.gnu.org/licenses/\">http://www.gnu.org/licenses/</a>.
          
        </p>
          
        <b>Contact Us</b>
        <p>
            Please contact
            <a href=\"mailto:dan.jones@auckland.ac.nz\">Dr Dan Jones</a>.</p>
        
        <b>Citation</b>
        <p>
            Jones, D., Stuckey, A., and Fan, V. (2016). shiny_cuffdiff (version 0.1): 
            On-the-fly interrogation and plotting of gene expression results. 
            <a href=\"http://nzgl.github.io/shiny_cuffdiff/\">http://nzgl.github.io/shiny_cuffdiff/</a>
        </p>
        <p>
            Remember to also cite the underlying R code (cummeRbund) and the Tuxedo workflow.
        </p>
        <b>Running shiny_cuffdiff For the First Time</b>
        <p>
            If the required packages for are not already installed, shiny_cuffdiff 
            will attempt to install the required packages. While this occurs, you 
            will see a blank user interface, and text printed to the R console. 
            You may be prompted in the console to update some pre-existing packages 
            during the install.
        </p>
        <br/>
        <br/>
        
          ")      
} # end faqOutput




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
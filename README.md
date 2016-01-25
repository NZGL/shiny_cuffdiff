# shiny_cuffdiff

Welcome to the shiny_cuffdiff project.

This project is at an early phase of development, but is under active development. We are also developing Shiny code to interrogate the outputs of other common gene expression / differential expression workflows (intially starting with DESeq2), which will be published as a separate repository.

Participants (either users, testers, or code developers) are encouraged!

Put simply, this code uses the outputs of the Tuxedo workflow (Tophat2 > Cufflinks > Cuffdiff) which is a cuffdiff SQL database file called cuffdiff.db. Then, using the R package cummeRbund, various plots are created on-the fly. 

There are three subdirectories, containing the server.R and ui.R files required for all Shiny apps, and a load_packages.R file to handle loading dependencies.

<b>gene_expression_panel_cuffdiff:</b>

Takes a cuffdiff database (rebuilding if required) and displays information on a single named gene (as defined by the gene short name or the XLOC number). After the gene information is defined, gene expression plots can be restricted by sample.

<b>To use</b>: Open the server.R or ui.R file within RStudio. Click on the "Run App" button, or run from the R console:

<code>shiny::runApp('shiny_cuffdiff/gene_expression_panel_cuffdiff'))</code>

Type the path to the cuffdiff directory \n
Type the gene short name or XLOC number \n
Press "Plot"

<b>gene_comparison_panel_cuffdiff:</b>

Takes a cuffdiff database (rebuilding if required) and displays information on a set of named genes (as defined by the gene short name or the XLOC number). Displays a heatmap and a barplot. After the gene information is defined, gene expression plots can be restricted by sample.

<b>To use</b>: Open the server.R or ui.R file within RStudio. Click on the "Run App" button, or run from the R console:

<code>shiny::runApp('shiny_cuffdiff/gene_comparison_panel_cuffdiff'))</code>

Type the path to the cuffdiff directory \n
Type the gene short names or XLOC numbers \n
Press "Plot"

<b>Users:</b>Please note that, while this code is usable and may already be helpful when interrogating your gene expression results, it is a project at an early stage of development and there is a lot of error handling and code optimisation to be done.

<b>Contributors:</b> Welcome. We intend to use the Git branching model described in this post for development of this code.

http://nvie.com/posts/a-successful-git-branching-model/

Please take the time to read the current issues list, and feel free to create new issues or suggestions for improvements.

<b>Requirements (tested on these versions)</b>

R version 3.2.2 (2015-08-14) -- "Fire Safety" \n
RStudio /n
Shiny (this is installed during the startup process) \n
cummeRbund (this is installed during the startup process) \n
A valid cuffdiff directory (the cuffdiff.db can be rebuilt, but this is a very, very slow process, so this option is turned off by default)
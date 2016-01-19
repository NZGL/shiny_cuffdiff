# shiny_cuffdiff

<b>gene_expression_panel:</b>

Takes a cuffdiff database (rebuilding if required) and displays information on a single named gene (as defined by the gene short name or the XLOC number). After the gene information is defined, gene expression plots can be restricted by sample.

<b>gene_comparison_panel:</b>

Takes a cuffdiff database (rebuilding if required) and displays information on a set of named genes (as defined by the gene short name or the XLOC number). Displays a heatmap and a barplot. After the gene information is defined, gene expression plots can be restricted by sample.

<b>transcriptome_panel:</b>

Takes a cuffdiff database (rebuilding if required) and displays transcriptome-level plots (Density, dispersion, SCV, MDS and PCA plots)

<b> Array Results: </b>

Uses a csv file containing the limma toptable results and normalised array values to produce plots on a specified transcript.

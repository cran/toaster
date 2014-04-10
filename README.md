# toaster

toaster (to Aster) is set of tools for computing and analyzing data with [Teradata Aster](http://www.asterdata.com/) Big Data database. It brings power of Aster database with its distributed SQL and map-reduce functions to R on desktop and let analyze results with convinient set of visualizations based on ggplot2.

toaster acheives most tasks in 2 distinct steps:

* Compute in Aster using rich set of analyical functions and SQL transparently running in distributed and parallel environement.

* Deliver and visualize results in R for further exploration and analysis.
 
Thus toaster performs all data heavy computations in Aster with results available in R. Summary statistics, aggregates, histograms, heatmaps, linear regression models are among results available from Aster. Most of the results have toaster visualization functions for further analysis.

You can install:

* the latest released version from CRAN with

    ```R
    install.packages("toaster")
    ````


* the latest development version from bitbucket with

    ```R
    devtools::install_bitbucket("toaster", "grigory")
    ````


If you encounter a clear bug, please file a minimal reproducible example on [bitbucket](https://bitbucket.org/grigory/toaster/issues).

Attribution:

* Icon: [Toaster Icon by Greg Barnes](http://www.iconarchive.com/show/vintage-kitchen-icons-by-greg-barnes/Toaster-icon.html), [Vintage Kitchen](http://www.iconarchive.com/show/vintage-kitchen-icons-by-greg-barnes.html)
* Icon: [Toaster by Luiza Peixe from The Noun Project](http://thenounproject.com/term/toaster/10764/)

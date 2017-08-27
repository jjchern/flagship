
<!-- README.md is generated from README.Rmd. Please edit that file -->
About `flagship`
================

[![Travis-CI Build Status](https://travis-ci.org/jjchern/flagship.svg?branch=master)](https://travis-ci.org/jjchern/flagship) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/jjchern/flagship?branch=master&svg=true)](https://ci.appveyor.com/project/jjchern/flagship)

-   Tuition and fees data from the College Broad for state flagship universities, 2007-2016.
-   Source: <https://trends.collegeboard.org/college-pricing>

Installation
============

``` r
# install.packages("devtools")
devtools::install_github("jjchern/flagship")
```

Usage
=====

``` r
# Load tibble for nice display
library(tibble)
flagship::flagship
#> # A tibble: 500 x 8
#>                              univ state school_year instatetf_2016_dollars
#>                             <chr> <chr>       <chr>                  <dbl>
#>  1 University of Alaska Fairbanks    AK     2007-08               5194.211
#>  2 University of Alaska Fairbanks    AK     2008-09               5281.972
#>  3 University of Alaska Fairbanks    AK     2009-10               5735.943
#>  4 University of Alaska Fairbanks    AK     2010-11               5867.958
#>  5 University of Alaska Fairbanks    AK     2011-12               5933.038
#>  6 University of Alaska Fairbanks    AK     2012-13               6195.160
#>  7 University of Alaska Fairbanks    AK     2013-14               6168.745
#>  8 University of Alaska Fairbanks    AK     2014-15               6244.196
#>  9 University of Alaska Fairbanks    AK     2015-16               6860.820
#> 10 University of Alaska Fairbanks    AK     2016-17               7184.000
#> # ... with 490 more rows, and 4 more variables:
#> #   instatetf_current_dollars <dbl>, outstatetf_2016_dollars <dbl>,
#> #   outstatetf_current_dollars <dbl>, enrollment <dbl>
```

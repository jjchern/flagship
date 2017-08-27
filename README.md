
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
devtools::install_github("jjchern/flagship@v1.0.0")
```

Usage
=====

``` r
# Load tibble for nice display
library(tibble)
flagship::flagship
#> # A tibble: 500 x 11
#>                     univ unitid    opeid opeid6 state school_year
#>                    <chr>  <chr>    <chr>  <chr> <chr>       <chr>
#>  1 University of Alabama 100751 00105100 001051    AL     2007-08
#>  2 University of Alabama 100751 00105100 001051    AL     2008-09
#>  3 University of Alabama 100751 00105100 001051    AL     2009-10
#>  4 University of Alabama 100751 00105100 001051    AL     2010-11
#>  5 University of Alabama 100751 00105100 001051    AL     2011-12
#>  6 University of Alabama 100751 00105100 001051    AL     2012-13
#>  7 University of Alabama 100751 00105100 001051    AL     2013-14
#>  8 University of Alabama 100751 00105100 001051    AL     2014-15
#>  9 University of Alabama 100751 00105100 001051    AL     2015-16
#> 10 University of Alabama 100751 00105100 001051    AL     2016-17
#> # ... with 490 more rows, and 5 more variables:
#> #   instatetf_2016_dollars <dbl>, instatetf_current_dollars <dbl>,
#> #   outstatetf_2016_dollars <dbl>, outstatetf_current_dollars <dbl>,
#> #   enrollment <dbl>
```

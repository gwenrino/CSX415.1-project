Introduction
============

On behalf of the Departamento de Salud de Puerto Rico, we are able to offer a tool for forecasting the weekly number of cases of dengue disease with enough accuracy to substantially improve efficiency in staffing the San Juan public health clinic.

How to install the forecasting tool
===================================

You can install the forecasting tool directly from Github using the following R code:

``` r
install.packages("devtools") # if needed
library(devtools)
devtools::install_github("gwenrino/CSX415.1-project/dengue/pkgs/Dengue")
library(Dengue)
```

How to use the forecasting tool
===============================

Once installed, you can call the forecasting tool with the function `Dengue::DengueFC()`.

The function only takes one parameter, `h`, which is the forecast horizon (i.e. the number of weeks forward you wish to forecast). `h` must be a whole number greater than zero. Keep in mind that the forecasts are less dependable at longer horizons. This forecasting tool is able to offer predictions of weekly cases of dengue for relatively short time horizons (1-6 weeks) that are, on average, good enough to substantially improve staffing efficiency.

The function returns a table with six pieces of information about each of the forecasted weeks.  
* `Forecast` is the number of dengue cases expected that week as forecast by the model.  
* `Lo95` and `Hi95` show the range of the 95% confidence interval of dengue forecasts for that week. In other words, we can say with 95% certainty that the true number of dengue cases for the given week will lie between the `Lo95` and `Hi95` numbers.  
* `StaffRec` is the number of health care workers needed to maintain the required 1:9 staffing ratio for the forecasted number of dengue cases that week.  
* `StaffLo` and `StaffHi` show the range of number of health care workers suggested by the 95% confidence interval of the dengue forecasts.  

**Example**

``` r
Dengue::DengueFC(5)
```

    ##     Week Lo95 Forecast Hi95 StaffLo StaffRec StaffHi
    ## 1 Week 1    0        6   32       1        1       4
    ## 2 Week 2    0        6   46       1        1       6
    ## 3 Week 3    0        7   57       1        1       7
    ## 4 Week 4    0        6   67       1        1       8
    ## 5 Week 5    0        7   76       1        1       9

How to access the source code
=============================

If you are interested in rebuilding this project from the source code, you can download it to your computer using the `packrat::unbundle()` function.

**Step 1**  
In RStudio, create a new project and put it in a new directory called `Unbundle_Dengue`.

**Step 2**  
Download the `csx415-project.tar.gz` file from `gwenrino/CSX415.1-project/packrat/bundles` in GitHub to your new `Unbundle_Dengue` directory.

**Step 3**  
Load packrat in the R console.

``` r
# Install and load packrat
install.packages("packrat") # if needed
library(packrat)
```

**Step 4**  
Call `packrat::unbundle()`. The first argument is the object to be unbundled, and the second argument is where the unbundled project should reside (in this case, in the current directory).

``` r
packrat::unbundle(bundle = "csx415-project.tar.gz", where = ".")
```

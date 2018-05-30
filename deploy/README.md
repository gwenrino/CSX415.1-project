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

If you are interested in rebuilding this project from the source code, you can clone the repository as a new local project in RStudio.

**Step 1**  
Copy the URL of the project's GitHub repository, https://github.com/gwenrino/CSX415.1-project.

**Step 2**  
In RStudio, select File/New Project/Version Control. In the window that pops up (Clone Git Repository), paste the GitHub repository URL that you copied in Step 1. Name the project and choose the directory as you like.

**Step 3**  
CSX415.1-project is a `packrat` project, so RStudio should automatically enter packrat mode as the new project opens. This means that all packages and dependencies for the project are loaded into the project's packrat library.

**Step 4**  
Within CSX415.1-project, the project assets (data, code, and reports) are stored in the `dengue` directory, which is managed in the `ProjectTemplate` system. In order to take advantage of this project management system, do the following:  

Change your working directory to ~/CSX415.1-project/dengue, either by using the `setwd()` command or by selecting the directory through the RStudio menu Session/Set Working Directory/Choose Directory.  

Install (if necessary) and load the `ProjectTemplate` package. Then use the command `load.project()` to automatically load the environment with all the elements of the project.   

``` r
install.packages("ProjectTemplate") # if necessary
library(ProjectTemplate)
load.project()
```

All the source files (.R and .Rmd) are located under the `src` folder. Please check out the ASSETS.md file to learn more about each of the source files and what they contain!

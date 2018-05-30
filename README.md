**CSX415.1 Final Project: Prediction of Dengue Fever**
====================================================

**OVERVIEW**
------------

The goal of this project is to use data science methods to increase efficiency in staffing an imaginary public health clinic in San Juan, Puerto Rico. The approach is to forecast the number of dengue patients will treat each week using time series methods and U.S. National Oceanic and Atmospheric Administration (NOAA) weather data, and then to recommend staffing the clinic with the number of health care workers required to care for the forecasted number of patients.

**PROJECT DEPLOYMENT**
----------------------

For information on how to install and use various components of the project, including the R package that contains the forecasting tool, please see `CSX415.1-project/deploy/README.md`.

**PROJECT ORGANIZATION**
------------------------

Project assets, including data, code, and reports, are described in the file `CSX415.1-project/Assets.md`.

This project uses the [Project Template](http://projecttemplate.net/) management system. All project assets are stored according to the ProjectTemplate folder structure. The directory structure is visualized here:

    ##                                          levelName
    ## 1   project                                       
    ## 2    ¦--Assets.md                                 
    ## 3    ¦--CSX415.1-project.Rproj                    
    ## 4    ¦--dengue                                    
    ## 5    ¦   ¦--cache                                 
    ## 6    ¦   ¦   ¦--dengue.features.train.hash        
    ## 7    ¦   ¦   ¦--dengue.features.train.RData       
    ## 8    ¦   ¦   ¦--dengue.hash                       
    ## 9    ¦   ¦   ¦--dengue.labels.train.hash          
    ## 10   ¦   ¦   ¦--dengue.labels.train.RData         
    ## 11   ¦   ¦   ¦--dengue.RData                      
    ## 12   ¦   ¦   ¦--hotel.guests.copy.hash            
    ## 13   ¦   ¦   ¦--hotel.guests.copy.RData           
    ## 14   ¦   ¦   °--README.md                         
    ## 15   ¦   ¦--config                                
    ## 16   ¦   ¦   ¦--global.dcf                        
    ## 17   ¦   ¦   °--README.md                         
    ## 18   ¦   ¦--data                                  
    ## 19   ¦   ¦   ¦--dengue_features_train.csv         
    ## 20   ¦   ¦   ¦--dengue_labels_train.csv           
    ## 21   ¦   ¦   ¦--hotel_guests_copy.csv             
    ## 22   ¦   ¦   °--README.md                         
    ## 23   ¦   ¦--graphs                                
    ## 24   ¦   ¦   ¦--EDAviz                            
    ## 25   ¦   ¦   ¦   ¦--ACF.pdf                       
    ## 26   ¦   ¦   ¦   ¦--timeseries.pdf                
    ## 27   ¦   ¦   ¦   ¦--total_cases.hist.pdf          
    ## 28   ¦   ¦   ¦   °--weekofyear.pdf                
    ## 29   ¦   ¦   °--README.md                         
    ## 30   ¦   ¦--munge                                 
    ## 31   ¦   ¦   ¦--01-A.R                            
    ## 32   ¦   ¦   °--README.md                         
    ## 33   ¦   ¦--pkgs                                  
    ## 34   ¦   ¦   °--Dengue                            
    ## 35   ¦   ¦       ¦--data                          
    ## 36   ¦   ¦       ¦   ¦--dengue.model.rda          
    ## 37   ¦   ¦       ¦   °--dewpt.model.rda           
    ## 38   ¦   ¦       ¦--Dengue.Rproj                  
    ## 39   ¦   ¦       ¦--DESCRIPTION                   
    ## 40   ¦   ¦       ¦--man                           
    ## 41   ¦   ¦       ¦   °--DengueFC.Rd               
    ## 42   ¦   ¦       ¦--NAMESPACE                     
    ## 43   ¦   ¦       ¦--R                             
    ## 44   ¦   ¦       ¦   °--DengueForecast.R          
    ## 45   ¦   ¦       °--tests                         
    ## 46   ¦   ¦           ¦--testthat.R                
    ## 47   ¦   ¦           °--testthat                  
    ## 48   ¦   ¦               °--test.DengueFC.R       
    ## 49   ¦   ¦--README.md                             
    ## 50   ¦   ¦--reports                               
    ## 51   ¦   ¦   ¦--AboutModel.pdf                    
    ## 52   ¦   ¦   ¦--FormalProblemStatement.pdf        
    ## 53   ¦   ¦   ¦--ModelEvaluations                  
    ## 54   ¦   ¦   ¦   ¦--0.NaiveEval.pdf               
    ## 55   ¦   ¦   ¦   ¦--1.LinearEval.pdf              
    ## 56   ¦   ¦   ¦   ¦--2.TreeEval.pdf                
    ## 57   ¦   ¦   ¦   ¦--3.ArimaEval.pdf               
    ## 58   ¦   ¦   ¦   ¦--4.DynRegEval.pdf              
    ## 59   ¦   ¦   ¦   °--5.VAREval.pdf                 
    ## 60   ¦   ¦   °--README.md                         
    ## 61   ¦   °--src                                   
    ## 62   ¦       ¦--Deploy                            
    ## 63   ¦       ¦   °--myfunction.R                  
    ## 64   ¦       ¦--EDA                               
    ## 65   ¦       ¦   ¦--EDA.R                         
    ## 66   ¦       ¦   °--EDA.viz.R                     
    ## 67   ¦       ¦--FeatureSelection                  
    ## 68   ¦       ¦   °--FeatureSelection.R            
    ## 69   ¦       ¦--Models                            
    ## 70   ¦       ¦   ¦--0.Naive.R                     
    ## 71   ¦       ¦   ¦--1.Linear.R                    
    ## 72   ¦       ¦   ¦--2.Tree.R                      
    ## 73   ¦       ¦   ¦--3.Arima.R                     
    ## 74   ¦       ¦   ¦--4.0.DynamicRegression.R       
    ## 75   ¦       ¦   ¦--4.1.DynRegValidation.R        
    ## 76   ¦       ¦   °--5.VAR.R                       
    ## 77   ¦       ¦--README.md                         
    ## 78   ¦       °--Rmds                              
    ## 79   ¦           ¦--AboutModel.Rmd                
    ## 80   ¦           ¦--Assets.Rmd                    
    ## 81   ¦           ¦--Deploy.Rmd                    
    ## 82   ¦           ¦--FormalProblemStatement.Rmd    
    ## 83   ¦           ¦--ModelEvaluations              
    ## 84   ¦           ¦   ¦--0.NaiveEval.Rmd           
    ## 85   ¦           ¦   ¦--1.LinearEval.Rmd          
    ## 86   ¦           ¦   ¦--2.TreeEval.Rmd            
    ## 87   ¦           ¦   ¦--3.ArimaEval.Rmd           
    ## 88   ¦           ¦   ¦--4.DynRegEval.Rmd          
    ## 89   ¦           ¦   °--5.VAREval.Rmd             
    ## 90   ¦           ¦--Root.md                       
    ## 91   ¦           °--Root.Rmd                      
    ## 92   ¦--deploy                                    
    ## 93   ¦   °--README.md                             
    ## 94   ¦--GRADE.md                                  
    ## 95   ¦--packrat                                   
    ## 96   ¦   ¦--bundles                               
    ## 97   ¦   ¦   °--CSX415.1-project-2018-05-29.tar.gz
    ## 98   ¦   ¦--init.R                                
    ## 99   ¦   ¦--lib-R                                 
    ## 100  ¦   ¦   °--... 1 nodes w/ 1608 sub           
    ## 101  ¦   °--... 4 nodes w/ 24217 sub              
    ## 102  °--... 1 nodes w/ 24221 sub

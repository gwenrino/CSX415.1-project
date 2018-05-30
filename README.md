**CSX415.1 Final Project: Prediction of Dengue Fever**
====================================================

**OVERVIEW**
------------

The goal of this project is to use data science methods to increase efficiency in staffing an imaginary public health clinic in San Juan, Puerto Rico. The approach is to forecast the number of dengue patients the clinic will treat each week using time series methods and U.S. National Oceanic and Atmospheric Administration (NOAA) weather data, and then to recommend staffing the clinic with the number of health care workers required to care for the forecasted number of patients.

For more information about the context and goals of the project, please see the [Formal Problem Statement](https://github.com/gwenrino/CSX415.1-project/blob/master/dengue/reports/AboutModel.pdf).

**PROJECT DEPLOYMENT**
----------------------

For information on how to install and use various components of the project, including the R package that contains the forecasting tool, please see [CSX415.1-project/deploy/README.md](https://github.com/gwenrino/CSX415.1-project/tree/master/deploy).

For an analysis of the potential impact of the project, please see [About the Dengue Forecasting Tool](https://github.com/gwenrino/CSX415.1-project/blob/master/dengue/reports/AboutModel.pdf).

**PROJECT ORGANIZATION**
------------------------

Project assets, including data, code, and reports, are described in the file [CSX415.1-project/Assets.md](https://github.com/gwenrino/CSX415.1-project/blob/master/Assets.md).

This project uses the [Project Template](http://projecttemplate.net/) management system. All project assets are stored according to the ProjectTemplate folder structure. The directory structure of the `dengue` folder is visualized here:

    ##                                 levelName
    ## 1  project                               
    ## 2   ¦--cache                             
    ## 3   ¦   ¦--dengue.features.train.hash    
    ## 4   ¦   ¦--dengue.features.train.RData   
    ## 5   ¦   ¦--dengue.hash                   
    ## 6   ¦   ¦--dengue.labels.train.hash      
    ## 7   ¦   ¦--dengue.labels.train.RData     
    ## 8   ¦   ¦--dengue.RData                  
    ## 9   ¦   ¦--hotel.guests.copy.hash        
    ## 10  ¦   ¦--hotel.guests.copy.RData       
    ## 11  ¦   °--README.md                     
    ## 12  ¦--config                            
    ## 13  ¦   ¦--global.dcf                    
    ## 14  ¦   °--README.md                     
    ## 15  ¦--data                              
    ## 16  ¦   ¦--dengue_features_train.csv     
    ## 17  ¦   ¦--dengue_labels_train.csv       
    ## 18  ¦   ¦--hotel_guests_copy.csv         
    ## 19  ¦   °--README.md                     
    ## 20  ¦--graphs                            
    ## 21  ¦   ¦--EDAviz                        
    ## 22  ¦   ¦   ¦--ACF.pdf                   
    ## 23  ¦   ¦   ¦--timeseries.pdf            
    ## 24  ¦   ¦   ¦--total_cases.hist.pdf      
    ## 25  ¦   ¦   °--weekofyear.pdf            
    ## 26  ¦   °--README.md                     
    ## 27  ¦--munge                             
    ## 28  ¦   ¦--01-A.R                        
    ## 29  ¦   °--README.md                     
    ## 30  ¦--pkgs                              
    ## 31  ¦   °--Dengue                        
    ## 32  ¦       ¦--data                      
    ## 33  ¦       ¦   ¦--dengue.model.rda      
    ## 34  ¦       ¦   °--dewpt.model.rda       
    ## 35  ¦       ¦--Dengue.Rproj              
    ## 36  ¦       ¦--DESCRIPTION               
    ## 37  ¦       ¦--man                       
    ## 38  ¦       ¦   °--DengueFC.Rd           
    ## 39  ¦       ¦--NAMESPACE                 
    ## 40  ¦       ¦--R                         
    ## 41  ¦       ¦   °--DengueForecast.R      
    ## 42  ¦       °--tests                     
    ## 43  ¦           ¦--testthat.R            
    ## 44  ¦           °--testthat              
    ## 45  ¦               °--test.DengueFC.R   
    ## 46  ¦--README.md                         
    ## 47  ¦--reports                           
    ## 48  ¦   ¦--AboutModel.pdf                
    ## 49  ¦   ¦--FormalProblemStatement.pdf    
    ## 50  ¦   ¦--ModelEvaluations              
    ## 51  ¦   ¦   ¦--0.NaiveEval.pdf           
    ## 52  ¦   ¦   ¦--1.LinearEval.pdf          
    ## 53  ¦   ¦   ¦--2.TreeEval.pdf            
    ## 54  ¦   ¦   ¦--3.ArimaEval.pdf           
    ## 55  ¦   ¦   ¦--4.DynRegEval.pdf          
    ## 56  ¦   ¦   °--5.VAREval.pdf             
    ## 57  ¦   °--README.md                     
    ## 58  °--src                               
    ## 59      ¦--Deploy                        
    ## 60      ¦   °--myfunction.R              
    ## 61      ¦--EDA                           
    ## 62      ¦   ¦--EDA.R                     
    ## 63      ¦   °--EDA.viz.R                 
    ## 64      ¦--FeatureSelection              
    ## 65      ¦   °--FeatureSelection.R        
    ## 66      ¦--Models                        
    ## 67      ¦   ¦--0.Naive.R                 
    ## 68      ¦   ¦--1.Linear.R                
    ## 69      ¦   ¦--2.Tree.R                  
    ## 70      ¦   ¦--3.Arima.R                 
    ## 71      ¦   ¦--4.0.DynamicRegression.R   
    ## 72      ¦   ¦--4.1.DynRegValidation.R    
    ## 73      ¦   °--5.VAR.R                   
    ## 74      ¦--README.md                     
    ## 75      °--Rmds                          
    ## 76          ¦--AboutModel.Rmd            
    ## 77          ¦--Assets.Rmd                
    ## 78          ¦--Deploy.Rmd                
    ## 79          ¦--FormalProblemStatement.Rmd
    ## 80          ¦--ModelEvaluations          
    ## 81          ¦   ¦--0.NaiveEval.Rmd       
    ## 82          ¦   ¦--1.LinearEval.Rmd      
    ## 83          ¦   ¦--2.TreeEval.Rmd        
    ## 84          ¦   ¦--3.ArimaEval.Rmd       
    ## 85          ¦   ¦--4.DynRegEval.Rmd      
    ## 86          ¦   °--5.VAREval.Rmd         
    ## 87          °--Root.Rmd

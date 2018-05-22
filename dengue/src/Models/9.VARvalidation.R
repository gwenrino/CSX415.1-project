library('ProjectTemplate')
load.project()

# Create time series of selected features
selected <- dengue.med[c("total_cases", "nonres_guests", "station_max_temp_c", 
                         "reanalysis_tdtr_k", "reanalysis_dew_point_temp_k",
                         "reanalysis_specific_humidity_g_per_kg")]
ts.selected <- ts(selected,
                  freq = 365.25/7,
                  start = decimal_date(ymd("1990-05-07")))

dengue.model <- VAR(ts.selected, p=3, type = "both")

## 500 rolling origins cross validation with h=1

h <- 1 # the horizon
train1 <- subset(ts.selected, end = 436) # subset of series ending at this point
test1 <- subset(ts.selected, start = 437) # subset of series beginning and next point
n <- length(test1[,1]) - h + 1 # number of obs in test set (500) - horizon (1) + 1
fcmat <- matrix(0, nrow=n, ncol=h) # a matrix of 0s that is 500x1
for(i in 1:n) 
{  
  x <- subset(ts.selected, end = 436 + (i-1)) # the ts subset (for each iteration)
  refit <- VAR(x, p=3, type="both") # fit the ts subset
  fcmat[i,] <- forecast(refit, h=h)$forecast$total_cases[["mean"]] # forecast, extract the point forecasts, put results in matrix 
}

accuracy(fcmat[,1], test1[,"total_cases"]) # compare forecasts to test set
# MAE = 7.0


## 500 rolling origins cross validation with h=2

h <- 2 # the horizon
n <- length(test1[,1]) - h + 1 # number of obs in test set (500) - horizon (2) + 1
fcmat <- matrix(0, nrow=n, ncol=h) # a matrix of 0s that is 499 x 6
for(i in 1:n) 
{  
  x <- subset(ts.selected, end = 436 + (i-1)) # the ts subset (for each iteration)
  refit <- VAR(x, p=3, type="both") # fit the ts subset
  fcmat[i,] <- forecast(refit, h=h)$forecast$total_cases[["mean"]] # forecast, extract the point forecasts, put results in matrix 
}

accuracy(fcmat[,2], subset(ts.selected, start = 438)[,"total_cases"]) # compare forecasts to true values beginning 499 from end
# MAE = 9.5


## 500 rolling origins cross validation with h=6

h <- 6 # the horizon
n <- length(test1[,1]) - h + 1 # number of obs in test set (500) - horizon (6) + 1
fcmat <- matrix(0, nrow=n, ncol=h) # a matrix of 0s that is 495 x 6
for(i in 1:n) 
{  
  x <- subset(ts.selected, end = 436 + (i-1)) # the ts subset (for each iteration)
  refit <- VAR(x, p=3, type="both") # fit the ts subset
  fcmat[i,] <- forecast(refit, h=h)$forecast$total_cases[["mean"]] # forecast, extract the point forecasts, put results in matrix 
}

accuracy(fcmat[,6], subset(ts.selected, start = 442)[,"total_cases"]) # compare forecasts to true values beginning 495 from end
# MAE = 16.4


## 500 rolling origins cross validation with h=26

h <- 26 # the horizon
n <- length(test1[,1]) - h + 1 # number of obs in test set (500) - horizon (26) + 1
fcmat <- matrix(0, nrow=n, ncol=h) # a matrix of 0s that is 475 x 6
for(i in 1:n) 
{  
  x <- subset(ts.selected, end = 436 + (i-1)) # the ts subset (for each iteration)
  refit <- VAR(x, p=3, type="both") # fit the ts subset
  fcmat[i,] <- forecast(refit, h=h)$forecast$total_cases[["mean"]] # forecast, extract the point forecasts, put results in matrix 
}

accuracy(fcmat[,26], subset(ts.selected, start = 462)[,"total_cases"]) # compare forecasts to true values beginning 475 from end
# MAE = 25.5


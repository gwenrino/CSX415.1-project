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
train1 <- window(ts.selected, end = 1998.690) # subset of series ending at this point
test1 <- window(ts.selected, start = 1998.710) # subset of series beginning and next point
n <- length(test1[,1]) - h + 1 # number of obs in test set (32) - horizon (1) + 1
fcmat <- matrix(0, nrow=n, ncol=h) # a matrix of 0s that is 32x1
for(i in 1:n) 
{  
  x <- window(ts.selected, end=1998.690 + (i-1)/(365.25/7)) # the ts window (for each iteration)
  refit <- VAR(x, p=3, type="both") # fit the ts window
  fcmat[i,] <- forecast(refit, h=h)$forecast$total_cases[["mean"]] # forecast, extract the point forecasts, put results in matrix 
}

accuracy(fcmat[,1], test1[,"total_cases"])
# MAE = 8.45

# h=6 ## THIS ISN'T QUITE RIGHT

h <- 6 # the horizon
train1 <- window(ts.selected, end = 1998.690) # subset of series ending at this point
test1 <- window(ts.selected, start = 1998.710) # subset of series beginning and next point
n <- length(test1[,1]) - h + 1 # number of obs in test set (32) - horizon (6) + 1
fcmat <- matrix(0, nrow=n, ncol=h) # a matrix of 0s that is 32x1
for(i in 1:n) 
{  
  x <- window(ts.selected, end=1998.690 + (i-1)/(365.25/7)) # the ts window (for each iteration)
  refit <- VAR(x, p=3, type="both") # fit the ts window
  fcmat[i,] <- forecast(refit, h=h)$forecast$total_cases[["mean"]] # forecast, extract the point forecasts, put results in matrix 
}

accuracy(fcmat[,6], test1[,"total_cases"])

# h=26




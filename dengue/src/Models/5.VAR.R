library('ProjectTemplate')
load.project()


# Plot time series
plot.ts(ts.selected)

# Fit VAR model with p=1 (lag 1 autoregression)
fitvar1 <- VAR(ts.selected, p=1, type = "both")
summary(fitvar1) # Examine output
acf(residuals(fitvar1)[,1]) # Residuals appear to be white noise

# Fit VAR model with p=2 (lag 2 autoregression)
fitvar2 <- VAR(ts.selected, p=2, type = "both")
summary(fitvar2) # Examine output
acf(residuals(fitvar2)[,1]) # No real improvement over previous model


### Exploration of VAR model with p=1 on forecast horizon = 6 weeks

# Make train and test sets
train <- subset(ts.selected, start = 1, end = 930)
test <- subset(ts.selected, start = 931, end = 936)

# Fit, forecast, check accuracy of forecasts
fitvar <- VAR(train, p=1, type = "both")
fcvar <- forecast(fitvar, h=6)
accuracy(fcvar, test, d=1, D=1)
# MAE = 8.4 on this test set


### Exploration of VAR model with p=1 on forecast horizon = 6 months

# Train and test sets for forecast horizon = 6 months
train.long <- subset(ts.selected, start = 1, end = 910)
test.long <- subset(ts.selected, start = 911, end = 936)

# Fit, forecast, check accuracy of forecasts
fitvar.long <- VAR(train.long, p=1, type = "both")
fcvar.long <- forecast(fitvar.long, h=26)
accuracy(fcvar.long, test.long, d=1, D=1)
# MAE = 46.5 on this tet set


### 500 rolling origin cross validation

# Divide time series with 500 observations in the test set
train1 <- subset(ts.selected, end = 436) # subset of series ending at this point
test1 <- subset(ts.selected, start = 437) # subset of series beginning at next point

# Horizon = 1 week
h <- 1 # the horizon
n <- length(test1[,1]) - h + 1 # number of obs in test set (500) - horizon (1) + 1
fcmat <- matrix(0, nrow=n, ncol=h) # a matrix of 0s that is 500x1
for(i in 1:n) 
{  
  x <- subset(ts.selected, end = 436 + (i-1)) # the ts subset (for each iteration)
  refit <- VAR(x, p=1, type="both") # fit the ts subset
  fcmat[i,] <- forecast(refit, h=h)$forecast$total_cases[["mean"]] # forecast, extract the point forecasts, put results in matrix 
}

accuracy(fcmat[,1], test1[,"total_cases"]) # compare forecasts to test set
# MAE = 6.48


## Horizon = 6 weeks
h <- 6 # the horizon
n <- length(test1[,1]) - h + 1 # number of obs in test set (500) - horizon (6) + 1
fcmat <- matrix(0, nrow=n, ncol=h) # a matrix of 0s that is 495 x 6
for(i in 1:n) 
{  
  x <- subset(ts.selected, end = 436 + (i-1)) # the ts subset (for each iteration)
  refit <- VAR(x, p=1, type="both") # fit the ts subset
  fcmat[i,] <- forecast(refit, h=h)$forecast$total_cases[["mean"]] # forecast, extract the point forecasts, put results in matrix 
}

accuracy(fcmat[,6], subset(ts.selected, start = 442)[,"total_cases"]) # compare forecasts to true values beginning 495 from end
# MAE = 14.5


## Horizon = 6 months
h <- 26 # the horizon
n <- length(test1[,1]) - h + 1 # number of obs in test set (500) - horizon (26) + 1
fcmat <- matrix(0, nrow=n, ncol=h) # a matrix of 0s that is 475 x 6
for(i in 1:n) 
{  
  x <- subset(ts.selected, end = 436 + (i-1)) # the ts subset (for each iteration)
  refit <- VAR(x, p=1, type="both") # fit the ts subset
  fcmat[i,] <- forecast(refit, h=h)$forecast$total_cases[["mean"]] # forecast, extract the point forecasts, put results in matrix 
}

accuracy(fcmat[,26], subset(ts.selected, start = 462)[,"total_cases"]) # compare forecasts to true values beginning 475 from end
# MAE = 30.9




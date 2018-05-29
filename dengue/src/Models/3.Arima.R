library('ProjectTemplate')
load.project()

##################################
### Exploration of time series ###
##################################

# Plot time series
autoplot(ts.selected[ ,"total_cases"], ylab = "Dengue Cases Per Week")
ggsave(file.path('graphs/EDAviz', 'timeseries.pdf'))

autoplot(ts.selected, facets = TRUE)

# Ljung Box Test for autocorrelation
Box.test(ts.selected[ ,"total_cases"], lag = 1, fitdf = 0, type = "Lj")
Box.test(ts.selected[ ,"total_cases"], lag = 2, fitdf = 0, type = "Lj")
Box.test(ts.selected[ ,"total_cases"], lag = 3, fitdf = 0, type = "Lj")
Box.test(ts.selected[ ,"total_cases"], lag = 4, fitdf = 0, type = "Lj")
Box.test(ts.selected[ ,"total_cases"], lag = 5, fitdf = 0, type = "Lj")
Box.test(ts.selected[ ,"total_cases"], lag = 52, fitdf = 0, type = "Lj")
# Very strongly autocorrelated at lag = 1, with decreasing autocorrelation

# Confirm that variables are stationary
adf.test(ts.selected[ ,"total_cases"])
adf.test(ts.selected[ ,"nonres_guests"])
adf.test(ts.selected[ ,"station_max_temp_c"])
adf.test(ts.selected[ ,"reanalysis_tdtr_k"])
adf.test(ts.selected[ ,"reanalysis_dew_point_temp_k"])
adf.test(ts.selected[ ,"reanalysis_specific_humidity_g_per_kg"])
# All variables stationary per adf test

# ACF plot
ggAcf(ts.selected[ ,"total_cases"]) 
ggsave(file.path('graphs/EDAviz', 'ACF.pdf'))

# Highly autocorrelated to at least lag 16, seasonality at 52?

# Quick test for seasonality
fit <- tbats(ts.selected[,"total_cases"])
!is.null(fit$seasonal) # TBATS chooses seasonal model

# Train and test sets for forecast horizon = 6
train <- subset(ts.selected, start = 1, end = 930)
test <- subset(ts.selected, start = 931, end = 936)

###########################################
### auto.arima model on target variable ###
###########################################

# Fit model
arima.mod <- auto.arima(train[ ,"total_cases"])
summary(arima.mod) # ARIMA(1,1,1)

# Confirm that residuals are white noise
checkresiduals(arima.mod)

# Forecast with horizon = 6
arima.fc <- forecast(arima.mod, h=6)

# Check accuracy on forecasted values
accuracy(arima.fc, test[ ,"total_cases"]) # MAE on this test is 1.85

## Cross validate the accuracy using tsCV()

# Function that creates forecast object
far <- function(x, h){forecast(Arima(x, order=c(1,1,1)), h=h)}

# Errors from rolling origin cross validation tsCV() function (1 week horizon)
e <- tsCV(ts.selected[ ,"total_cases"], far, h=1)

# Calculate MAE
mean(abs(e), na.rm = TRUE)
# MAE is 7.9

# Errors from rolling origin cross validation tsCV() function (6 week horizon)
e <- tsCV(ts.selected[ ,"total_cases"], far, h=6)

# Calculate MAE
mean(abs(e), na.rm = TRUE)
# MAE is 13.65

# 6 month horizon
e2 <- tsCV(ts.selected[ ,"total_cases"], far, h=26)
mean(abs(e2), na.rm = TRUE)
# MAE is 29.1
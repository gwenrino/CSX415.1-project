library('ProjectTemplate')
load.project()

# Fit autoregression model on target
arima_1 <- auto.arima(dengue.ts.target)
summary(arima_1)
# Model = ARIMA(1,1,1)
# MAE = 8.05

# Fitted values = observations - model residuals
arima_values_1 <- dengue.ts.target - residuals(arima_1)

# Plot 
plot(dengue.ts.target)
points(arima_values_1, type = "l", col = "red", lty = 2)

checkresiduals(arima_1)


## Add nonres_guests as regression term

# Time series with total_cases and nonres_guests
ts.guests <- dengue[ , 26:27]
ts.guests <- ts.guests[ , c(2,1)]
ts.guests <- ts(ts.guests,
                       freq = 365.25/7,
                       start = decimal_date(ymd("1990-05-07")))

# Fit model 
arima_2 <- auto.arima(ts.guests[ ,"total_cases"], xreg = ts.guests[ ,"nonres_guests"])
summary(arima_2)
# Model = ARIMA(2,0,1)
# MAE = 7.93

checkresiduals(arima_2)

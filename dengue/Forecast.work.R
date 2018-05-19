# Time series of selected features
selected <- dengue.med[c("total_cases", "nonres_guests", "station_max_temp_c", 
                         "reanalysis_tdtr_k", "reanalysis_dew_point_temp_k",
                         "reanalysis_specific_humidity_g_per_kg")]
ts.selected <- ts(selected,
                  freq = 365.25/7,
                  start = decimal_date(ymd("1990-05-07")))


autoplot(ts.selected[ ,"total_cases"])
autoplot(ts.selected, facets = TRUE)

# Ljung Box Test for autocorrelation
Box.test(ts.selected[ ,"total_cases"], lag = 52, fitdf = 0, type = "Lj")
# Sig p-value says this is not a white noise series

# ACF plot to understand seasonality
ggAcf(ts.selected[ ,"total_cases"]) # Seasonality = 1 (and secondarily 52)

# Naive forecast (forecast = previous week's value)
naive.model <- naive(ts.selected[ ,"total_cases"], h = 20)
autoplot(naive.model)
summary(naive.model)
checkresiduals(naive.model) # Not white noise!

# Seasonal naive forecast (forecast = previous season's value)
snaive.model <- snaive(ts.selected[ ,"total_cases"], h = 20)
autoplot(snaive.model)
summary(snaive.model)
checkresiduals(snaive.model) # Definitely not white noise.
# This model is not worth working with any more!

# Predict on test sets
train1 <- subset(ts.selected[ ,"total_cases"], start = 1, end = 916)
test1 <- subset(ts.selected[ ,"total_cases"], start = 917, end = 936)

naive.fc1 <- naive(train1, h = 20)
accuracy(naive.fc1, test1) # MAE = 9.6

autoplot(naive.fc1) + autolayer(test1, series = "Test data") 

train2 <- subset(ts.selected[ ,"total_cases"], start = 1, end = 896)
test2 <- subset(ts.selected[ ,"total_cases"], start = 897, end = 916)

naive.fc2 <- naive(train2, h = 20)
accuracy(naive.fc2, test2) # MAE = 39.1

autoplot(naive.fc2) + autolayer(test2, series = "Test data")
# Well, we see the limits of the naive method, don't we?!!

# Cross-validate with horizon = 1
e <- tsCV(ts.selected[ ,"total_cases"], 
          forecastfunction = naive, h = 1)
mean(abs(e), na.rm = TRUE) # MAE = 7.99

# Cross validate with horizon = 20
e <- tsCV(ts.selected[ ,"total_cases"],
          forecastfunction = naive, h = 20)
mean(abs(e), na.rm = TRUE) # MAE = 26.4

# ETS model selection
fit <- ets(ts.selected[ ,"total_cases"])
# Won't work with frequency greater than 24

BoxCox.lambda(ts.selected[ ,"total_cases"])
# Use lambda = 0 (natural log) for transformations as necessary?

# Dynamic regression with station_max_temp as regressor
train3 <- subset(ts.selected, start = 1, end = 916)
test3 <- subset(ts.selected, start = 917, end = 936)

fit1 <- auto.arima(train3[ ,"total_cases"], xreg = train3[ ,"station_max_temp_c"])
fc1 <- forecast(fit1, xreg = rep(29,20))
checkresiduals(fc1)
accuracy(fc1, test3[ ,"total_cases"]) # Great on this test set! Test MAE = 4.24

train4 <- subset(ts.selected, start = 1, end = 896)
test4 <- subset(ts.selected, start = 897, end = 916)

fit2 <- auto.arima(train4[ ,"total_cases"], xreg = train4[ ,"station_max_temp_c"])
fc2 <- forecast(fit2, xreg = rep(32.25,20)) # Used mean of upcoming xreg
accuracy(fc2, test4[ ,"total_cases"]) # Bad on this test set! Test MAE = 38.9!

# Dynamic regression with nonres_guests and station_max_temp_c as regressors
v <- cbind(Guests = train3[ ,"nonres_guests"],
           MaxTemp = train3[ ,"station_max_temp_c"])

fit3 <- auto.arima(train3[ ,"total_cases"], xreg = v)
fc3 <- forecast(fit3, xreg = data.frame(rep(c(127280, 29),20))) # Used mean of upcoming xreg
accuracy(fc3, test3[ ,"total_cases"])
# Test MAE = 8.87 (not as good as fit1 on same data) CHECK THIS

# Try a dynamic harmonic regression on univariate ts
# K=1
har1 <- auto.arima(train1, 
                   xreg = fourier(train1, K = 1),
                   seasonal = FALSE)
fc.har1 <- forecast(har1, xreg = fourier(test1, K=1, h = 20))
accuracy(fc.har1, test1) # Test MAE = 7.06
summary(fc.har1) # AICc=7363.65

# K=2
har2 <- auto.arima(train1, 
                   xreg = fourier(train1, K = 2),
                   seasonal = FALSE)
fc.har2 <- forecast(har2, xreg = fourier(test1, K=2, h = 20))
accuracy(fc.har2, test1) # Test MAE = 9.12
summary(fc.har2) # AICc=7365.17 (K=1 is better)

# Try TBATS
tbats.mod <- tbats(train1)
tbats.fc <- forecast(tbats.mod, h = 20)
accuracy(tbats.fc, test1)
summary(tbats.fc)
autoplot(tbats.fc)
# This model is fancy, but it's no good on this test data!
library('ProjectTemplate')
load.project()

# Final model is an ARIMA(1,1,1) with reanalysis_dew_point_temp_k as regressor.
# In order to forecast total_cases, need forecasts of reanalysis_dew_point_temp_k

# Create time series of features for use in final model, and train and test sets
final <- dengue.med[c("total_cases", "reanalysis_dew_point_temp_k")]

ts.final <- ts(final,
               freq = 365.25/7,
               start = decimal_date(ymd("1990-05-07")))

train <- subset(ts.final, start = 1, end = 930)
test <- subset(ts.final, start = 931, end = 936)

## NAIVE MODEL

# Fit model
dewpt.mod1 <- naive(ts.final[,"reanalysis_dew_point_temp_k"])
summary(dewpt.mod1)

train[,"reanalysis_dew_point_temp_k"] %>% naive() %>%
  forecast(h=6) %>% accuracy(test[,"reanalysis_dew_point_temp_k"])
# MAE on this test set = 0.64

# Cross validate using tsCV()
e <- tsCV(ts.final[,"reanalysis_dew_point_temp_k"], forecastfunction = naive, h=6)
mean(abs(e), na.rm = TRUE) # MAE is 0.81

## SEASONAL NAIVE MODEL

# Fit model
dewpt.mod2 <- snaive(ts.final[,"reanalysis_dew_point_temp_k"])
summary(dewpt.mod2)

train[,"reanalysis_dew_point_temp_k"] %>% snaive() %>%
  forecast(h=6) %>% accuracy(test[,"reanalysis_dew_point_temp_k"])
# MAE on this test set = 1.33

# Cross validate using tsCV()
e <- tsCV(ts.final[,"reanalysis_dew_point_temp_k"], forecastfunction = snaive, h=6)
mean(abs(e), na.rm = TRUE) # MAE is 0.78

# Use seasonal naive forecasts of reanalysis_dew_point_temp_k as
# xreg in forecast of total_cases using ARIMA(1,1,1) model

# Model and forecast reanalysis_dew_point_temp_k, save forecast results
dewpt.fc <- train[,"reanalysis_dew_point_temp_k"] %>% snaive() %>% forecast(h=6)

# Extract point values, assign to ptval
ptval <- dewpt.fc[["mean"]]

# Fit model, find accuracy of forecast of test set using ptval as xreg for forecasts
train[,"total_cases"] %>% 
  auto.arima(xreg = train[,"reanalysis_dew_point_temp_k"]) %>% 
  forecast(xreg = rep(ptval,6)) %>% 
  accuracy(test[,"total_cases"]) # MAE = 0.66

dengue.model <- auto.arima(ts.final[,"total_cases"], xreg = ts.final[,"reanalysis_dew_point_temp_k"])
dewpt.model <- snaive(ts.final[,"reanalysis_dew_point_temp_k"])

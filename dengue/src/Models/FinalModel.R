####################################################
### Dynamic regression with exogenous regressor  ###
####################################################
### Goal = which variable to use for xreg?       ###
####################################################

# For exploration purposes, use 6 week horizon and 
# mean of future value of xreg variable for forecasting

# Which variable as xreg makes model that best forecasts the last 6 weeks of the series?

# Split train and test sets
train <- subset(ts.selected, start = 1, end = 930)
test <- subset(ts.selected, start = 931, end = 936)

# Create xreg objects for models
v1 <- train[,"nonres_guests"]
v2 <- train[,"station_max_temp_c"]
v3 <- train[,"reanalysis_tdtr_k"]
v4 <- train[,"reanalysis_dew_point_temp_k"]
v5 <- train[,"reanalysis_specific_humidity_g_per_kg"]

# Create xreg objects for forecasts (the mean of the future value of the variable)
a <- mean(test[,"nonres_guests"])
b <- mean(test[,"station_max_temp_c"])
c <- mean(test[,"reanalysis_tdtr_k"])
d <- mean(test[,"reanalysis_dew_point_temp_k"])
e <- mean(test[,"reanalysis_specific_humidity_g_per_kg"])

## MODEL 1: nonres_guests as regressor 

# Fit model, find accuracy of forecast of test set
train[,"total_cases"] %>% auto.arima(xreg = v1) %>% 
  forecast(xreg = rep(a,6)) %>% 
  accuracy(test[,"total_cases"]) # MAE = 4.8

train[,"total_cases"] %>% auto.arima(xreg = v1) %>% summary() # ARIMA(2,0,1)

# Cross validate using ro() function from greybox
ts.small.1 <- ts.selected[,1:2]
x <- ts.small.1[,"total_cases"]
xreg <- ts.small.1[,"nonres_guests"]

ourCall <- "predict(arima(x=data, order=c(2,0,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=6,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals[437:936] - returnedValues$pred[6,]), na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 11.5

## MODEL 2: station_max_temp_c as regressor 

# Fit model, find accuracy of forecast of test set
train[,"total_cases"] %>% auto.arima(xreg = v2) %>% 
  forecast(xreg = rep(b,6)) %>% 
  accuracy(test[,"total_cases"]) # MAE = 1.4

train[,"total_cases"] %>% auto.arima(xreg = v2) %>% summary() # ARIMA(1,1,1)

# Cross validate using ro() function from greybox
ts.small.2 <- ts.selected[,c(1,3)]
x <- ts.small.2[,"total_cases"]
xreg <- ts.small.2[,"station_max_temp_c"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=6,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals[437:936] - returnedValues$pred[6,]), na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 3.1

# MODEL 3: reanalysis_tdtr_k as regressor 

# Fit model, find accuracy of forecast of test set
train[,"total_cases"] %>% auto.arima(xreg = v3) %>% 
  forecast(xreg = rep(c,6)) %>% 
  accuracy(test[,"total_cases"]) # MAE = .94

train[,"total_cases"] %>% auto.arima(xreg = v3) %>% summary() # ARIMA(1,1,1)

# Cross validate using ro() function from greybox
ts.small.3 <- ts.selected[,c(1,4)]
x <- ts.small.3[,"total_cases"]
xreg <- ts.small.3[,"reanalysis_tdtr_k"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=6,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals[437:936] - returnedValues$pred[6,]), na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 3.1

## MODEL 4: reanalysis_dew_point_temp_k as regressor 

# Fit model, find accuracy of forecast of test set
train[,"total_cases"] %>% auto.arima(xreg = v4) %>% 
  forecast(xreg = rep(d,6)) %>% 
  accuracy(test[,"total_cases"]) # MAE = 1.46

train[,"total_cases"] %>% auto.arima(xreg = v4) %>% summary() # ARIMA(1,1,1)

# Cross validate using ro() function from greybox
ts.small.4 <- ts.selected[,c(1,5)]
x <- ts.small.4[,"total_cases"]
xreg <- ts.small.4[,"reanalysis_dew_point_temp_k"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=6,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals[437:936] - returnedValues$pred[6,]), na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 3.0

## MODEL 5: reanalysis_specific_humidity_g_per_kg as regressor 

# Fit model, find accuracy of forecast of test set
train[,"total_cases"] %>% auto.arima(xreg = v5) %>% 
  forecast(xreg = rep(e,6)) %>% 
  accuracy(test[,"total_cases"]) # MAE = 9.2

train[,"total_cases"] %>% auto.arima(xreg = v5) %>% summary() # ARIMA(1,1,1)

# Cross validate using ro() function from greybox
ts.small.5 <- ts.selected[,c(1,6)]
x <- ts.small.5[,"total_cases"]
xreg <- ts.small.5[,"reanalysis_specific_humidity_g_per_kg"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=6,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals[437:936] - returnedValues$pred[6,]), na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 3.04

#############################################################
### For both 6 week horizons Model 4 seems to be the best ###
### ARIMA(1,1,1) with reanalysis_dew_point_temp_k as xreg ###
#############################################################

model <- auto.arima(ts.selected[,"total_cases"], 
                    xreg = ts.selected[,"reanalysis_dew_point_temp_k"])

# In order to forecast total_cases, need forecasts of reanalysis_dew_point_temp_k
# (In the above exploration, used mean of future values, not forecasts)

# For simplicity, use seasonal naive model to forecast reanalysis_dew_point_temp_k

# Create time series of features for use in model, and train and test sets
final <- dengue.med[c("total_cases", "reanalysis_dew_point_temp_k")]

ts.final <- ts(final,
               freq = 365.25/7,
               start = decimal_date(ymd("1990-04-30")))

train <- subset(ts.final, start = 1, end = 930)
test <- subset(ts.final, start = 931, end = 936)

# Fit model
dewpt.mod2 <- snaive(ts.final[,"reanalysis_dew_point_temp_k"])
summary(dewpt.mod2)

train[,"reanalysis_dew_point_temp_k"] %>% snaive() %>%
  forecast(h=6) %>% accuracy(test[,"reanalysis_dew_point_temp_k"])
# MAE on this test set = 1.33

# Cross validate using tsCV()
e <- tsCV(ts.final[,"reanalysis_dew_point_temp_k"], forecastfunction = snaive, h=6)
mean(abs(e), na.rm = TRUE) # MAE is 0.78

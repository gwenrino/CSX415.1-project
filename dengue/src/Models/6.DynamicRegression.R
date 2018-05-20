library('ProjectTemplate')
load.project()

# Create time series of selected features, and train and test sets
selected <- dengue.med[c("total_cases", "nonres_guests", "station_max_temp_c", 
                         "reanalysis_tdtr_k", "reanalysis_dew_point_temp_k",
                         "reanalysis_specific_humidity_g_per_kg")]

ts.selected <- ts(selected,
                  freq = 365.25/7,
                  start = decimal_date(ymd("1990-05-07")))

train <- subset(ts.selected, start = 1, end = 930)
test <- subset(ts.selected, start = 931, end = 936)

####################################################
### Dynamic regression with exogenous regressors ###
####################################################

# Create xreg objects for models
v1 <- train[,"nonres_guests"]
v2 <- train[,"station_max_temp_c"]
v3 <- train[,"reanalysis_tdtr_k"]
v4 <- train[,"reanalysis_dew_point_temp_k"]
v5 <- train[,"reanalysis_specific_humidity_g_per_kg"]

# Create xreg objects for forecasts
a <- mean(test[,"nonres_guests"])
b <- mean(test[,"station_max_temp_c"])
c <- mean(test[,"reanalysis_tdtr_k"])
d <- mean(test[,"reanalysis_dew_point_temp_k"])

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

returnedValues <- ro(x,h=6,origins=100,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 100 rolling origin cross validation = 9.72

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

returnedValues <- ro(x,h=6,origins=100,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 100 rolling origin cross validation = 9.6

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

returnedValues <- ro(x,h=6,origins=100,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 100 rolling origin cross validation = 9.6

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

returnedValues <- ro(x,h=6,origins=100,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 100 rolling origin cross validation = 9.6

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

returnedValues <- ro(x,h=6,origins=100,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 100 rolling origin cross validation = 9.6

### MODEL 4 seems to be the best model

model <- auto.arima(train[,"total_cases"], xreg = v4)
fc <- forecast(model, xreg = rep(d,6))

autoplot(fc) + autolayer(test[,"total_cases"], series = "Test Data")

library('ProjectTemplate')
load.project()

# Create time series of selected features, and train and test sets
selected <- dengue.med[c("total_cases", "nonres_guests", "station_max_temp_c", 
                         "reanalysis_tdtr_k", "reanalysis_dew_point_temp_k",
                         "reanalysis_specific_humidity_g_per_kg")]

ts.selected <- ts(selected,
                  freq = 365.25/7,
                  start = decimal_date(ymd("1990-05-07")))

####################################################
### Dynamic regression with exogenous regressors ###
### 6 week horizon                               ###
####################################################

train <- subset(ts.selected, start = 1, end = 930)
test <- subset(ts.selected, start = 931, end = 936)

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

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 9.5

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

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 8.02

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

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 8.05

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

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 7.98

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

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 7.98

### MODEL 4 seems to be the best model

model <- auto.arima(train[,"total_cases"], xreg = v4)
fc <- forecast(model, xreg = rep(d,6))

autoplot(fc) + autolayer(test[,"total_cases"], series = "Test Data")

####################################################
### Dynamic regression with exogenous regressors ###
### 6 month horizon                              ###
####################################################

train2 <- subset(ts.selected, start = 1, end = 910)
test2 <- subset(ts.selected, start = 911, end = 936)

# Create xreg objects for models
v1.1 <- train2[,"nonres_guests"]
v2.1 <- train2[,"station_max_temp_c"]
v3.1 <- train2[,"reanalysis_tdtr_k"]
v4.1 <- train2[,"reanalysis_dew_point_temp_k"]
v5.1 <- train2[,"reanalysis_specific_humidity_g_per_kg"]

# Create xreg objects for forecasts
a.1 <- mean(test2[,"nonres_guests"])
b.1 <- mean(test2[,"station_max_temp_c"])
c.1 <- mean(test2[,"reanalysis_tdtr_k"])
d.1 <- mean(test2[,"reanalysis_dew_point_temp_k"])
e.1 <- mean(test2[,"reanalysis_specific_humidity_g_per_kg"])

## MODEL 1: nonres_guests as regressor

# Fit model, find accuracy of forecast of test set
train2[,"total_cases"] %>% auto.arima(xreg = v1.1) %>% 
  forecast(xreg = rep(a.1,26)) %>% 
  accuracy(test2[,"total_cases"]) # MAE = 12.38

train2[,"total_cases"] %>% auto.arima(xreg = v1.1) %>% summary() # ARIMA(2,0,1)

# Cross validate using ro() function from greybox
ts.small.1 <- ts.selected[,1:2]
x <- ts.small.1[,"total_cases"]
xreg <- ts.small.1[,"nonres_guests"]

ourCall <- "predict(arima(x=data, order=c(2,0,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=26,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 21.4

## MODEL 2: station_max_temp_c as regressor

# Fit model, find accuracy of forecast of test set
train2[,"total_cases"] %>% auto.arima(xreg = v2.1) %>% 
  forecast(xreg = rep(b.1,26)) %>% 
  accuracy(test2[,"total_cases"]) # MAE = 34.1

train2[,"total_cases"] %>% auto.arima(xreg = v2.1) %>% summary() # ARIMA(1,1,1)

# Cross validate using ro() function from greybox
ts.small.2 <- ts.selected[,c(1,3)]
x <- ts.small.2[,"total_cases"]
xreg <- ts.small.2[,"station_max_temp_c"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=26,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 18.4

# MODEL 3: reanalysis_tdtr_k as regressor

# Fit model, find accuracy of forecast of test set
train2[,"total_cases"] %>% auto.arima(xreg = v3.1) %>% 
  forecast(xreg = rep(c.1,26)) %>% 
  accuracy(test2[,"total_cases"]) # MAE = 35.6

train2[,"total_cases"] %>% auto.arima(xreg = v3.1) %>% summary() # ARIMA(1,1,1)

# Cross validate using ro() function from greybox
ts.small.3 <- ts.selected[,c(1,4)]
x <- ts.small.3[,"total_cases"]
xreg <- ts.small.3[,"reanalysis_tdtr_k"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=26,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 18.6

## MODEL 4: reanalysis_dew_point_temp_k as regressor

# Fit model, find accuracy of forecast of test set
train2[,"total_cases"] %>% auto.arima(xreg = v4.1) %>% 
  forecast(xreg = rep(d.1,26)) %>% 
  accuracy(test2[,"total_cases"]) # MAE = 34.2

train2[,"total_cases"] %>% auto.arima(xreg = v4.1) %>% summary() # ARIMA(1,1,1)

# Cross validate using ro() function from greybox
ts.small.4 <- ts.selected[,c(1,5)]
x <- ts.small.4[,"total_cases"]
xreg <- ts.small.4[,"reanalysis_dew_point_temp_k"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=26,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 18.0

## MODEL 5: reanalysis_specific_humidity_g_per_kg as regressor

# Fit model, find accuracy of forecast of test set
train2[,"total_cases"] %>% auto.arima(xreg = v5.1) %>% 
  forecast(xreg = rep(e.1,26)) %>% 
  accuracy(test2[,"total_cases"]) # MAE = 34.0

train2[,"total_cases"] %>% auto.arima(xreg = v5.1) %>% summary() # ARIMA(1,1,1)

# Cross validate using ro() function from greybox
ts.small.5 <- ts.selected[,c(1,6)]
x <- ts.small.5[,"total_cases"]
xreg <- ts.small.5[,"reanalysis_specific_humidity_g_per_kg"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=26,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 18.0

### MODEL 4 seems to be the best model

model <- auto.arima(train2[,"total_cases"], xreg = v4.1)
fc <- forecast(model, xreg = rep(d.1,26))

###############################################
### Forecasting reanalysis_dew_point_temp_k ###
### for use in xreg forecasting             ###
###############################################

# Model is an ARIMA(1,1,1) with reanalysis_dew_point_temp_k as regressor.
# In order to forecast total_cases, need forecasts of reanalysis_dew_point_temp_k

# Create time series of features for use in model, and train and test sets
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

# Cross validate this model using ro() function from greybox
x <- ts.final[,"total_cases"]
xreg <- ts.final[,"reanalysis_dew_point_temp_k"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=6,origins=500,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 500 rolling origin cross validation = 7.98

# Models with all data 
dengue.model <- auto.arima(ts.final[,"total_cases"], xreg = ts.final[,"reanalysis_dew_point_temp_k"])
dewpt.model <- snaive(ts.final[,"reanalysis_dew_point_temp_k"])
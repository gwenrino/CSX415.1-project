# Time series of selected features
selected <- dengue.med[c("total_cases", "nonres_guests", "station_max_temp_c", 
                         "reanalysis_tdtr_k", "reanalysis_dew_point_temp_k",
                         "reanalysis_specific_humidity_g_per_kg")]

ts.selected <- ts(selected,
                  freq = 365.25/7,
                  start = decimal_date(ymd("1990-05-07")))

train <- subset(ts.selected, start = 1, end = 930)
test <- subset(ts.selected, start = 931, end = 936)

### DYNAMIC REGRESSION WITH EXOGENOUS REGRESSOR(S)

a <- mean(test[,"nonres_guests"])
b <- mean(test[,"station_max_temp_c"])
c <- mean(test[,"reanalysis_tdtr_k"])
d <- mean(test[,"reanalysis_dew_point_temp_k"])
e <- mean(test[,"reanalysis_specific_humidity_g_per_kg"])

v1.0 <- train[,"nonres_guests"]
v2.0 <- train[,"station_max_temp_c"]
v3.0 <- train[,"reanalysis_tdtr_k"]
v4.0 <- train[,"reanalysis_dew_point_temp_k"]
v5.0 <- train[,"reanalysis_specific_humidity_g_per_kg"]

v1.1 <- c(train[,"nonres_guests"], train[,"station_max_temp_c"])
v1.2 <- c(train[,"nonres_guests"], train[,"reanalysis_tdtr_k"])
v1.3 <- c(train[,"nonres_guests"], train[,"reanalysis_dew_point_temp_k"])
v1.4 <- c(train[,"nonres_guests"], train[,"reanalysis_specific_humidity_g_per_kg"])

v2.1 <- c(train[,"station_max_temp_c"], train[,"reanalysis_tdtr_k"])
v2.2 <- c(train[,"station_max_temp_c"], train[,"reanalysis_dew_point_temp_k"])
v2.3 <- c(train[,"station_max_temp_c"], train[,"reanalysis_specific_humidity_g_per_kg"])

v3.1 <- c(train[,"reanalysis_tdtr_k"], train[,"reanalysis_dew_point_temp_k"]) 
v3.2 <- c(train[,"reanalysis_tdtr_k"], train[,"reanalysis_specific_humidity_g_per_kg"])

v4.1 <- c(train[,"reanalysis_dew_point_temp_k"], train[,"reanalysis_specific_humidity_g_per_kg"])

## Model 1: nonres_guests as regressor
train[,"total_cases"] %>% auto.arima(xreg = v1.0) %>% 
  forecast(xreg = rep(a,6)) %>% 
  accuracy(test[,"total_cases"]) # 4.8

train[,"total_cases"] %>% auto.arima(xreg = v1.0) %>% summary()

# Cross validate using ro() function from greybox
ts.small.1 <- ts.selected[,1:2]
x <- ts.small.1[,"total_cases"]
xreg <- ts.small.1[,"nonres_guests"]

ourCall <- "predict(arima(x=data, order=c(2,0,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=6,origins=10,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 10 rolling origin cross validation = 5.7

## Model 2: station_max_temp_c as regressor
train[,"total_cases"] %>% auto.arima(xreg = v2.0) %>% 
  forecast(xreg = rep(b,6)) %>% 
  accuracy(test[,"total_cases"]) # 1.4

train[,"total_cases"] %>% auto.arima(xreg = v2.0) %>% summary()

# Cross validate using ro() function from greybox
ts.small.2 <- ts.selected[,c(1,3)]
x <- ts.small.2[,"total_cases"]
xreg <- ts.small.2[,"station_max_temp_c"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=6,origins=10,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 10 rolling origin cross validation = 1.9

## Model 3: reanalysis_tdtr_k as regressor
train[,"total_cases"] %>% auto.arima(xreg = v3.0) %>% 
  forecast(xreg = rep(c,6)) %>% 
  accuracy(test[,"total_cases"]) # .94

train[,"total_cases"] %>% auto.arima(xreg = v3.0) %>% summary()

# Cross validate using ro() function from greybox
ts.small.3 <- ts.selected[,c(1,4)]
x <- ts.small.3[,"total_cases"]
xreg <- ts.small.3[,"reanalysis_tdtr_k"]

ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

returnedValues <- ro(x,h=6,origins=10,ourCall,ourValue)

mean(abs(returnedValues$actuals - returnedValues$pred),na.rm = TRUE)
# MAE of 10 rolling origin cross validation = 2.0






train[,"total_cases"] %>% auto.arima(xreg = v4.0) %>% 
  forecast(xreg = rep(d,6)) %>% 
  accuracy(test[,"total_cases"]) # 1.5

train[,"total_cases"] %>% auto.arima(xreg = v5.0) %>% 
  forecast(xreg = rep(e,6)) %>% 
  accuracy(test[,"total_cases"]) # 1.4













rep.row<-function(x,n){
  matrix(rep(x,each=n),nrow=n)
}

train[,"total_cases"] %>% auto.arima(xreg = v1.1) %>% 
  forecast(xreg = data.frame(rep(c(a,b), 6))) %>% 
  accuracy(test[,"total_cases"])

train[,"total_cases"] %>% auto.arima(xreg = v1.1) %>% 
  forecast(xreg = rep.row(cbind(a,b),6)) %>% 
  accuracy(test[,"total_cases"])



# station_max_temp as regressor
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

# nonres_guests and station_max_temp_c as regressors
v <- cbind(Guests = train3[ ,"nonres_guests"],
           MaxTemp = train3[ ,"station_max_temp_c"])

fit3 <- auto.arima(train3[ ,"total_cases"], xreg = v)
fc3 <- forecast(fit3, xreg = data.frame(rep(127280, 29),20)) # Used mean of upcoming xreg
accuracy(fc3, test3[ ,"total_cases"])
# Test MAE = 8.87 (not as good as fit1 on same data)

### DYNAMIC HARMONIC REGRESSION (UNIVARIATE)

# K=1
har1 <- auto.arima(train1, 
                   xreg = fourier(train1, K = 1),
                   seasonal = FALSE)
fc.har1 <- forecast(har1, xreg = fourier(test1, K=1, h = 20))
accuracy(fc.har1, test1) # Test MAE = 7.06
summary(fc.har1) # AICc=7363.65

library('ProjectTemplate')
load.project()

# Plot time series
plot.ts(ts.selected)

# Fit VAR model with p=1 (lag 1 autoregression)
fitvar1 <- VAR(ts.selected, p=1, type = "both")
summary(fitvar1) # Examine output
acf(residuals(fitvar1)[,1]) # Plot shows residuals not entirely white noise -- add another lag

# Fit VAR model with p=2 (lag 2 autoregression)
fitvar2 <- VAR(ts.selected, p=2, type = "both")
summary(fitvar2) # Examine output
acf(residuals(fitvar2)[,1]) # Plot shows residuals not entirely white noise -- add another lag

# Fit VAR model with p=3 (lag 3 autoregression)
fitvar3 <- VAR(ts.selected, p=3, type = "both")
summary(fitvar3) # Examine output
acf(residuals(fitvar3)[,1])  # Residuals appear to be white noise

# Fit VAR model with p=4 (lag 4 autoregression)
fitvar4 <- VAR(ts.selected, p=4, type = "both")
summary(fitvar4) # Examine output
acf(residuals(fitvar4)[,1]) # No gain over previous model

## Exploration of VAR model with p=3 on forecast horizon = 6 weeks

# Make train and test sets
train <- subset(ts.selected, start = 1, end = 930)
test <- subset(ts.selected, start = 931, end = 936)

# Fit, forecast, check accuracy of forecasts
fitvar <- VAR(train, p=3, type = "both")
fcvar <- forecast(fitvar, h=6)
accuracy(fcvar, test, d = 3, D = 1)
# MAE = 8.0 on this test set

## Exploration of VAR model with p=3 on forecast horizon = 6 months

# Train and test sets for forecast horizon = 6 months
train.long <- subset(ts.selected, start = 1, end = 910)
test.long <- subset(ts.selected, start = 911, end = 936)

# Fit, forecast, check accuracy of forecasts
fitvar.long <- VAR(train.long, p=3, type = "both")
fcvar.long <- forecast(fitvar.long, h=26)
accuracy(fcvar.long,test.long,d=3,D=1)
# MAE = 26.8 on this tet set

## Compare VAR MAEs to Dyn Reg model to determine which is better

dewpt.model <- snaive(ts.selected[,"reanalysis_dew_point_temp_k"]) # for use as xreg in Dyn Reg forecasts

## Long horizon (6 month) test set 2 (Dyn Reg model better)

train2 <- subset(ts.selected, start = 1, end = 522)
test2 <- subset(ts.selected, start = 523, end = 548)

# VAR MAE = 23.9
train2 %>% VAR(p=3, type = "both") %>% forecast(h=26) %>% accuracy(test2, d=3, D=1)

# Dyn Reg MAE = 17.7
train2[,"total_cases"] %>% auto.arima(xreg = train2[,"reanalysis_dew_point_temp_k"]) %>% 
  forecast(xreg = rep(forecast(dewpt.model, h=26)[["mean"]])) %>% 
  accuracy(test2[,"total_cases"])

## Long horizon (6 month) test set 3 (VAR model better)

train3 <- subset(ts.selected, start = 1, end = 574)
test3 <- subset(ts.selected, start = 575, end = 600)

# VAR MAE = 15.7
train3 %>% VAR(p=3, type = "both") %>% forecast(h=26) %>% accuracy(test3, d=3, D=1)

# Dyn Reg MAE = 15.9
train3[,"total_cases"] %>% auto.arima(xreg = train3[,"reanalysis_dew_point_temp_k"]) %>% 
  forecast(xreg = rep(forecast(dewpt.model, h=26)[["mean"]])) %>% 
  accuracy(test3[,"total_cases"])

## Long horizon (6 month) test set 4 (VAR model much better)

train4 <- subset(ts.selected, start = 1, end = 626)
test4 <- subset(ts.selected, start = 627, end = 652)

# VAR MAE = 6.8
train4 %>% VAR(p=3, type = "both") %>% forecast(h=26) %>% accuracy(test4, d=3, D=1)

# Dyn Reg MAE = 16.8
train4[,"total_cases"] %>% auto.arima(xreg = train4[,"reanalysis_dew_point_temp_k"]) %>% 
  forecast(xreg = rep(forecast(dewpt.model, h=26)[["mean"]])) %>% 
  accuracy(test4[,"total_cases"])

## Long horizon (6 month) test set 5 (VAR model much better)

train5 <- subset(ts.selected, start = 1, end = 678)
test5 <- subset(ts.selected, start = 679, end = 704)

# VAR MAE = 6.5
train5 %>% VAR(p=3, type = "both") %>% forecast(h=26) %>% accuracy(test5, d=3, D=1)

# Dyn Reg MAE = 15.2
train5[,"total_cases"] %>% auto.arima(xreg = train5[,"reanalysis_dew_point_temp_k"]) %>% 
  forecast(xreg = rep(forecast(dewpt.model, h=26)[["mean"]])) %>% 
  accuracy(test5[,"total_cases"])

## Long horizon (6 month) test set 6 (VAR model better)

train6 <- subset(ts.selected, start = 1, end = 730)
test6 <- subset(ts.selected, start = 731, end = 756)

# VAR MAE = 4.1
train6 %>% VAR(p=3, type = "both") %>% forecast(h=26) %>% accuracy(test6, d=3, D=1)

# Dyn Reg MAE = 6.5
train6[,"total_cases"] %>% auto.arima(xreg = train6[,"reanalysis_dew_point_temp_k"]) %>% 
  forecast(xreg = rep(forecast(dewpt.model, h=26)[["mean"]])) %>% 
  accuracy(test6[,"total_cases"])

## Long horizon (6 month) test set 7 (VAR model much better)

train7 <- subset(ts.selected, start = 1, end = 782)
test7 <- subset(ts.selected, start = 783, end = 808)

# VAR MAE = 40.9
train7 %>% VAR(p=3, type = "both") %>% forecast(h=26) %>% accuracy(test7, d=3, D=1)

# Dyn Reg MAE = 55.9
train7[,"total_cases"] %>% auto.arima(xreg = train7[,"reanalysis_dew_point_temp_k"]) %>% 
  forecast(xreg = rep(forecast(dewpt.model, h=26)[["mean"]])) %>% 
  accuracy(test7[,"total_cases"])

## Long horizon (6 month) test set 8 (VAR model better)

train8 <- subset(ts.selected, start = 1, end = 834)
test8 <- subset(ts.selected, start = 835, end = 860)

# VAR MAE = 3.8
train8 %>% VAR(p=3, type = "both") %>% forecast(h=26) %>% accuracy(test8, d=3, D=1)

# Dyn Reg MAE = 5.1
train8[,"total_cases"] %>% auto.arima(xreg = train8[,"reanalysis_dew_point_temp_k"]) %>% 
  forecast(xreg = rep(forecast(dewpt.model, h=26)[["mean"]])) %>% 
  accuracy(test8[,"total_cases"])

## Long horizon (6 month) test set 9 (VAR model better)

train9 <- subset(ts.selected, start = 1, end = 886)
test9 <- subset(ts.selected, start = 887, end = 912)

# VAR MAE = 45.5
train9 %>% VAR(p=3, type = "both") %>% forecast(h=26) %>% accuracy(test9, d=3, D=1)

# Dyn Reg MAE = 53.5
train9[,"total_cases"] %>% auto.arima(xreg = train9[,"reanalysis_dew_point_temp_k"]) %>% 
  forecast(xreg = rep(forecast(dewpt.model, h=26)[["mean"]])) %>% 
  accuracy(test9[,"total_cases"])

# Final version of model, using all data
dengue.model <- VAR(ts.selected, p=3, type = "both")

# VAR seems better than Dyn Reg on most of these tests, but Dyn Reg cross validation
# gives better MAEs than VAR cross validation.

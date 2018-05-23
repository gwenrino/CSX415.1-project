library('ProjectTemplate')
load.project()

# Model of total_cases with reanalysis_dew_point_temp_k as regressor
model <- auto.arima(ts.final[,"total_cases"], xreg = ts.final[,"reanalysis_dew_point_temp_k"])
# Model of dew point time series
dewpt.model <- snaive(ts.final[,"reanalysis_dew_point_temp_k"])
# Get the forecasts of the next h values of dew point
ptval <- forecast(dewpt.model, h=h)[["mean"]] 
# Model with dewpt forecasts
dengue.model <- auto.arima(ts.final[,"total_cases"], xreg = rep[ptval])


# Set up for cross validation

x <- ts.final[,"total_cases"]
xreg <- ts.final[,"reanalysis_dew_point_temp_k"]
ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

## 500 rolling origins cross validation with h=1 using greybox::ro()

returnedValues1 <- ro(x,h=1,origins=500,ourCall,ourValue)
mean(abs(returnedValues1$actuals - returnedValues1$pred),na.rm = TRUE)
# MAE = 1.1

## 500 rolling origins cross validation with h=2 using greybox::ro()

returnedValues2 <- ro(x,h=2,origins=500,ourCall,ourValue)
mean(abs(returnedValues2$actuals - returnedValues2$pred),na.rm = TRUE)
# MAE = 3.9

## 500 rolling origins cross validation with h=6 using greybox::ro()

returnedValues6 <- ro(x,h=6,origins=500,ourCall,ourValue)
mean(abs(returnedValues6$actuals - returnedValues6$pred),na.rm = TRUE)
# MAE = 7.98

## 500 rolling origins cross validation with h=26 using greybox::ro()

returnedValues26 <- ro(x,h=26,origins=500,ourCall,ourValue)
mean(abs(returnedValues26$actuals - returnedValues26$pred),na.rm = TRUE)
# MAE = 18.0




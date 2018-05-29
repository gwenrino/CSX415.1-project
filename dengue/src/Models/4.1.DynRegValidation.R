####################################################
### CROSS VALIDATION OF DYNAMIC REGRESSION MODEL ###
####################################################

# Set up for cross validation using greybox::ro()

x <- ts.final[,"total_cases"]
xreg <- ts.final[,"reanalysis_dew_point_temp_k"]
ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

## 500 rolling origins cross validation with h=1

returnedValues1 <- ro(x,h=1,origins=500,ourCall,ourValue)
mean(abs(returnedValues1$actuals - returnedValues1$pred),na.rm = TRUE)
# MAE = 1.1

## 500 rolling origins cross validation with h=2

returnedValues2 <- ro(x,h=2,origins=500,ourCall,ourValue)
mean(abs(returnedValues2$actuals - returnedValues2$pred),na.rm = TRUE)
# MAE = 3.9

## 500 rolling origins cross validation with h=6

returnedValues6 <- ro(x,h=6,origins=500,ourCall,ourValue)
mean(abs(returnedValues6$actuals - returnedValues6$pred),na.rm = TRUE)
# MAE = 7.98

## 500 rolling origins cross validation with h=26

returnedValues26 <- ro(x,h=26,origins=500,ourCall,ourValue)
mean(abs(returnedValues26$actuals - returnedValues26$pred),na.rm = TRUE)
# MAE = 18.0




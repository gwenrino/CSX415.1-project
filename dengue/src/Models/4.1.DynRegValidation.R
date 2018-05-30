####################################################
### CROSS VALIDATION OF DYNAMIC REGRESSION MODEL ###
### using snaive forecast of xreg variable       ###   
####################################################

# Set up for cross validation using greybox::ro()

x <- ts.final[,"total_cases"]
xreg <- ts.final[,"reanalysis_dew_point_temp_k"]
ourCall <- "predict(arima(x=data, order=c(1,1,1), xreg=xreg[counti]), n.ahead=h, newxreg=xreg[counto])"
ourValue <- "pred"

## 500 rolling origins cross validation with h=1

returnedValues1 <- ro(x,h=1,origins=500,ourCall,ourValue)
mean(abs(returnedValues1$actuals[437:936] - returnedValues1$pred[1,]), na.rm = TRUE)
# MAE = 1.1

## 500 rolling origins cross validation with h=2

returnedValues2 <- ro(x,h=2,origins=500,ourCall,ourValue)
mean(abs(returnedValues2$actuals[437:936] - returnedValues2$pred[2,]), na.rm = TRUE)
# MAE = 1.9

## 500 rolling origins cross validation with h=6

returnedValues6 <- ro(x,h=6,origins=500,ourCall,ourValue)
mean(abs(returnedValues6$actuals[437:936] - returnedValues6$pred[6,]),na.rm = TRUE)
# MAE = 3.0

## 500 rolling origins cross validation with h=26

returnedValues26 <- ro(x,h=26,origins=500,ourCall,ourValue)
mean(abs(returnedValues26$actuals[437:936] - returnedValues26$pred[26,]),na.rm = TRUE)
# MAE = 3.35




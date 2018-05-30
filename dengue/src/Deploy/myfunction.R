###########################################################
## DEVELOPMENT OF THE FUNCTION TO BE USED IN THE PACKAGE ##
###########################################################

# Model of total cases time series
dengue.model <- auto.arima(ts.final[,"total_cases"], xreg = ts.final[,"reanalysis_dew_point_temp_k"])

# Model of dew point time series
dewpt.model <- snaive(ts.final[,"reanalysis_dew_point_temp_k"]) 


myfunction <- function(h){
  
  Week <- paste("Week", 1:h) # values for first column of output
  ptval <- forecast::forecast(dewpt.model, h=h)[["mean"]] # forecasts to be used as xreg term
  
  # extract 95% confidence low numbers from forecast object
  # process these numbers as forecasted low number of required staff
  ForecastLo <- round(forecast::forecast(dengue.model, xreg = rep(ptval))$lower[,2])
  ForecastLo[ForecastLo<0] <- 0
  StaffLo <-  dplyr::case_when(
    ForecastLo == 0 ~ as.numeric(1),
    ForecastLo%%9 == 0 ~ as.numeric(ForecastLo/9),
    ForecastLo%%9 != 0 ~ as.numeric(ForecastLo%/%9 + 1)
  )
  
  # extract mean numbers from forecast object
  # process these numbers as forecasted number of required staff
  ForecastMid <- round(forecast::forecast(dengue.model, xreg = rep(ptval))[["mean"]])
  ForecastMid[ForecastMid<0] <- 0
  StaffMid <-  dplyr::case_when(
    ForecastMid == 0 ~ as.numeric(1),
    ForecastMid%%9 == 0 ~ as.numeric(ForecastMid/9),
    ForecastMid%%9 != 0 ~ as.numeric(ForecastMid%/%9 + 1)
  )
  
  # extract 95% confidence high numbers from forecast object
  # process these numbers as forecasted high number of required staff
  ForecastHi <- round(forecast::forecast(dengue.model, xreg = rep(ptval))$upper[,2])
  ForecastHi[ForecastHi<0] <- 0
  StaffHi <-  dplyr::case_when(
    ForecastHi == 0 ~ as.numeric(1),
    ForecastHi%%9 == 0 ~ as.numeric(ForecastHi/9),
    ForecastHi%%9 != 0 ~ as.numeric(ForecastHi%/%9 + 1)
  )
  
  print(data.frame(Week,ForecastLo,StaffLo,ForecastMid,StaffMid,ForecastHi,StaffHi))
}

myfunction(6)




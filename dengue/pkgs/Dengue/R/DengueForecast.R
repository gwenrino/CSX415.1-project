#' @title Dengue Forecast
#' 
#' 
#' @param h forecast horizon in weeks (a number greater than 0)
#' @examples DengueFC(10) # Returns forecasts for the next 10 weeks
#' @import dplyr
#' @import forecast
#' @export

DengueFC <- function(h){
  
  Week <- paste("Week", 1:h)
  ptval <- forecast::forecast(dewpt.model, h=h)[["mean"]] 
  
  ForecastLo <- round(forecast::forecast(dengue.model, xreg = rep(ptval))$lower[,2])
  ForecastLo[ForecastLo<0] <- 0
  StaffLo <-  dplyr::case_when(
    ForecastLo == 0 ~ as.numeric(1),
    ForecastLo%%9 == 0 ~ as.numeric(ForecastLo/9),
    ForecastLo%%9 != 0 ~ as.numeric(ForecastLo%/%9 + 1)
  )
  
  ForecastMid <- round(forecast::forecast(dengue.model, xreg = rep(ptval))[["mean"]])
  ForecastMid[ForecastMid<0] <- 0
  StaffMid <-  dplyr::case_when(
    ForecastMid == 0 ~ as.numeric(1),
    ForecastMid%%9 == 0 ~ as.numeric(ForecastMid/9),
    ForecastMid%%9 != 0 ~ as.numeric(ForecastMid%/%9 + 1)
  )
  
  ForecastHi <- round(forecast::forecast(dengue.model, xreg = rep(ptval))$upper[,2])
  ForecastHi[ForecastHi<0] <- 0
  StaffHi <-  dplyr::case_when(
    ForecastHi == 0 ~ as.numeric(1),
    ForecastHi%%9 == 0 ~ as.numeric(ForecastHi/9),
    ForecastHi%%9 != 0 ~ as.numeric(ForecastHi%/%9 + 1)
  )
  
  print(data.frame(Week,ForecastLo,ForecastMid,ForecastHi,StaffLo,StaffMid,StaffHi))
}



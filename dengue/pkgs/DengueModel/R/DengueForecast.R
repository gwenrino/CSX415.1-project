#' @title Dengue Forecast
#' 
#' 
#' @param h forecast horizon in weeks (a number greater than 0)
#' @examples dengue.forecast(10) # Returns forecasts for the next 10 weeks
#' @import dplyr
#' @import forecast
#' @export

dengue.forecast <- function(h){
  
  if(h<1)
    return("h must be a number greater than 0")
  
  Week <- paste("Week", 1:h)
  
  ForecastLo <- round(forecast::forecast(dengue.model, h=h)$forecast$total_cases$lower[,2])
  ForecastLo[ForecastLo<0] <- 0
  StaffLo <-  dplyr::case_when(
    ForecastLo == 0 ~ as.numeric(1),
    ForecastLo%%9 == 0 ~ as.numeric(ForecastLo/9),
    ForecastLo%%9 != 0 ~ as.numeric(ForecastLo%/%9 + 1)
  )
  
  ForecastMid <- round(forecast::forecast(dengue.model, h=h)$forecast$total_cases[["mean"]])
  ForecastMid[ForecastMid<0] <- 0
  StaffMid <-  dplyr::case_when(
    ForecastMid == 0 ~ as.numeric(1),
    ForecastMid%%9 == 0 ~ as.numeric(ForecastMid/9),
    ForecastMid%%9 != 0 ~ as.numeric(ForecastMid%/%9 + 1)
  )
  
  ForecastHi <- round(forecast::forecast(dengue.model, h=h)$forecast$total_cases$upper[,2])
  ForecastHi[ForecastHi<0] <- 0
  StaffHi <-  dplyr::case_when(
    ForecastHi == 0 ~ as.numeric(1),
    ForecastHi%%9 == 0 ~ as.numeric(ForecastHi/9),
    ForecastHi%%9 != 0 ~ as.numeric(ForecastHi%/%9 + 1)
  )
  
  print(data.frame(Week,ForecastLo,StaffLo,ForecastMid,StaffMid,ForecastHi,StaffHi))
}


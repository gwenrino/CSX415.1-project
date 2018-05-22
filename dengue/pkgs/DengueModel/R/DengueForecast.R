#' @title Dengue Forecast
#' 
#' 
#' @param h forecast horizon in weeks (a number greater than 0)
#' @examples dengue.forecast(10) # Returns forecasts for the next 10 weeks
#' @export

dengue.forecast <- function(h){
  forecast_horizon=h
  if(h<1)
    return("h must be a number greater than 0")
  Forecast <- round(forecast(dengue.model, h=h)$forecast$total_cases[["mean"]])
  Forecast[Forecast<0] <- 0
  Week <- paste("Week", 1:h)
  Staff <-  case_when(
    Forecast == 0 ~ as.numeric(1),
    Forecast%%9 == 0 ~ as.numeric(Forecast/9),
    Forecast%%9 != 0 ~ as.numeric(Forecast%/%9 + 1),
  )
  print(data.frame(Week,Forecast,Staff))
}





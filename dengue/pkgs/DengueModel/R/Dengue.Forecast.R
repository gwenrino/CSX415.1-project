#' @title Dengue Forecast
#' 
#' This package forecasts the number of cases of dengue disease
#' in San Juan, Puerto Rico, six weeks in advance.
#' 
#' @export

ptval <- forecast(dewpt.model, h=6)[["mean"]]

dengue.forecast <- function(){
  return(forecast(dengue.model, xreg = rep(ptval))[["mean"]])
}


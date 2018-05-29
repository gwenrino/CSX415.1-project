#' @title Dengue Forecast
#' 
#' @param h forecast horizon in weeks (a number greater than 0)
#' @examples DengueFC(10) # Returns dengue case forecasts and recommended staffing levels for the next 10 weeks
#' 
#' @details The function returns six pieces of information:  \cr
#' *Forecast* is the number of dengue cases for that week as forecast by the model.  \cr
#' *Lo95* and *Hi95* show the range of the 95 percent confidence interval of the dengue forecasts for that week.  \cr
#' *StaffRec* is the number of health care workers needed to maintain the required 1:9 staffing ratio for the forecasted number of cases that week.  \cr
#' *StaffLo* and *StaffHi* show the range of number of health care workers suggested by the 95 percent confidence interval of the dengue forecasts.
#' 
#' @import dplyr
#' @import forecast
#' @export
#' @md

DengueFC <- function(h){
  
  Week <- paste("Week", 1:h) # values for first column of output
  ptval <- forecast::forecast(dewpt.model, h=h)[["mean"]] # forecasts to be used as xreg term

  # extract 95% confidence low numbers from forecast object
  # process these numbers as forecasted low number of required staff  
  Lo95 <- round(forecast::forecast(dengue.model, xreg = rep(ptval))$lower[,2])
  Lo95[Lo95<0] <- 0
  StaffLo <-  dplyr::case_when(
    Lo95 == 0 ~ as.numeric(1),
    Lo95%%9 == 0 ~ as.numeric(Lo95/9),
    Lo95%%9 != 0 ~ as.numeric(Lo95%/%9 + 1)
  )
  
  # extract mean numbers from forecast object
  # process these numbers as forecasted number of required staff
  Forecast <- round(forecast::forecast(dengue.model, xreg = rep(ptval))[["mean"]])
  Forecast[Forecast<0] <- 0
  StaffRec <-  dplyr::case_when(
    Forecast == 0 ~ as.numeric(1),
    Forecast%%9 == 0 ~ as.numeric(Forecast/9),
    Forecast%%9 != 0 ~ as.numeric(Forecast%/%9 + 1)
  )
  
  # extract 95% confidence high numbers from forecast object
  # process these numbers as forecasted high number of required staff
  Hi95 <- round(forecast::forecast(dengue.model, xreg = rep(ptval))$upper[,2])
  Hi95[Hi95<0] <- 0
  StaffHi <-  dplyr::case_when(
    Hi95 == 0 ~ as.numeric(1),
    Hi95%%9 == 0 ~ as.numeric(Hi95/9),
    Hi95%%9 != 0 ~ as.numeric(Hi95%/%9 + 1)
  )
  
  print(data.frame(Week,Lo95,Forecast,Hi95,StaffLo,StaffRec,StaffHi))
}



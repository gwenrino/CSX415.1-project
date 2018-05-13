library('ProjectTemplate')
load.project()

# Fit autoregression model on target only
arima_target <- auto.arima(dengue.ts.target)
summary(arima_target)
# Model = ARIMA(1,1,1)
# MAE = 8.05

# Fitted values = observations - model residuals
arima_values_target <- dengue.ts.target - residuals(arima_target)

# Plot 
plot(dengue.ts.target)
points(arima_values_target, type = "l", col = "red", lty = 2)

## Arima on each selected feature

# station_max_temp_c
dengue.ts.temp <- ts(dengue$station_max_temp_c,
                       freq = 365.25/7,
                       start = decimal_date(ymd("1990-05-07")))

arima_temp <- auto.arima(dengue.ts.temp)
summary(arima_temp)
# Model = ARIMA(1,1,1)(0,0,1)[52] with drift

# reanalysis_tdtr_k
dengue.ts.tdtr <- ts(dengue$reanalysis_tdtr_k,
                     freq = 365.25/7,
                     start = decimal_date(ymd("1990-05-07")))

arima_tdtr <- auto.arima(dengue.ts.tdtr)
summary(arima_tdtr)
# Model = ARIMA(0,1,4)(1,0,0)[52] with drift

## OK to here

# reanalysis_specific_humidity_g_per_kg
dengue.ts.spec.hum <- ts(dengue$reanalysis_specific_humidity_g_per_kg,
                     freq = 365.25/7,
                     start = decimal_date(ymd("1990-05-07")))

arima_spec_hum <- auto.arima(dengue.ts.spec.hum)
summary(arima_spec_hum)


# reanalysis_dew_point_temp_k
dengue.ts.dew.point <- ts(dengue$reanalysis_dew_point_temp_k,
                     freq = 365.25/7,
                     start = decimal_date(ymd("1990-05-07")))

arima_dew_point <- auto.arima(dengue.ts.dew.point)
summary(arima_dew_point)


# nonres_guests is not a time series -- model it separately




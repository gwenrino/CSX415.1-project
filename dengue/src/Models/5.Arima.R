library('ProjectTemplate')
load.project()

# Confirm that variables are stationary
adf.test(ts.selected[ ,"total_cases"])
adf.test(ts.selected[ ,"nonres_guests"])
adf.test(ts.selected[ ,"station_max_temp_c"])
adf.test(ts.selected[ ,"reanalysis_tdtr_k"])
adf.test(ts.selected[ ,"reanalysis_dew_point_temp_k"])
adf.test(ts.selected[ ,"reanalysis_specific_humidity_g_per_kg"])

# Create holdout sample
ts.train <- ts.selected[1:932, ]
ts.test <- ts.selected[933:936, ]

## UNIVARIATE TIME SERIES FORECASTING

# Fit model to train set
arima.1 <- auto.arima(ts.train[ ,"total_cases"])
summary(arima.1)

# Forecast on test set
fc.1 <- forecast(arima.1)
accuracy(fc.1)
# MAE = 8.07

## ADDING SELECTED VARIABLES AS xreg

# Define xreg
v.train <- cbind(Guests = ts.train[ ,"nonres_guests"],
                 MaxTemp = ts.train[ ,"station_max_temp_c"],
                 TDTR = ts.train[ ,"reanalysis_tdtr_k"],
                 DewPt = ts.train[ ,"reanalysis_dew_point_temp_k"],
                 SpecHum = ts.train[ ,"reanalysis_specific_humidity_g_per_kg"])

v.test <- cbind(Guests = ts.test[ ,"nonres_guests"],
                MaxTemp = ts.test[ ,"station_max_temp_c"],
                TDTR = ts.test[ ,"reanalysis_tdtr_k"],
                DewPt = ts.test[ ,"reanalysis_dew_point_temp_k"],
                SpecHum = ts.test[ ,"reanalysis_specific_humidity_g_per_kg"])

# Fit model to train set
arima.2 <- auto.arima(ts.train[ ,"total_cases"], xreg = v.train)
summary(arima.2)

# Forecast on test set
fc.2 <- forecast(arima.2, xreg = v.test)
accuracy(fc.2)
# MAE = 7.99

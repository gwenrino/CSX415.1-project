### Exploratory Data Analysis: bivariate graphs

## All predictors are continuous variables, so look at scatterplots

# These variables appear to have a positive relationship with total_cases

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_air_temp_k, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_avg_temp_k, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_dew_point_temp_k, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_max_air_temp_k, y = total_cases), position = "jitter")

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_min_air_temp_k, y = total_cases), position = "jitter")

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_relative_humidity_percent, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_specific_humidity_g_per_kg, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = station_avg_temp_c, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = station_max_temp_c, y = total_cases), position = "jitter")

ggplot(dengue.sj) + 
  geom_point(aes(x = station_min_temp_c, y = total_cases), position = "jitter")

ggplot(dengue.sj) + 
  geom_point(aes(x = ndvi_ne, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = ndvi_nw, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = ndvi_se, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = ndvi_sw, y = total_cases))

# No apparent linear relationship with these variables

ggplot(dengue.sj) + 
  geom_point(aes(x = precipitation_amt_mm, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_precip_amt_kg_per_m2, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_sat_precip_amt_mm, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_tdtr_k, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = station_diur_temp_rng_c, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = station_precip_mm, y = total_cases))

## Take a look at boxplot of season vs. total_cases

ggplot(dengue.sj) + 
  geom_boxplot(aes(x = season, y = total_cases))

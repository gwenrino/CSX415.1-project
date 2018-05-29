#######################################
### EXPLORATORY DATA VISUALIZATIONS ###
#######################################

## Histogram of response variable

g <- ggplot(dengue)

g + geom_histogram(aes(x=total_cases), bins = 50) + 
  labs(title = "Frequency of Incidence of Dengue", x = "Number of Cases", y = "Frequency")
ggsave(file.path('graphs/EDAviz', 'total_cases.hist.pdf'))

## Bivariate graphs

# These plots suggest these variables may have some 
# positive linear relationship with total_cases (not strong)

g + geom_point(aes(x = reanalysis_air_temp_k, y = total_cases))

g + geom_point(aes(x = reanalysis_avg_temp_k, y = total_cases))

g + geom_point(aes(x = reanalysis_dew_point_temp_k, y = total_cases))

g + geom_point(aes(x = reanalysis_max_air_temp_k, y = total_cases), position = "jitter")

g + geom_point(aes(x = reanalysis_min_air_temp_k, y = total_cases), position = "jitter")

g + geom_point(aes(x = reanalysis_relative_humidity_percent, y = total_cases))

g + geom_point(aes(x = reanalysis_specific_humidity_g_per_kg, y = total_cases))

g + geom_point(aes(x = station_avg_temp_c, y = total_cases))

g + geom_point(aes(x = station_max_temp_c, y = total_cases), position = "jitter")

g + geom_point(aes(x = station_min_temp_c, y = total_cases), position = "jitter")

g + geom_point(aes(x = ndvi_ne, y = total_cases))

g + geom_point(aes(x = ndvi_nw, y = total_cases))

g + geom_point(aes(x = ndvi_se, y = total_cases))

g + geom_point(aes(x = ndvi_sw, y = total_cases))

# No apparent linear relationship between total_cases and these variables

g + geom_point(aes(x = precipitation_amt_mm, y = total_cases))

g + geom_point(aes(x = reanalysis_precip_amt_kg_per_m2, y = total_cases))

g + geom_point(aes(x = reanalysis_sat_precip_amt_mm, y = total_cases))

g + geom_point(aes(x = reanalysis_tdtr_k, y = total_cases))

g + geom_point(aes(x = station_diur_temp_rng_c, y = total_cases))

g + geom_point(aes(x = station_precip_mm, y = total_cases))

g + geom_point(aes(x = nonres_guests, y = total_cases))

# Boxplot of season vs. total_cases
g + geom_boxplot(aes(x = season, y = total_cases)) + 
  labs(title = "Dengue Cases by Season", x = "Season", y = "Distribution of Cases")
# Shows slightly higher mean and much higher top quartile number of cases 
# in summer and fall than in winter and spring

# Is there any suggestion that total_cases are increasing year to year?

g + geom_col(aes(x=year, y=total_cases))

# Is there any visual pattern to the number of cases by weekofyear?

# Total cases by weekofyear
g + geom_col(aes(x=weekofyear, y=total_cases)) + 
  labs(title = "Dengue Cases by Week of the Year", x = "Week of Year", y = "Total Cases")

dengue %>% group_by(weekofyear) %>% summarize(mean = mean(total_cases)) %>%
  ggplot() + geom_col(aes(x = weekofyear, y = mean)) + 
  labs(title = "Average Number of Dengue Cases by Week of the Year",
       x = "Week of Year", y = "Average Number of Cases")
ggsave(file.path('graphs/EDAviz', 'weekofyear.pdf'))

## Time series plots

plot(dengue.ts.target, 
     main = "Dengue Disease",
     xlab = "Time",
     ylab = "Number of Cases")

plot(dengue.ts.target.diff,
     main = "Dengue Disease \n First Difference",
     xlab = "Time",
     ylab = "Weekly Difference in Number of Cases")


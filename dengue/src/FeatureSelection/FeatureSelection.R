library('ProjectTemplate')
load.project()

########################################################
### Identify most important variables by two methods ###
########################################################

## Using randomForest::importance()
dengue.rf <- randomForest(total_cases ~ . -year -weekofyear -week_start_date -season -month_year, 
                          data = dengue.knn)
importance(dengue.rf, type = 2)


## Using earth::evimp() (Multivariate Adaptive Regression Spline)
marsModel <- earth(total_cases ~ . -year -weekofyear -week_start_date -season -month_year, 
                   data = dengue.knn)
evimp(marsModel)


## Intersection of these two methods gives this list of variables:

# nonres_guests
# station_max_temp_c
# reanalysis_tdtr_k
# reanalysis_dew_point_temp_k
# reanalysis_specific_humidity_g_per_kg

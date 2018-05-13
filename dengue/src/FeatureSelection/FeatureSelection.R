library('ProjectTemplate')
load.project()

## Using randomForest
dengue.rf <- randomForest(total_cases ~ . -year -weekofyear -week_start_date -season -month_year, 
                          data = dengue.knn)
importance(dengue.rf, type = 2)


## Using earth package (Multivariate Adaptive Regression Spline)
marsModel <- earth(total_cases ~ . -year -weekofyear -week_start_date -season -month_year, 
                   data = dengue.knn)
evimp(marsModel)

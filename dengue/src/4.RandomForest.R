library('ProjectTemplate')
load.project()

# With NAs imputed with median values

rf_1 <- train(total_cases ~ . -week_start_date, 
              data = dengue.med, 
              tuneLength = 2,
              method = "ranger",
              trControl = 
                trainControl(method = "cv", number = 5, verboseIter = TRUE)
              )

print(rf_1)

# Best model values are mtry = 253, splitrule = extratrees, min.node.size = 5.
# The MAE for this model is 8.79

# With NAs imputed with knn values

rf_2 <- train(total_cases ~ . -week_start_date,
              data = dengue.knn,
              tuneLength = 2,
              method = "ranger",
              trControl = 
                trainControl(method = "cv", number = 5, verboseIter = TRUE)
              )

print(rf_2)

# Same best model values as above. MAE for this model is 8.71.
# Continue tuning using knn preprocessing.


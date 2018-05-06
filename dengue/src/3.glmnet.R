library('ProjectTemplate')
load.project()

# With NAs imputed with median values

glmnet_1 <- train(total_cases ~ . -week_start_date,
                  data = dengue.med,
                  method = "glmnet")

print(glmnet_1)

# With NAs imputed with knn values

glmnet_2 <- train(total_cases ~ . -week_start_date,
                  data = dengue.knn,
                  method = "glmnet")

print(glmnet_2)

# Best values for both models were alpha = 0.1 and lambda = 0.5350029.
# MAE for best glmnet_1 was 9.95.
# MAE for best glmnet_2 was 9.55.

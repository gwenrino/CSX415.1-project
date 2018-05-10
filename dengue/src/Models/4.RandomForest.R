library('ProjectTemplate')
load.project()

# DoParallel
cl <- makeCluster(detectCores())
registerDoParallel(cl)

# Training control
myControl <- trainControl(method = "cv", number = 5, allowParallel = TRUE, verboseIter = TRUE)

## RF with NAs imputed with median values and default mtry and ntree values
set.seed(777)
rf_1 <- train(total_cases ~ . -week_start_date, 
              data = dengue.med, 
              method = "rf",
              trControl = myControl)

print(rf_1)

# Best model has MAE of 10.06

## With NAs imputed with knn values
set.seed(555)
rf_2 <- train(total_cases ~ . -week_start_date,
              data = dengue.knn,
              method = "rf",
              trControl = myControl
              )

print(rf_2)

# Best model has MAE of 10.32

stopCluster(cl)


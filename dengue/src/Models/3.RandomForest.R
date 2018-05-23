library('ProjectTemplate')
load.project()

# Do parallel
cl <- makeCluster(detectCores())
registerDoParallel(cl)

# Training control
myControl <- trainControl(method = "cv", number = 5, verboseIter = TRUE, allowParallel = TRUE)

# With NAs imputed with median values and default mtry and ntree
set.seed(555)
rf_1 <- train(total_cases ~ . -week_start_date, 
              data = dengue.med, 
              method = "rf",
              trControl = myControl
              )

print(rf_1)


# With NAs imputed with knn values and default mtry and ntree
set.seed(565)
rf_2 <- train(total_cases ~ . -week_start_date, 
              data = dengue.knn, 
              method = "rf",
              trControl = myControl
)

print(rf_2)
# MAE with mtry = 27 is 13.8

stopCluster(cl)


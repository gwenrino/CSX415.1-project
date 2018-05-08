#' Dengue Models
#'
#' This package is for storage and recall of models for dengue project.
#' @keywords glmnet, random forest, rf

#' @export
glmnet_2 <- train(total_cases ~ . -week_start_date,
                  data = dengue.knn,
                  method = "glmnet")

#' @export
rf_1 <- train(total_cases ~ . -week_start_date, 
              data = dengue.med, 
              method = "rf",
              trControl = 
                trainControl(method = "cv",
                             number = 5,
                             allowParallel = TRUE,
                             verboseIter = TRUE)
)


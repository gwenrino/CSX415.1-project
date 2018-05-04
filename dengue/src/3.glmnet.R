library('ProjectTemplate')
load.project()

# First tried setting the arguments up, then applying them in train()
myPreprocess <- c("medianImpute", "center", "scale")
myFolds <- createFolds(dengue.sj$total_cases, k = 10)
myControl <- trainControl(
  method = "cv", verboseIter = TRUE, index = myFolds)

glmnet_1 <- train(total_cases ~ .,
                  data = dengue.sj,
                  method = "glmnet",
                  preProcess = myPreprocess,
                  trControl = myControl)
# Error = missing values in object

# Tried breaking it down to the simplest, same error
glmnet_1 <- train(total_cases ~ ., data = dengue.sj, method = "glmnet")

# Focused on preProcess argument, same error
glmnet_1 <- train(total_cases ~ ., data = dengue.sj, 
                  method = "glmnet",
                  preProcess = "medianImpute")

# Tried knn impute, same error
glmnet_1 <- train(total_cases ~ ., data = dengue.sj, 
                  method = "glmnet",
                  preProcess = "knnImpute")

# Confused! This looks exactly like model from DataCamp.
# preProcess is supposed to be an argument in train() in caret.
# Possibility of preProcess() as function before train(), but
# that seems to defeat the whole magical purpose of caret.

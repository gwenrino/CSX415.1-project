## Tree model using all features except week_start_date and year
## (including engineered feature year.season)

# Create dataset with selected features
dengue.small <- dengue[-c(1, 3)]

# Create training set
set.seed(123)
train_set <- dengue.small %>% sample_frac(0.7)
# Create test set
test_set <- anti_join(dengue.small, train_set)

# Fit model
tree_1 <- rpart(total_cases ~ ., data = train_set)

# Visualize tree
plot(as.party(tree_1))

# Predictions from tree_1
predictions.tree_1 <- predict(tree_1, newdata = test_set)

# Error = actual number of cases - predicted number of cases
error <- test_set$total_cases - predictions.tree_1

mean(abs(error))
# MAE = 17.1


## Try tree model using bootstrapping instead of training set

# With knn imputation
tree_2 <- train(total_cases ~ . -week_start_date,
                data = dengue.knn,
                method = "rpart")
print(tree_2) 
# Best model has MAE of 20.49

# With median value imputation
tree_3 <- train(total_cases ~ . -week_start_date,
                data = dengue.med,
                method = "rpart")
print(tree_3)
# Best model has MAE of 20.27
library('ProjectTemplate')
load.project()

## Tree model using all features except week_start_date and year
## (including engineered feature year.season)

# Create dataset with selected features
dengue.small <- dengue.sj %>% select(-year, -week_start_date)

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

# Find MAE
mae(error)


## Try tree model using bootstrapping instead of training set

tree_2 <- train(total_cases ~ . -week_start_date,
                data = dengue.knn,
                method = "rpart")

# This model is terrible; with cp of 0.016, the MAE is 20.8.
# Why is it so much worse than the model evaluated with training/test set validation?
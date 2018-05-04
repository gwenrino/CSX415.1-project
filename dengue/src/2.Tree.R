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
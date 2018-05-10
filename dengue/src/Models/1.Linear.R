library('ProjectTemplate')
load.project()

## Linear model using features with significant p-values in Pearson tests
## (excluding engineered feature year.season)

# Create dataset with selected features
# Data scaled, centered; missing values imputed with median values
dengue.med.sm <- dengue.med.scaled %>% select(ndvi_nw, reanalysis_air_temp_k:reanalysis_min_air_temp_k,
                                     reanalysis_relative_humidity_percent, reanalysis_specific_humidity_g_per_kg,
                                     station_avg_temp_c, station_max_temp_c, station_min_temp_c, total_cases, 
                                     weekofyear)

# Create training set
set.seed(555)
train_set.1 <- dengue.med.sm %>% sample_frac(0.7)
# Create test set
test_set.1 <- anti_join(dengue.med.sm, train_set.1)

# Fit model
lm_1 <- lm(total_cases ~ ., data = train_set.1)

summary(lm_1)

# Predictions from lm_1
predictions.lm_1 <- predict(lm_1, newdata = test_set.1)

# Error = actual number of cases - predicted number of cases
error1 <- test_set.1$total_cases - predictions.lm_1

# Find MAE
mae(error1)

# Create dataset with selected features
# Data scaled, centered; missing values imputed with knn values
dengue.knn.sm <- dengue.knn.scaled %>% select(ndvi_nw, reanalysis_air_temp_k:reanalysis_min_air_temp_k,
                                              reanalysis_relative_humidity_percent, reanalysis_specific_humidity_g_per_kg,
                                              station_avg_temp_c, station_max_temp_c, station_min_temp_c, total_cases, 
                                              weekofyear)

# Create training set
set.seed(777)
train_set.2 <- dengue.knn.sm %>% sample_frac(0.7)
# Create test set
test_set.2 <- anti_join(dengue.knn.sm, train_set.2)

# Fit model
lm_2 <- lm(total_cases ~ ., data = train_set.2)

summary(lm_2)

# Predictions from lm_2
predictions.lm_2 <- predict(lm_2, newdata = test_set.2)

# Error = actual number of cases - predicted number of cases
error2 <- test_set.2$total_cases - predictions.lm_2

# Find MAE
mae(error2)
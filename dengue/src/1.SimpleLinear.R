## Simple model = simple linear regression with x=station_avg_temp_c

# Eliminate NAs from x variable
dengue.clean <- dengue.sj[complete.cases(dengue.sj[ , 20]),]

# Fit model
lm_1 <- lm(total_cases ~ station_avg_temp_c, data = dengue.clean)

# Function that returns Mean Absolute Error
mae <- function(error)
{
  mean(abs(error))
}

# Predictions from mod_1
predictions_lm_1 <- predict(lm_1, newdata = dengue.clean)

# Error = actual number of cases - predicted number of cases
error <- dengue.clean$total_cases - predictions_lm_1

# Find MAE
mae(error)

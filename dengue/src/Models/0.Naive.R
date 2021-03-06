## Naive model = mean total_cases by season

# Find mean total_cases for fall, spring, summer, winter
dengue %>% group_by(season) %>% 
  summarize(mean = mean(total_cases, na.rm = TRUE))

# Assign seasonal mean as prediction for each observation
dengue.naive <- dengue %>% 
  mutate(predictions = case_when(season == "fall" ~ 59.2,
                                 season == "spring" ~ 11.9,
                                 season == "summer" ~ 41.6,
                                 season == "winter" ~ 23.9))

# Error = actual number of cases - predicted number of cases
error <- dengue.naive$total_cases - dengue.naive$predictions

# Find MAE for naive model
mean(abs(error))
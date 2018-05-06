# Add target labels to training dataset
dengue.data <- left_join(dengue.features.train, dengue.labels.train)

# Add season variable
dengue.data <- dengue.data %>% 
  mutate(season = 
           case_when(weekofyear >= 1 & weekofyear <= 12 ~ 'winter',
                     weekofyear >= 13 & weekofyear <= 25 ~ 'spring',
                     weekofyear >= 26 & weekofyear <= 38 ~ 'summer',
                     weekofyear >= 39 & weekofyear <= 51 ~ 'fall',
                     weekofyear >= 52 ~ 'winter')
                                      )

# Filter out San Juan data
dengue.sj <- filter(dengue.data, city == "sj")

# Remove city variable
dengue.sj <- subset(dengue.sj, select = -city)

# Convert week_start_date to date object
dengue.sj$week_start_date <- as.Date(dengue.sj$week_start_date, format = '%Y-%m-%d')


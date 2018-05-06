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

## MUNGING TO ADD DATA FROM NEW SOURCE

# Convert month_year in new data to yearmon using zoo
hotel.guests$month_year <- as.yearmon(hotel.guests$month_year, "%b-%y")

# Make new column month_year
dengue.sj$month_year <- format(as.Date(dengue.sj$week_start_date), "%b-%y")

# Convert that to yearmon using zoo
dengue.sj$month_year <- as.yearmon(dengue.sj$month_year, "%b-%y")

# Join new data using month_year yearmon object as key
dengue.sj <- left_join(dengue.sj, hotel.guests, by = "month_year")

# Reorder columns so target is last
dengue.sj <- dengue.sj[ ,c(1:23,25,26,27,24)]

## CREATE CLEAN, CENTERED, SCALED VERSIONS FOR REGRESSION MODELS

prepParams.1 <- preProcess(dengue.sj[ ,1:26], method = c("medianImpute", "center", "scale"))
dengue.med <- predict(prepParams.1, dengue.sj[ ,1:26])
dengue.med$total_cases <- dengue.sj$total_cases

prepParams.2 <- preProcess(dengue.sj[ ,1:26], method = c("knnImpute", "center", "scale"))
dengue.knn <- predict(prepParams.2, dengue.sj[ ,1:26])
dengue.knn$total_cases <- dengue.sj$total_cases

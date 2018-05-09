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
hotel.guests.copy$month_year <- as.yearmon(hotel.guests.copy$month_year, "%b-%y")

# Make new column month_year
dengue.sj$month_year <- format(as.Date(dengue.sj$week_start_date), "%b-%y")

# Convert that to yearmon using zoo
dengue.sj$month_year <- as.yearmon(dengue.sj$month_year, "%b-%y")

# Join new data using month_year yearmon object as key
dengue.sj <- left_join(dengue.sj, hotel.guests.copy, by = "month_year")

# Reorder columns so target is last
dengue.sj <- dengue.sj[ ,c(1:23,25,26,27,24)]

## CREATE CLEAN, CENTERED, SCALED VERSIONS FOR REGRESSION MODELS

# With median imputation of missing values
prepParams.1 <- preProcess(dengue.sj[ ,1:26], method = c("medianImpute", "center", "scale"))
dengue.med <- predict(prepParams.1, dengue.sj[ ,1:26]) # Create preprocessed dataset
dengue.med$total_cases <- dengue.sj$total_cases # Add target variable

# With knn imputation of missing values
prepParams.2 <- preProcess(dengue.sj[ ,1:26], method = c("knnImpute", "center", "scale"))
dengue.knn <- predict(prepParams.2, dengue.sj[ ,1:26]) # Create preprocessed dataset
dengue.knn$total_cases <- dengue.sj$total_cases # Add target variable

## CREATE TIME SERIES VERSIONS

# With median imputation of missing values
dengue.med.ts <- ts(dengue.med, 
                    freq = 365.25/7,
                    start = decimal_date(ymd("1990-05-07")))

# With knn imputation of missing values
dengue.knn.ts <- ts(dengue.knn,
                    freq = 365.25/7,
                    start = decimal_date(ymd("1990-05-07")))


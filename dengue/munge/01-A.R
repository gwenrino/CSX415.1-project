##########################
# Clean and prepare data #
##########################

# Add target labels
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
dengue <- subset(dengue.sj, select = -city)

# Convert week_start_date to date object
dengue$week_start_date <- as.Date(dengue$week_start_date, format = '%Y-%m-%d')

## MUNGING TO ADD DATA FROM NEW SOURCE

# Convert month_year in new data to yearmon using zoo
hotel.guests.copy$month_year <- as.yearmon(hotel.guests.copy$month_year, "%b-%y")

# Make new column month_year
dengue$month_year <- format(as.Date(dengue$week_start_date), "%b-%y")

# Convert that to yearmon using zoo
dengue$month_year <- as.yearmon(dengue$month_year, "%b-%y")

# Join new data using month_year yearmon object as key
dengue <- left_join(dengue, hotel.guests.copy, by = "month_year")

# Reorder columns so target is last
dengue <- dengue[ ,c(1:23,25,26,27,24)]

# Recast nonres_guests as numeric
dengue$nonres_guests <- as.numeric(as.character(sub(",", "", dengue$nonres_guests)))

## IMPUTATION OF MISSING VALUES

# With median imputation
prepParams.1 <- preProcess(dengue[ ,1:26], method = c("medianImpute"))
dengue.med <- predict(prepParams.1, dengue[ ,1:26]) # Create preprocessed dataset
dengue.med$total_cases <- dengue$total_cases # Add target variable

# With knn imputation
prepParams.2 <- preProcess(dengue[ ,1:26], method = c("knnImpute"))
dengue.knn <- predict(prepParams.2, dengue[ ,1:26]) # Create preprocessed dataset
dengue.knn$total_cases <- dengue$total_cases # Add target variable

## CENTERED AND SCALED FOR REGRESSION MODELS

# Median imputation
prepParams.3 <- preProcess(dengue.med[ ,1:26], method = c("center", "scale"))
dengue.med.scaled <- predict(prepParams.3, dengue.med[ ,1:26])
dengue.med.scaled$total_cases <- dengue.med$total_cases

# knn imputation
prepParams.4 <- preProcess(dengue.knn[ ,1:26], method = c("center", "scale"))
dengue.knn.scaled <- predict(prepParams.4, dengue.knn[ ,1:26])
dengue.knn.scaled$total_cases <- dengue.knn$total_cases

## CREATE TIME SERIES

# Target only
dengue.ts.target <- ts(dengue$total_cases,
                       freq = 365.25/7,
                       start = decimal_date(ymd("1990-05-07")))

# Time series of first differences
dengue.ts.target.diff <- diff(dengue.ts.target, lag = 52)

# Time series of selected features
selected <- dengue.med[c("total_cases", "nonres_guests", "station_max_temp_c", 
                         "reanalysis_tdtr_k", "reanalysis_dew_point_temp_k",
                         "reanalysis_specific_humidity_g_per_kg")]
ts.selected <- ts(selected,
                  freq = 365.25/7,
                  start = decimal_date(ymd("1990-05-07")))

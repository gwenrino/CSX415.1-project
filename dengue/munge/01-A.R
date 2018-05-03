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

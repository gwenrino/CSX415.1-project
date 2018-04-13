# Add target labels to training dataset
dengue.data <- left_join(dengue.features.train, dengue.labels.train)

# Filter out San Juan data
dengue.sj <- filter(dengue.data, city == "sj")

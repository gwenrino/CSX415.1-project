###############################
## EXPLORATORY DATA ANALYSIS ##
###############################

# Summary of all variables
summary(dengue)

# Response variable summary stats
summary(dengue$total_cases)

## Examine p-values from Pearson correlations for variables that 
## may have linear relationship to total_cases (per EDA viz)

# Tests that reveal significant p-values 
cor.test(dengue$weekofyear, dengue$total_cases, method="pearson")
cor.test(dengue$reanalysis_air_temp_k, dengue$total_cases, method="pearson")
cor.test(dengue$reanalysis_avg_temp_k, dengue$total_cases, method="pearson")
cor.test(dengue$reanalysis_dew_point_temp_k, dengue$total_cases, method="pearson")
cor.test(dengue$reanalysis_max_air_temp_k, dengue$total_cases, method="pearson")
cor.test(dengue$reanalysis_min_air_temp_k, dengue$total_cases, method="pearson")
cor.test(dengue$reanalysis_relative_humidity_percent, dengue$total_cases, method="pearson")
cor.test(dengue$reanalysis_specific_humidity_g_per_kg, dengue$total_cases, method="pearson")
cor.test(dengue$station_avg_temp_c, dengue$total_cases, method="pearson")
cor.test(dengue$station_max_temp_c, dengue$total_cases, method="pearson")
cor.test(dengue$station_min_temp_c, dengue$total_cases, method="pearson")
cor.test(dengue$ndvi_nw, dengue$total_cases, method="pearson")
# Tests that reveal insignificant p-values
cor.test(dengue$ndvi_ne, dengue$total_cases, method="pearson")
cor.test(dengue$ndvi_se, dengue$total_cases, method="pearson")
cor.test(dengue$ndvi_sw, dengue$total_cases, method="pearson")

## Time series exploration

# Autocorrelation
acf(dengue.ts.target, plot = FALSE)
acf(dengue.ts.target)
ggsave(file.path('graphs/EDAviz', 'autocorrelation.pdf'))
# Each observation positively associated with its recent past, for at least 16 weeks.

# Autocorrelation of diff
acf(dengue.ts.target.diff, plot = FALSE)
acf(dengue.ts.target.diff)
# Same strong (but weakening over time) positive association

library('ProjectTemplate')
load.project()

# Summary of all variables
summary(dengue.sj)

# Response variable summary stats
summary(dengue.sj$total_cases)

## Examine p-values from Pearson correlations for variables that 
## may have linear relationship to total_cases (per EDA viz)

# Significant p-values 
cor.test(dengue.sj$weekofyear, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$reanalysis_air_temp_k, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$reanalysis_avg_temp_k, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$reanalysis_dew_point_temp_k, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$reanalysis_max_air_temp_k, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$reanalysis_min_air_temp_k, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$reanalysis_relative_humidity_percent, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$reanalysis_specific_humidity_g_per_kg, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$station_avg_temp_c, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$station_max_temp_c, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$station_min_temp_c, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$ndvi_nw, dengue.sj$total_cases, method="pearson")
# Not significant p-values
cor.test(dengue.sj$ndvi_ne, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$ndvi_se, dengue.sj$total_cases, method="pearson")
cor.test(dengue.sj$ndvi_sw, dengue.sj$total_cases, method="pearson")

## Time series exploration

print(dengue.ts.target)
print(dengue.ts)

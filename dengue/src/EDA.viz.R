library('ProjectTemplate')
load.project()

### Exploratory Data Analysis: histogram of response variable

total_cases.hist <- ggplot(dengue.sj) +
  geom_histogram(aes(x=total_cases), bins = 50)
ggsave(file.path('graphs/EDAviz', 'total_cases.hist.pdf'))

### Exploratory Data Analysis: bivariate graphs

# These plots suggest these variables may have a 
# positive linear relationship with total_cases

air_temp_k.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_air_temp_k, y = total_cases))
ggsave(file.path('graphs/EDAviz', 'air_temp_k.scatter.pdf'))

avg_temp_k.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_avg_temp_k, y = total_cases))
ggsave(file.path('graphs/EDAviz', 'avg_temp_k.scatter.pdf'))

dew_point_temp_k.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_dew_point_temp_k, y = total_cases))
ggsave(file.path('graphs/EDAviz', 'dew_point_temp_k.scatter.pdf'))

max_air_temp_k.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_max_air_temp_k, y = total_cases), position = "jitter")
ggsave(file.path('graphs/EDAviz', 'max_air_temp_k.scatter.pdf'))

min_air_temp_k.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_min_air_temp_k, y = total_cases), position = "jitter")
ggsave(file.path('graphs/EDAviz', 'min_air_temp_k.scatter.pdf'))

rel_humidity.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_relative_humidity_percent, y = total_cases))
ggsave(file.path('graphs/EDAviz', 'rel_humidity.scatter.pdf'))

spec_humidity.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_specific_humidity_g_per_kg, y = total_cases))
ggsave(file.path('graphs/EDAviz', 'spec_humidity.scatter.pdf'))

avg_temp_c.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = station_avg_temp_c, y = total_cases))
ggsave(file.path('graphs/EDAviz', 'avg_temp_c.scatter.pdf'))

max_temp_c.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = station_max_temp_c, y = total_cases), position = "jitter")
ggsave(file.path('graphs/EDAviz', 'max_temp_c.scatter.pdf'))

min_temp_c.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = station_min_temp_c, y = total_cases), position = "jitter")
ggsave(file.path('graphs/EDAviz', 'min_temp_c.scatter.pdf'))

veg_ne.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = ndvi_ne, y = total_cases))
ggsave(file.path('graphs/EDAviz', 'veg_ne.scatter.pdf'))

veg_nw.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = ndvi_nw, y = total_cases))
ggsave(file.path('graphs/EDAviz', 'veg_nw.scatter.pdf'))

veg_se.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = ndvi_se, y = total_cases))
ggsave(file.path('graphs/EDAviz', 'veg_se.scatter.pdf'))

veg_sw.scatter <- ggplot(dengue.sj) + 
  geom_point(aes(x = ndvi_sw, y = total_cases))
ggsave(file.path('graphs/EDAviz', 'veg_sw.scatter.pdf'))

# No apparent linear relationship between total_cases and these variables

ggplot(dengue.sj) + 
  geom_point(aes(x = precipitation_amt_mm, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_precip_amt_kg_per_m2, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_sat_precip_amt_mm, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = reanalysis_tdtr_k, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = station_diur_temp_rng_c, y = total_cases))

ggplot(dengue.sj) + 
  geom_point(aes(x = station_precip_mm, y = total_cases))

# Take a look at boxplot of season (the only categorical variable) vs. total_cases

ggplot(dengue.sj) + 
  geom_boxplot(aes(x = season, y = total_cases))

# Is there any suggestion that total_cases are increasing year to year?

ggplot(dengue.sj) +
  geom_col(aes(x=year, y=total_cases))

# What if season is considered?

dengue.sj$year.season <- paste(dengue.sj$year,dengue.sj$season)

big.pic.bar <- dengue.sj %>% group_by(year.season) %>% 
  summarize(cases = sum(total_cases)) %>%
  ggplot(aes(x=year.season, y=cases)) +
  geom_col()
ggsave(file.path('graphs/EDAviz', 'big.pic.bar.pdf'))

# Weekofyear?

ggplot(dengue.sj) +
  geom_col(aes(x=weekofyear, y=total_cases))
ggsave(file.path('graphs/EDAviz', 'weekofyear.bar.pdf'))

dengue.sj %>% group_by(weekofyear) %>% 
  summarize(mean = mean(total_cases)) %>%
  ggplot(aes(x=weekofyear, y=mean)) +
  geom_col()
ggsave(file.path('graphs/EDAviz', 'weekofyear.mean.bar.pdf'))

### Time series plots

plot(dengue.ts.target)
ggsave(file.path('graphs/EDAviz', 'time.series.pdf'))

This decision tree model uses all the variables except week\_start\_date, which is the unique identifier, and year. It includes the engineered feature year.season.

The first several nodes are all year.season. This makes sense as a key predictor since it accounts both for the seasonal fluctuations of the disease and also for "bad" and "not so bad" years.

Comparing this model's predictions to the actual number of cases yields a Mean Absolute Error (MAE) of 11.5.

In order to meet the required model performance level established in the FPS, a future model must reduce the MAE by 7.5.

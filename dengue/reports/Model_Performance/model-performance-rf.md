I fit random forest models using all the variables except week\_start\_date, which is the unique identifier. They include the engineered feature year.season and also the new data about number of hotel guests.

I fit random forest models with the missing values imputed two different ways: by median value, and by k nearest neighbor. Unlike in the glmnet model, this time the median value imputation gave a better result (though they were very similar, which makes sense because a tree model shouldn't be very sensitive to this kind of preprocessing).

I resampled with 5-fold cross validation using the default parameters for ntree and mtry. The best model value has mtry = 253, with MAE of 10.05.

In order to meet the required model performance level established in the FPS, a future model must reduce the MAE by 6.05.

I'm a bit surprised that the random forest model is not better than the glmnet model. However, I may be able to improve the random forest model by tuning the ntree and mtry parameters in future iterations of the model.

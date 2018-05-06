The first linear model uses the features identified as having significant p-values in Pearson correlation tests against the target variable total\_cases. The features used in the model are:

-   ndvi\_nw **(significant p-value)**
-   reanalysis\_air\_temp\_k
-   reanalysis\_avg\_temp\_k
-   reanalysis\_dew\_point\_temp\_k
-   reanalysis\_max\_air\_temp\_k **(significant p-value)**
-   reanalysis\_min\_air\_temp\_k
-   reanalysis\_relative\_humidity\_percent
-   reanalysis\_specific\_humidity\_g\_per\_kg **(significant p-value)**
-   station\_avg\_temp\_c
-   station\_max\_temp\_c
-   station\_min\_temp\_c
-   weekofyear **(significant p-value)**

Applying this model to a test set, a comparison of the predicted to the actual number of cases yields a Mean Absolute Error (MAE) of 22.2.

In order to meet the required model performance level established in the FPS, a future model must reduce the MAE by 18.2.

------------------------------------------------------------------------

The second linear model uses the same features as above but adds the engineered feature year.season.

Adding this feature greatly increases the predictive power of the model. Applying this model to a test set, a comparison of the predicted to the actual number of cases hields a Mean Absolute Error (MAE) of 12.1.

In order to meet the required model performance level established in the FPS, a future model must reduce the MAE by 8.1.

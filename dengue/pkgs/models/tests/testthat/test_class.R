library(models)

test_that("models are of expected class", {
  expect_is(glmnet_2, "train")
  expect_is(rf_1, "train")
})


library(testthat)
library(DengueModel)

test_that("function outputs a data.frame", {
  expect_equal(class(dengue.forecast(10)), "data.frame")
})

test_that("data.frame has h rows", {
  expect_equal(nrow(dengue.forecast(10)), 10)
})
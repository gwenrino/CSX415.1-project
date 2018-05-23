library(testthat)
library(Dengue)

test_that("function outputs a data.frame", {
  expect_equal(class(DengueFC(10)), "data.frame")
})

test_that("data.frame has h rows", {
  expect_equal(nrow(DengueFC(10)), 10)
})
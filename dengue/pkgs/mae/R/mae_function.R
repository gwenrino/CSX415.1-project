#' Mean Absolute Error
#'
#' This function returns the Mean Absolute Error of a vector for use in evaluating a regression model.
#' @param error
#' @keywords mae mean absolute error model evaluation
#' @export
#' @examples 
#' mae()

mae <- function(error)
{
  mean(abs(error))
}
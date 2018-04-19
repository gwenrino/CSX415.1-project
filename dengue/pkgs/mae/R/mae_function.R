#' Mean Absolute Error
#'
#' This function returns Mean Absolute Error
#' @param error
#' @keywords mae mean absolute error model evaluation
#' @export
#' @examples 
#' mae()

mae <- function(error)
{
  mean(abs(error))
}
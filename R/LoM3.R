#' LoM3
#'
#' Three parameters Logistic model
#'
#' The Logistic model function was implemented to find the value of the
#' cumulative density function of a Logistic distribution with certain shape
#' **b1**, rate parameters **b2** and superior asymptotic value lower than 1 **b3**.
#'
#' pi=b3/(b3+(exp(-(x-b1)/b2)))
#'
#' Where:
#'
#'   pi represents a binomial variable expressed as a fraction of n; for example,
#'      the proportion of active organisms to the total number of organisms in
#'      the ith class interval.
#'
#'   b1 is the point of inflection of the curve.
#'
#'   b2 is related directly to the width of the interval.
#'
#'   b3 is the asymptote value.

#' @param prm a list that stores the Logistic model's parameter values b1, b2 and b3.
#' @param x   is a numeric vector of the ith class interval.
#'
#' @returns a numerical vector with the estimated values.
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' x <- seq(5,70,by=5)
#' b1 <- 38
#' b2 <- 4
#' b3 <- 0.8
#' prm <- c("b1"=b1,"b2"=b2, "b3"=b3)
#' y_hat <- LoM3(prm, x)
#' p <- ggplot()+ geom_point(aes(x=x,y=y_hat))
#' }
#'
#' @export
LoM3 <- function(prm, x){
  b1 <- prm[1]
  b2 <- prm[2]
  b3 <- prm[3]
  x <- x
  return(b3/(b3+(exp(-(x-b1)/b2))))
}

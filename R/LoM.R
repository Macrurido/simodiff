#' LoM
#'
#' The Logistic model function was implemented to find the value of the
#' cumulative density function of a Logistic distribution with certain shape **b1**
#' and rate parameters **b2**.
#'
#' pi=1/(1+(exp(-(x-b1)/b2)))
#'
#' Where:
#'
#'   pi represents a binomial variable expressed as a fraction of n; for example,
#'      the proportion of active organisms to the total number of organisms in
#'      the ith class interval.
#'
#'   b1 is the point of inflection of the curve.
#'
#'   b2  is related directly to the width of the interval.
#'
#' @param prm a list that stores the Logistic model's parameter values b1 and b2.
#' @param x is a numeric vector of the ith class interval.
#'
#' @returns a numerical vector with the estimated values.
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' x <- seq(5,70,by=5)
#' b1 <- 38
#' b2 <- 4
#' prm <- c("b1"=b1,"b2"=b2)
#' y_hat <- LoM(prm, x)
#' p <- ggplot()+ geom_point(aes(x=x,y=y_hat))
#' }
#'
#' @export
LoM <- function(prm, x){
  b1 <- prm[1]
  b2 <- prm[2]
  x <- x
  return(1/(1+(exp(-(x-b1)/b2))))
}

#' GaM
#'
#' The Gamma model function uses the `pgamma()` function from the `stats`
#' package to find the value of the cumulative density function of a gamma
#' distribution with certain shape **b1** and rate parameters **b2**.
#'
#' **b1** is a numerical value that affects the the functional form of the curve,
#' while **b2** is a numerical value that influences the width of the interval.
#' Both are stored in the `prm` list.
#'
#' @param prm a list that stores the gamma model's parameter values b1 and b2.
#' @param x is a numeric vector of the ith class interval.
#'
#' @returns a numerical vector with the estimated values.
#'
#' @seealso pgamma() function from the stats package
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' x <- seq(5,70,by=5)
#' b1 <- 25
#' b2 <- 1
#' prm <- c("b1"=b1,"b2"=b2)
#' y_hat <- GaM(prm, x)
#' p <- ggplot()+ geom_point(aes(x=x,y=y_hat))
#'}
#'
#' @importFrom stats pgamma
#'
#' @export
GaM <- function(prm, x){
  b1 <- prm[1]
  b2 <- prm[2]
  x <- x
  return(stats::pgamma(x, b1, rate = 1/b2))
}

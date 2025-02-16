#' splot
#'
#' Plot of observed and predicted data using sigmoidal model
#'
#' The function utilizes ggplot2 to create a scatterplot that displays class
#' marks against the relative frequency of active organisms in relation to reproduction
#' (points) in a binomial distribution. The estimated value **y_hat** (solid line),
#' is calculated based on the chosen model.
#'
#' where: the candidate model function was defined and stored in the `models` list;
#' the starting parameters values was defined and stored in the `prm` list; and the `x`
#' represents the independent variable.
#'
#' To use this function, a data frame named `df` is required. This data frame should
#' include the class mark values **x**, the corresponding relative frequencies **y**,
#' and the estimated values of the independent variable **y_hat**.
#'
#' The labels for the X and Y axes were defined in `x_label` and `y_label`, respectively.
#'
#' Due to potential **Na** values, a warning may appear indicating that rows with
#' missing values or values outside the scale range have been removed.
#'
#' @param df      A data frame with three variables (columns): the independent (x),
#'                  observed (y), and predicted (y_hat).
#' @param x_label A character vector with the label for the X-axis.
#' @param y_label A character vector with the label for the y-axis.
#'
#' @returns A customized scatter plot
#'
#' @seealso Package ggplot2 version 3.5.1
#'
#' @import ggplot2
#' @import tidyverse
#'
#' @examples
#' \dontrun{
#' x <- seq(5,70, by=5)
#' y <- c(0.00, 0.06,0.05, 0.20, 0.45, 0.70, 0.88, 0.93, 1.00, 1.00, 1.00, 1.00, 1.00)
#'
#' b1 <- 38
#' b2 <- 8
#'
#' prm <- c("b1"=b1,"b2"=b2)
#' y_hat <- HiM(prm, x)
#'
#' df <- cbind(x, y, y_hat)
#' df <- as.data.frame(df)
#'
#' x_label <- "Class mark (cm)"
#' y_label <- "Proportion"
#'
#' p <- splot(df, x_label, y_label)
#' }
#'
#' @export
splot <- function(df, x_label, y_label){
  p <- ggplot(df, aes(x= df[,1], y= df[,2])) +
              geom_point(colour = "midnightblue", alpha = 0.5) +
              labs(x= x_label, y= y_label) +
              geom_line(aes(x= df[,1], y= df[,3]), lty = 1)
  print(p)
}

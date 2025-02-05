#' glad
#'
#' The `glad()` function stores the graphically determined values of the start
#' parameters of the models you want to analyze. Each of the models is analyzed
#' through a for loop; for this, the `simodiff::again()` function is nested.
#'
#' For more information, please refer to the help section of the `simodiff::again()`
#' function.
#'
#' @param models A list that contains the functions of the models.
#' @param prm A list that contains the parameters values for each model.
#' @param df A data frame with the x (class mark), y (proportion) and an empty column y_hat filled with NA
#' @param x_label A character vector with the label for the X-axis.
#' @param y_label A character vector with the label for the y-axis.
#'
#' @returns a list with the new parameter values.
#'
#' @seealso again function from simodiff package.
#'
#' @import ggplot2
#' @import tidyverse
#' @importFrom grDevices dev.set
#' @importFrom svDialogs dlgInput
#'
#' @examples
#' \dontrun{
#' i <- 1
#' x <- seq(10,30,by=2.5)
#' y <- y
#' b1 <- 38
#' b2 <- 8
#' prm[[i] <- c("b1"=b1,"b2"=b2)
#' prm <- prm[[i]]
#' df <- cbind(x, y)
#' df <- as.data.frame(df)
#' x_label <- "Class mark (cm)"
#' y_label <- "Proportion"
#' prm <- glad(models, prm, df, x_label, y_label)
#' }
#'
#' @export
glad <- function(models, prm, df, x_label, y_label){
  x <- as.numeric(df[,1])
  for(i in 1:length(models)){
    betas<- again(i, models, prm, df, x, x_label, y_label)
    prm[[i]] <- as.numeric(betas)
  }
  return(prm)
}


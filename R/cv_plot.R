#' cv_plot
#'
#' Plot of cumulative coefficient of variation.
#'
#' The efficiency of the resamples in the bootstrap simulations was analyzed
#' graphically using the number of resamples *versus* the coefficient of variation
#'  *CV*. The *CV* was calculated for the cumulative resamples of each model,
#'  with the cumulative values increasing after every *ni* data point.
#'
#'  cv=sd(X)/mean(X)*100
#'
#'  where *x* represents the vector of bootstrapped values and *sd* denotes
#'  the standard deviation.
#'
#' A data frame named `df` is required to use this function. It should include a
#' Factor column with its factor levels and resampled values in the vector *X*,
#' where *X* is a capital letter.
#'
#' The labels for the X and Y axes were defined in `x_label` and `y_label`, respectively.
#'
#' @param df      A data frame containing two columns: Factors and X. The X column represents the vector of bootstrapped values for analysis.
#' @param ni      An integer represents the starting value of the cumulative series.
#' @param B       An integer that determines the number of resamplings.
#' @param nb      An integer indicates the increasing number of the cumulative series.
#' @param x_label A character vector with the label for the X-axis.
#' @param y_label A character vector with the label for the y-axis.
#'
#' @returns
#' A plot of *CV* results against the cumulative number of iterations for each model.
#'
#' @import ggplot2
#' @import  tidyr
#'
#' @importFrom stats sd
#' @importFrom rlang .data
#'
#' @examples
#' \dontrun{
#' set.seed(16) # Set seed for reproducibility
#'
#' n <- 1000  # Sample size
#' mean_1 <- 10  # Mean of the distribution
#' sd_1 <- 3  # Standard deviation of the distribution
#' sample_1 <- rnorm(n, mean_1, sd_1)
#'
#' mean_2 <- 15  # Mean of the distribution
#' sd_2 <- 2  # Standard deviation of the distribution
#' sample_2 <- rnorm(n, mean_2, sd_2)
#'
#' X <- rbind(sample_1,sample_2) # bind resampled values in one vector
#' Factor <- as.factor(rep(c("sample_1","sample_2"), each=n))
#'
#' df <- data.frame(Factor,X= as.numeric(X))
#'
#' x_label <- "Cummulative iterations"
#' y_label <- "CV%"
#'
#' ni <- 50
#' B <- n
#' nb <- 50
#'
#' cv_plot <- cv_out(df,ni,B,nb, x_label, y_label)
#' cv_plot
#'  }
#'
#' @export
cv_plot <- function(df,ni,B,nb, x_label, y_label){
  # Create an empty data frame to store the results `cv_out`.
  r_names <- levels(df$Factor) # row names
  grp <- seq(ni,B,by=nb)  # Defining the range of accumulated values.
  cv_out <- data.frame(matrix(NA,nrow=length(grp),ncol=length(r_names)+1))
  colnames(cv_out ) <- c("X",as.character(r_names))
  cv_out$X <- grp

  # Calculate the cumulative coefficient of variation (CV) of L50 for the B
  # resamples for each model.

  for(i in 1:length(r_names)){
    tmp <- filter(df, .data$Factor == as.character(r_names[i]),)
    for(j in 1:length(grp)){
      x <- tmp[,2]
      xj <- x[c(1:grp[j])]
      cv_out[j,i+1] <- (sd(xj) / mean(xj)) * 100
    }
  }
  # Transforming the data set into a tidy format.
  tmp <- cv_out %>%
    pivot_longer(!.data$X, names_to="model", values_to = "cv")

  # Plotting the coefficient of variation (CV) results against the cumulative number
  # of iterations for each model.
  p <- ggplot(tmp, aes(x= .data$X, y= as.numeric(.data$cv))) +
    scale_linetype_binned()+
    geom_line(aes(x= .data$X, y= as.numeric(.data$cv), lty = 1)) +
    labs(x= x_label, y= y_label) +
    facet_wrap(~factor(as.factor(model), levels= unique(model)))
  print(p)
}

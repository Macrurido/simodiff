#' Bootlier
#'
#' Bootlier plot
#'
#' The Bootlier() function assesses the resampling performance of the L50
#' estimates and produces a frequency histogram known as a Bootlier plot. This
#' analysis helps identify any lack of precision in this parameter (Singh and Xie, 2003).
#'
#'  A vertical line on the plot marks the L50 value of the original data.
#'  The value for each model are stored in a data frame.
#'
#' @param df      A data frame containing estimated L50 values for each resampled dataset across all models.
#' @param Imin    A numerical value of the shortest range of L50 for all models.
#' @param Imax    A numerical value of the longest range of L50 for all models.
#' @param bin     A numeric value that represents the amplitude of the class interval.
#' @param opt A data frame for vertical lines contains the estimated values from the original data.
#' @param x_label A character vector with the label for the X-axis.
#' @param y_label A character vector with the label for the y-axis.
#'
#' @returns
#' A frequency histogram of L50 values estimated from resampling data is provided.
#' The evaluated models are displayed in separate multi-panels. The corresponding
#' L50 value estimated from the original data is shown by a vertical dashed line.
#'
#' @import ggplot2
#'
#' @examples
#' \dontrun{
#'
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
#' # auxiliary data frame for vertical lines
#' opt_val <- data.frame(Factor= c(sample_1,sample_2),
#'                       threshold=as.numeric(DF_L50[10,-15]))
#'
#'# Labels
#' x_label <- expression(italic(L[50]))
#' y_label <- "Frequency"
#'
#' p <- Bootlier(df, Imin, Imax, bin, opt=opt_val, x_label, y_label)
#'
#' }
#'
#' @export
Bootlier <- function(df, Imin, Imax, bin,
                     opt, x_label, y_label){

  p <- ggplot(df,aes(x= .data$value))+
    geom_histogram(breaks = seq(Imin, Imax, by = bin)) +
    labs(x = x_label,
         y = y_label) +
    geom_vline(data= opt, aes(xintercept= .data$threshold),
               colour="salmon", linetype = "dashed") +
    facet_wrap(~factor(Factor, levels= unique(Factor)))
}


#' @references
#' Singh, K., Xie, M., 2003. Bootlier-plot: bootstrap based outlier detection plot.
#'  Sankhya: Indian J. Stat. 65 (3), 532–559.
#
# auxiliary data frame for vertical lines
#https://stackoverflow.com/questions/40350230/variable-hline-in-ggplot-with-facet


#' model_bars
#'
#' This function provides a graphical comparison of the optimal value of L50,
#' represented by a black circle, along with its non-parametric confidence
#' interval indicated by whiskers for various models. The models are organized
#' based on their asymmetry attribute, ranging from right-biased to left-biased.
#' The average **AvM** model is positioned on the far right of the x-axis.

#'
#' @param df      A data frame that includes the original value of L50 and its non-parametric confidence interval by model.
#' @param order_vector A vector defines the arrangement of models along the x-axis.
#' @param x_label A character vector with the label for the X-axis.
#' @param y_label A character vector with the label for the Y-axis.
#'
#' @returns
#' A comparison of L50 among models is presented using an error bar plot,
#' along with their non-parametric confidence intervals.
#'
#' @import ggplot2
#'
#' @examples
#'\dontrun{
#'# The value for the example data frame has been defined.
#' Sex <- 	rep("Female", 6)
#' L50 <- 	  c(34.45,	37.42,	37.94,	40.68,	39.02,	38.52)
#' IC_low <- 	c(32.94,	36.03,	36.69,	39.36,	37.61,	37.25)
#' IC_upp <- 	c(35.01,	38.05,	38.54,	41.46,	39.6,	  39.16)
#'
#' df <- 	rbind(Sex, L50,IC_low, IC_upp)
#' colnames(df) <- c("GoM", "HiM", "LoM", "WeM", "GaM", "AvM")
#'
#' # This vector determines the the arrangement of models along the x-axis
#' order_vector <- c(seq(1:3),5,4,6)
#'
#' # The example labels have been created.
#' x_label <- "Models"
#' y_label <- expression(italic(L[50]))
#'
#' # The plot is generated using the model_bars() function.
#'p <- model_bars(df, order_vector, x_label, y_label)
#'}
#'
#'
#' @export
model_bars <- function(df, order_vector, x_label, y_label){
  # Reorder the 'category' factor based on 'order_vector'
  df$Model <- factor(df$Model,
                     levels = df$Model[order(order_vector)])
  # Creating the plot design.
  p <- ggplot(df, aes(x= .data$Model,
                      y=as.numeric(.data$L50), color=.data$Sex)) +
    geom_errorbar(aes(ymin = as.numeric(.data$IC_low),
                      ymax = as.numeric(.data$IC_upp)),
                  position= position_dodge(width=0.8),
                  color = "black") +
    geom_point(aes(shape=.data$Sex),size= 2,
               position= position_dodge(width=0.8),
               color = "black") +
    scale_shape_manual(values=c(16,15,17))+
    xlab(x_label) +
    ylab(y_label)
}

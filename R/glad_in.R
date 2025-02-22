#' glad_in
#'
#' An interactive process to visually determine the initial parameters.
#'
#' The `glad_in()` function is a nested function within the `glad()` function.
#' It conducts an interactive routine to determine the initial parameter values
#' that will be utilized later by the `optim()` optimizer for a specific model.
#'
#' **_NOTE:_** The `glad_in()` function must be executed in the console; when
#' run from RMarkdown, the prompt appears, but the figure does not.
#'
#' An iterative process is performed to visually estimate the values of the model's
#' parameters. This procedure can be repeated until the user is satisfied with
#' the input values of the analyzed model's parameters.
#'
#' The start values of the parameters are stored in the `prm` list, outside of
#' this function.
#'
#' The parameters values are adjusted visually by using a plot, aiming to find a
#' suitable starting value. If the user is satisfied with the values, they are
#' stored in the list `prm[[i]]`; otherwise, the loop is repeated until the user
#' is content with the approximations.
#'
#' The plot of the observed and predicted data using a sigmoidal model is
#' displayed in a separate window. The estimated value `y_hat` (solid line),
#' is calculated based on the chosen model and the respective initial or revised
#' values of the parameters: `y_hat <- models[[i]](prm[[i]],x)`.
#'
#' The console prompts you with the question: **Are you happy with the model values? 1=Yes, 0= No**
#' If you choose 1, it means "yes," and if you choose 0, it means "no."
#' Type the appropriate number and press Enter.
#'
#' If you are visually satisfied with the adjusted parameters, type 1 to end the
#'  repeat loop.
#'
#' If you type 0, you will need to provide the new values for parameters b1 and b2.
#' Enter the new value for b1 and press Enter, then do the same for b2. If you
#' accidentally press Enter, a warning pop-up will appear, informing you to enter
#'  a numerical value.
#'
#' After entering the new values for b1 and b2, the loop will repeat, displaying
#' the graph with the updated parameters and asking you to confirm if you are
#' satisfied with the new values.
#'
#' **WARNING:** The `glad_in()` function must be executed in the console;
#'  when run from RMarkdown, the prompt appears, but the figure does not.
#'
#'
#' @param i       An integer that specifies which model will be analyzed.
#' @param models  A list that contains the functions of the models.
#' @param prm     A list that contains the parameters values for each model.
#' @param df      A data frame with the x (class mark), y (proportion) and an empty column y_hat filled with NA
#' @param x       A numeric vector of the ith class interval.
#' @param x_label A character vector with the label for the X-axis.
#' @param y_label A character vector with the label for the y-axis.
#'
#' @returns a list with the new parameter values.
#'
#' @seealso Package ggplot2 version 3.5.1
#' @seealso splot function from simodiff package.
#'
#' @import ggplot2
#' @import tidyverse
#' @importFrom grDevices dev.set
#' @importFrom svDialogs dlgInput
#'
#' @examples
#' \dontrun{
#' i <- 1
#'
#' models <- list(LoM= simodiff::LoM)
#' prm <- list(c("b1"=38,"b2"=8))
#'
#' x <- seq(16.25,66.25, by=2.5)
#' y <- c(0.06, 0.00, 0.01, 0.01, 0.08, 0.04, 0.04,
#'        0.06, 0.58, 0.42, 0.69, 0.80, 1.00, 0.83,
#'        1.00, 1.00, 1.00, 1.00, 1.00,  NaN, 1.00)
#'
#' df <- cbind(x, y)
#' df <- as.data.frame(df)
#'
#' x_label <- "Class mark (cm)"
#' y_label <- "Proportion"
#'
#' prm <- glad(models, prm, df, x_label, y_label)
#' }
#'
#' @export
#'
glad_in <- function(i, models, prm, df, x, x_label, y_label){
  m_name <- names(models)[[i]]
  model <- models[[i]]
  betas <- prm[[i]]
  repeat{
    #betas <- as.list(betas)
    df$y_hat <- model(betas,x)
    df[] <- lapply(df, as.numeric)
    p <- splot(df, x_label, y_label) # Plot: Visual Inspection
    p <- p+ ggtitle(paste0(m_name," b1=",betas[1]," b2=",betas[2]))
    dev.set(5)
    print(p)
    user_input <-dlgInput(paste0("Are you happy with the values for ", m_name, "?  1=Yes, 0= No "), Sys.info()[" "])$res
    # If input is not NA and greater than 0 next i
    if (!is.na(user_input) && user_input >0) {
      cat("The parameter values for ", m_name, " are:\n")
      print(betas)
      break
    }else{
      betas[1] <- dlgInput(paste0("b1=",betas[1]," Please specify new values for b1"), Sys.info()[" "])$res
      betas[2] <- dlgInput(paste0("b2=",betas[2]," Please specify new values for b2"), Sys.info()[""])$res
      betas <- as.numeric(betas)
    }
  }
  return(betas)
}

#' fit_models
#'
#' Fitting model for every database
#'
#' All sigmoid models are fitted using the `optim()` function for each data set.
#' Each model is evaluated with the `nllb()` function, which calculates the
#' negative log-likelihood for the residuals under the assumption of a binomial
#' distribution.
#'
#' For more details about the models, see the information about the functions
#' included in the simodiff package: GoM(), HiM(), LoM(), WeM() and GaM().
#'
#' The negative logarithmic likelihood function will be minimized using the
#' "optim()" function. For more details see optim() function.
#'
#' Within a function, an empty list named 'l_models' is created to hold the
#' summaries of each fit.
#'
#' @param models A list that stores the functions of selected models for fitting a   cumulative density function.
#' @param prm    A list that contains the parameter values b1 and b2 of the selected model.
#' @param lista  A list where the first item contains the original data, and items 2 to B+1 contain the resampled data frames.
#' @param B      An integer that determines the number of resamplings.
#' @param nLL    The negative logarithmic likelihood function will be   minimized using the "optim()" function.
#'
#' @returns
#' The function returns a list containing the stored summaries.
#'
#' @importFrom stats optim
#' @importFrom stats na.omit
#'
#' @examples
#' \dontrun{
#' set.seed(16)
#' df <- Lperu
#' df <- df[-1]    # Sex column removed
#'
#' Imin <- (trunc(min(df$Length)/5))*5
#' Imax <- (ceiling(max(df$Length)/5))*5
#' bin <- 5
#'
#' B <- 3
#' n <- dim(df)[1]
#'
#' f_resample <- simodiff::resample(models, prm, lista, B, nLL)
#' f_resample
#'
#' models <- list(GoM=simodiff::GoM, HiM=simodiff::HiM,
#'                LoM=simodiff::LoM, WeM=simodiff::WeM,
#'                GaM=simodiff::GaM)
#'
#' prm <- list(GoM=c("b1"=38,"b2"=0.1), HiM=c("b1"=38,"b2"=10),
#'             LoM=c("b1"=38,"b2"=5), WeM=c("b1"=38,"b2"=6),
#'             GaM=c("b1"=21,"b2"=1.8))
#'
#'  # The function simodiff::nllb() calculates the negative log-likelihood for
#'  # a binomial distribution.
#'
#' fits <- fit_models(models, prm, lista=f_resample,
#'                    B, nLL= simodiff::nllb)
#' fits
#' }
#'
#' @export
fit_models <- function(models, prm, lista, B, nLL){
  # The list includes the original and de B resampled data sets.
  B <- B+1
  # Create an empty list to store the model summaries.
  names_M <- names(models)
  l_models <- sapply(names_M, function(x) NULL)
  # Nested for loop to fit the ith model for jth data set.
  for(i in 1:length(models)){
    model <- unlist(models[[i]])
    betas <- unlist(prm[[i]])
    for(j in 1:B) {
      df <- na.omit(lista[[j]])
      l_models[[i]][[j]] <- optim(par= betas, fn= nLL, df= df,model= model)
    }
  }
  return(l_models)
}

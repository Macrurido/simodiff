#' nllb
#'
#' The function calculates the negative log-likelihood for a binomial
#' distribution of residuals.
#'
#' The log-likelihood function, denoted as nllb, computes the fitted value y_hat
#' for the ith selected model and returns the binomial negative log-likelihood value.
#'
#' The models included here had the same statistical assumption regarding the errors.
#' Each model was fit to the data, minimizing the negative value of the log-likelihood
#' function by using a binomial density probabilistic function (Aguirre-Villaseñor
#' et al., 2022).
#'
#' @param prm    A list that contains the parameter values b1 and b2 of the selected model.
#' @param df     A data frame, it should be organized as follows:
#'                 class mark (MC) in column 1; total number of the sample (ni)
#'                 in column 2; and number of mature organisms (mi) in column 3.
#' @param model A list that stores the functions of selected models for fitting a cumulative density function.

#'
#' @returns The binomial negative log-likelihood value.
#'
#' @examples
#' \dontrun{
#' x <- seq(11.25,78.75,by=2.5)
#' ni <- c(0,0,33,46,140,155,128,57,50,31,53,38,16,10,23,12,42,23,38,14,6,0,1,0,0,0,0,0)
#' mi <- c(0,0,2,0,1,2,10,2,2,2,31,16,11,8,23,10,42,23,38,14,6,0,1,0,0,0,0,0)
#' fo <- mi/ni
#' data <- cbind(x,ni,mi,fo)
#' data <- as.data.frame(data)
#'
#' models <- models <- list(GoM=simodiff::GoM, HiM=simodiff::HiM,
#'                          LoM=simodiff::LoM, WeM=simodiff::WeM,
#'                          GaM=simodiff::GaM)
#'
#' prm <- list(GoM=c("b1"=38,"b2"=0.1), HiM=c("b1"=38,"b2"=10),
#'             LoM=c("b1"=38,"b2"=5), WeM=c("b1"=38,"b2"=6),
#'             GaM=c("b1"=21,"b2"=1.8))
#'
#' out <- rep(NA,length(models))
#'
#'for(i in 1:length(models)){
#'  model <- unlist(models[[i]])
#'  betas <- unlist(prm[[i]])
#'  out[i] <- nllb(prm=betas, df=data, model)
#'}
#' out
#' }
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr filter
#'
#' @export
nllb <- function(prm, df, model){
  # Remove Zero Values
  data <- df %>% dplyr::filter(df[,2] > 0 & df[,3] > 0)
  data <- as.data.frame(data)
  x <- data[,1]
  ni <- data[,2]
  mi <- data[,3]
  y_hat <- model(prm,x)
  # log Binomial coefficients
  lbc<- log(gamma(ni+1))-(log(gamma(ni-mi+1))+log(gamma(mi+1)))
  # Ratio test
  nll <-  -sum(mi*log(y_hat/(1-y_hat))+(ni*log(1-y_hat))+lbc)
  # Return binomial negative log-likelihood
  return(nll)
}

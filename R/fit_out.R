#' fit_out
#'
#' The dataset 'fit_out' contains a summary of results obtained from the 'optim()'
#' function for five tested models: Gompertz (GoM), Hill (HiM), Logistic (LoM),
#' Weibull (WeM) and Gamma (GaM). This is a nested list containing five lists, each
#' representing a model, and each of these lists includes the fitting results in
#' the form of a list. For detailed information about the items, please refer to
#' the help section of the optim() function.
#'
#' @format A list of five:
#' \describe{
#'   \item{par}{The best set of parameters found}
#'   \item{value}{negative log likelihood value}
#'   \item{counts}{A two-element integer vector giving the number of calls to **fn** and **gr** respectively.}
#'   \item{convergence}{An integer code. 0 indicates successful completion, a different number may indicate a potential code error}
#'   \item{message}{A character string giving any additional information returned by the optimizer, or NULL}
#' }
#'
#' @docType data
#' @keywords datasets
#' @name fit_out
#' @usage data(fit_out)
#' @format A list of five
#' @source <https://github.com/Macrurido/simodiff/blob/master/data/fit_out.rda>
"fit_out"

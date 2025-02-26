#' MMI
#'
#' Multi Model Inference
#'
#' To perform multi-model inference (Burnham & Anderson, 2002), the function
#' `MMI()` is created. A for loop will be used to store the necessary values in
#' the data frame `DF_MMI`, which is sized according to `MMI_row` and the number
#' of candidate models. The acronyms for each candidate model are found in the
#' vector `m_labels`.
#'
#' The required values will be stored in the 'DF_MMI' data frame, with dimensions
#' defined by `MMI_row` and the number of candidate models. The acronym for each
#' candidate model is found in the 'm_labels' vector.
#'
#' Within the function, the Akaike Information Criterion with small-sample
#' correction AICc (Akpa & Unuabonah, 2011), delta AICc, and the weight of
#' each model are calculated.
#'
#' A data frame has been created to store the results of the analysis. The number
#' of rows in the data frame will correspond to the number of models being tested.
#' In contrast, the number of columns will remain fixed at nine: "Sex",	"Model",
#' "n",	"k", "LL", "AICc", "Delta", "exp(-0.5Di)" and	"Wi".
#'
#' @param lista A list with a summary of the fitting results.
#' @param sex   A character value that indicates the sex of the organisms.
#' @param n     An integer value represents the number of organisms present in the sample.
#'
#' @returns
#' The function outputs a data frame containing the results.
#'
#'@references
#'
#' Burnham, K. P. and Anderson, D. R. 2002 Model selection and multimodel inference:
#' a practical information-theoretic approach. 2nd ed. New York, Springer-Verlag.
#'
#' Akpa, O. M., & Unuabonah, E. I. (2011). Small-sample corrected Akaike information
#' criterion: an appropriate statistical tool for ranking of adsorption isotherm
#' models. Desalination, 272(1-3), 20-26.
#'
#' @examples
#'
#' # An example of the results summary obtained using the 'optim()' function is
#' # stored in the file 'fit_out.rmd'; this data is referenced in the current
#' # example and is contained in the object 'lista'. This list includes the negative
#' # log-likelihood value, `value`, and the number of parameters, `par`, for five
#' # candidates models. The sex vector, labeled `sex`, contains the factor levels;
#' # in this case, it includes only **Females**. The variable `n` represents the
#' # number of organisms present in the sample.
#'
#' # **Note:** To ensure the 'simodiff::MMI()' function operates correctly without
#' # errors, each list must be named with its corresponding model name. If the
#' # list does not include them, you need to provide their names.
#'
#' \dontrun{
#' lista <- fit_out
#' names(lista) <- c("GoM", "HiM", "LoM", "WeM", "GaM") #Naming the items list
#' sex <- "Female"
#' n <- 700
#'
#' MMI_out <- MMI(lista, sex, n)
#' MMI_out
#'
#'}
#'
#' @export
MMI <- function(lista, sex, n){
  # An empty data frame will be created to store the results.
  MMI_row <- c("Sex",	"Model", "n",	"k", "LL", "AICc", "Delta",
               "exp(-0.5Di)",	"Wi")
  n_models <- length(names(lista))
  DF_MMI <- data.frame(matrix(NA, nrow= n_models*length(sex),
                              ncol=length(MMI_row)))
  colnames(DF_MMI) <- MMI_row
  for(j in 1:length(sex)) {
    DF_MMI[,2] <- names(lista)
    for(i in 1:n_models){
      DF_MMI[i*j,1] <- sex[j]
      DF_MMI[i*j,3] <- n
      DF_MMI[i*j,4] <- length(unlist(lista[[i]]["par"]))
      DF_MMI[i*j,5] <- lista[[i]]["value"]
      DF_MMI[i*j,6] <- (2 * DF_MMI[i,5] + 2 * DF_MMI[i,4]) +
        2*DF_MMI[i,5] + (DF_MMI[i,5]+1)/
        (DF_MMI[i*j,3]-DF_MMI[i*j,4]-1)
      if(i== n_models){
        DF_MMI[,7] <- abs(min(DF_MMI[,6])-DF_MMI[,6])
        DF_MMI[,8] <- exp(-0.5*DF_MMI[,7])
        DF_MMI[,9] <- DF_MMI[,8]*100
      }
    }
  }
  return(DF_MMI)
}

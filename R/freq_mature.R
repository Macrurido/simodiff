#' freq_mature
#'
#' The function calculates the absolute frequency of the total number of
#' organisms **x_total** and the organisms active during reproduction by class
#' interval **x_active**.
#'
#' It provides a data frame contains four variables (columns): the class mark `CM`,
#' the absolute frequency of the total number of organisms `ni`, the  number of
#' organisms active during reproduction `mi`, and the proportions of reproductive
#' active organisms in each length class.
#'
#'
#'  This function utilizes the `fn_freq()` function from the `Repbio` package.
#'
#' @source <https://github.com/Macrurido/Repbio.git>
#'
#' @param x_total  A numeric vector of the length of total of organisms in the sample
#' @param x_active A numeric vector of the length of reproductive active organisms
#' @param Imin     A numeric value of the shortest organism.
#' @param Imax     A numeric value of the longest organism.
#' @param bin      A numeric value that represents the amplitude of the class interval.
#'
#' @returns A data frame with the frequencies and proportions of a binomial
#'          variable expressed as a fraction of n; for example, the proportion
#'          of active organisms to the total number of organisms in the ith class interval.
#'
#' @seealso fn_freq() from the `Repbio` package
#'
#' @importFrom Repbio fn_freq
#'
#' @examples
#' \dontrun{
#' freq_mature <- freq_mature(x_total, x_active, Imin, Imax, bin)
#' }
#'
#' @export
freq_mature <- function(x_total, x_active, Imin, Imax, bin){
                        ni <- Repbio::fn_freq(x_total,Imin,Imax,bin)
                        mi <- Repbio::fn_freq(x_active,Imin,Imax,bin)
               # Proportion reproductive active organisms
                        P_act <- mi[,2]/ni[,2]
                        f_tmp <- cbind(CM= ni[,1],
                                       ni= ni[,2],
                                       mi= mi[,2],
                                       P_act)
                        f_tmp <- as.data.frame(f_tmp)
                        return(f_tmp)
}

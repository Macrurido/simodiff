#' resample
#'
#' This function resamples the organisms in the data frame `df`, which includes
#' the `Length` and `Binomial` columns, indicating whether each organism is
#' inactive (0) or active in reproduction (1).
#'
#' The frequency of mature organisms to the total number of organisms is calculated
#' for each class mark using the `simodiff::freq_mature` function.
#'
#' The results are stored in a list, with the first item representing the
#' original data frequencies. The variable `B` defines the number of
#' resamplings to be performed.
#'
#' @param df   A data frame showing the length and binomial condition indicating
#'               whether organisms are inactive (0) or actively reproducing (1).
#' @param B    An integer that determines the number of resamplings.
#' @param n    An integer that indicates the number of rows to be included in the
#'             resampled data frame.
#' @param Imin A numeric value of the shortest organism.
#' @param Imax A numeric value of the longest organism.
#' @param bin  A numeric value that represents the amplitude of the class interval.
#'
#' @returns  The function outputs a list where the first item contains the original
#'            data, and items 2 to B+1 contain the resampled data frames, with B
#'            representing the number of resamplings.
#'
#'  @seealso freq_mature() from simodiff package
#'
#' @importFrom dplyr sample_n
#' @importFrom simodiff freq_mature
#'
#' @examples
#' \dontrun{
#' set.seed(16)
#'
#' df <- load("data/Lperu.rda")
#' df <- df[-1]
#'
#' Imin <- (trunc(min(df$Length)/5))*5
#' Imax <- (ceiling(max(df$Length)/5))*5
#' bin <- 5
#'
#' B <- 3
#' n <- dim(df)[1]
#'
#' f_resample <- resample(df, B, n, Imin, Imax, bin)
#' f_resample
#'}
#'
#' @export
resample <- function(df, B, n, Imin, Imax, bin){
                          r_list <- vector("list", length = B+1)
                    for(i in 1:(B+1)){
                      if(i==1){
                          r_data <- df
                      }else{
                          r_data <- dplyr::sample_n(df, n,replace = T)
                      }
                          x_total <- r_data[,1]
                          tmp <- r_data[r_data[,2] == 1,]
                          x_active <- tmp[,1]
                          r_list[[i]] <- simodiff::freq_mature(x_total, x_active,
                                                              Imin, Imax, bin)
                    }
                          return(r_list)
}

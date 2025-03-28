% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MMI.R
\name{MMI}
\alias{MMI}
\title{MMI}
\usage{
MMI(lista, sex, n)
}
\arguments{
\item{lista}{A list with a summary of the fitting results.}

\item{sex}{A character value that indicates the sex of the organisms.}

\item{n}{An integer value represents the number of organisms present in the sample.}
}
\value{
The function outputs a data frame containing the results.
}
\description{
Multi Model Inference
}
\details{
To perform multi-model inference (Burnham & Anderson, 2002), the function
\code{MMI()} is created. A for loop will be used to store the necessary values in
the data frame \code{DF_MMI}, which is sized according to \code{MMI_row} and the number
of candidate models. The acronyms for each candidate model are found in the
vector \code{m_labels}.

The required values will be stored in the 'DF_MMI' data frame, with dimensions
defined by \code{MMI_row} and the number of candidate models. The acronym for each
candidate model is found in the 'm_labels' vector.

Within the function, the Akaike Information Criterion with small-sample
correction AICc (Akpa & Unuabonah, 2011), delta AICc, and the weight of
each model are calculated.

A data frame has been created to store the results of the analysis. The number
of rows in the data frame will correspond to the number of models being tested.
In contrast, the number of columns will remain fixed at nine: "Sex",	"Model",
"n",	"k", "LL", "AICc", "Delta", "exp(-0.5Di)" and	"Wi".
}
\examples{

# An example of the results summary obtained using the 'optim()' function is
# stored in the file 'fit_out.rmd'; this data is referenced in the current
# example and is contained in the object 'lista'. This list includes the negative
# log-likelihood value, `value`, and the number of parameters, `par`, for five
# candidates models. The sex vector, labeled `sex`, contains the factor levels;
# in this case, it includes only **Females**. The variable `n` represents the
# number of organisms present in the sample.

# **Note:** To ensure the 'simodiff::MMI()' function operates correctly without
# errors, each list must be named with its corresponding model name. If the
# list does not include them, you need to provide their names.

\dontrun{
lista <- fit_out
names(lista) <- c("GoM", "HiM", "LoM", "WeM", "GaM") #Naming the items list
sex <- "Female"
n <- 700

MMI_out <- MMI(lista, sex, n)
MMI_out

}

}
\references{
Burnham, K. P. and Anderson, D. R. 2002 Model selection and multimodel inference:
a practical information-theoretic approach. 2nd ed. New York, Springer-Verlag.

Akpa, O. M., & Unuabonah, E. I. (2011). Small-sample corrected Akaike information
criterion: an appropriate statistical tool for ranking of adsorption isotherm
models. Desalination, 272(1-3), 20-26.
}

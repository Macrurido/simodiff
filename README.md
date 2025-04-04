simodiff: Sigmoidal models with different functional forms to estimate
length at 50% maturity
<img src=https://github.com/Macrurido/simodiff/blob/master/man/figures/simodiff.png align='right' height='20%' width='20%'/>
================
04 abril 2025

- [simodiff](#simodiff)
  - [Installation](#installation)
  - [Package function](#package-function)
    - [General functions](#general-functions)
    - [Model functions](#model-functions)
  - [More details](#more-details)
  - [Example](#example)
  - [References](#references)

Shield: [![CC BY
4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by/4.0/)

simodiff © 2024 by Hugo Aguirre Villaseñor is licensed under a [Creative
Commons Attribution 4.0 International
License](http://creativecommons.org/licenses/by/4.0/).

[![CC BY
4.0](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/)

# simodiff

<!-- badges: start -->

![simodiff](https://github.com/Macrurido/simodiff/blob/master/man/figures/simodiff.png)
<!-- badges: end -->

The goal of simodiff is to evaluates the performance of different
sigmoidal models with different functional forms.

The simodiff package: **Sigmoidal models with different functional forms
to estimate length at 50% maturity** is a methodological package
developed to carry out the analyzes of the article: Aguirre-Villaseñor
*et al.* (2022).

To estimate mean size at sexual maturity $\left( L_{50} \right)$, a
particular model is usually selected arbitrarily, and this decision does
not consider the functional form (**FF**) of both the model (**FFM**)
and the observed data (**FFD**).

This package evaluates the performance of different sigmoidal models
using data sources with different functional forms (FF). Five sigmoidal
models—Gompertz (GoM), logistic (LoM), Hill (HiM), Weibull (WeM), and
gamma (GaM)—were used to illustrate this.

To avoid redundancy, the models were chosen based on specific
statistical properties. These included having common parameters
$\left( L_{50} \right)$, the same number of parameters (2),being
non-nested, representing different functional forms (both symmetric and
asymmetric):

    i) two symmetrical models described by the Logistic model `LoM` and Hill model `HiM`;
    ii) an asymmetric right-skewed expressed by the Gompertz model `GoM`;
    iii) an asymmetric left-skewed defined by the Weibull model `WeM`;
    iv) a general model, which depends on its shape parameter described by the Gamma model `GaM`.

And having an asymptotic maturity equal to 1. The
$\left( L_{50} \right)$ value must be calculated using the fitted
parameters only for gamma (GaM):

Each model was fit to minimize the negative log-likelihood by using a
binomial probabilistic density function. Additionally, Bias-corrected
non-parametric confidence intervals (CI) were estimated for the
parameters and predictions.

Finally, the model average (AvM) and its confidence intervals were
calculated using a multi-model inference approach.

For this purpose, some functions and a vignette were created to explain
the process step by step. The tables and figures were personalized.

## Installation

You can install the development version of simodiff from
[GitHub](https://github.com/Macrurido/simodiff.git) with:

``` r
# install.packages("pak")
pak::pak("Macrurido/simodiff")
```

## Package function

To illustrate how the package functions, we utilize a data set that
includes the length, sex, and reproductive condition of the red snapper
(*Lutjanus peru*) collected from the Eastern Central Pacific. In this
data set, the reproductive condition is categorized as follows: 0
indicates an immature or inactive mature organism, while 1 denotes an
actively mature organism (Aguirre-Villaseñor *et al*., 2022).

The package consists of <font color="red">NN</font> functions that
facilitate the implementation of the methodology used in this analysis:

### General functions

`Bootlier()` The function assesses the resampling performance of the L50
estimates and produces a frequency histogram known as a Bootlier plot.
This analysis helps identify any lack of precision in this parameter
(Singh and Xie, 2003).

`cv_plot()`Plot of cumulative coefficient of variation.

The efficiency of the resamples in the bootstrap simulations was
analyzed graphically using the number of resamples *versus* the
coefficient of variation *CV*. The *CV* was calculated for the
cumulative resamples of each model, with the cumulative values
increasing after every *ni* data point.

`freq_mature()` The function calculates the absolute frequency of the
total number of organisms **x_total** and the organisms active during
reproduction by class interval **x_active**.

It provides a data frame contains four variables (columns): the class
mark `CM`, the absolute frequency of the total number of organisms `ni`,
the number of organisms active during reproduction `mi`, and the
proportions of reproductive active organisms in each length class.

`glad()` Graphical approximation of initial values. The initial values
of the parameters are determined graphically using the this function.
The start values of the parameters are stored in the `prm` list, outside
of this function.

The parameters values are adjusted visually by using a plot, aiming to
find a suitable starting value. If the user is satisfied with the
values, they are stored in the list `prm[[i]]` and the next model
continues; otherwise, the loop is repeated until the user is content
with the approximations.

The plot of the observed and predicted data using a sigmoidal model is
displayed in a separate window. The estimated value `y_hat` (solid
line), is calculated based on the chosen model and the respective
initial or revised values of the parameters:
`y_hat <- models[[i]](prm[[i]],x)`.

<figure>
<img
src="https://github.com/Macrurido/simodiff/blob/master/man/figures/glad_plot.png"
alt="glad_plot" />
<figcaption aria-hidden="true">glad_plot</figcaption>
</figure>

The console prompts you with the question: **Are you happy with the
model values? 1=Yes, 0= No** If you choose 1, it means “yes,” and if you
choose 0, it means “no.” Type the appropriate number and press Enter.

<figure>
<img
src="https://github.com/Macrurido/simodiff/blob/master/man/figures/glad.png"
alt="glad" />
<figcaption aria-hidden="true">glad</figcaption>
</figure>

<div style="padding: 15px; border: 1px solid transparent; border-color: transparent; margin-bottom: 20px; border-radius: 4px; color: #31708f; background-color: #d9edf7; border-color: #bce8f1;">

**NOTE:** The model and the values of parameters b1 and b2 are presented
in the console prompt and figure.

</div>

If you type 0, you will need to provide the new values for parameters b1
and b2. Enter the new value for b1 and press Enter, then do the same for
b2.

If you accidentally press Enter, a warning pop-up will appear, informing
you to enter a numerical value.

<div style="padding: 15px; border: 1px solid transparent; border-color: transparent; margin-bottom: 20px; border-radius: 4px; color: #31708f; background-color: #d9edf7; border-color: #bce8f1;">

**IMPORTANT!** The `glad_in()` function must be executed in the console;
when run from RMarkdown, the prompt appears, but the figure does not.

</div>

`model_bars()` This function provides a graphical comparison of the
optimal value of L50, represented by a black circle, along with its
non-parametric confidence interval indicated by whiskers for various
models. The models are organized based on their asymmetry attribute,
ranging from right-biased to left-biased. The average **AvM** model is
positioned on the far right of the x-axis.

`nllb()` The function calculates the negative log-likelihood for a
binomial distribution of residuals.

The log-likelihood function, denoted as nllb, computes the fitted value
y_hat for the ith selected model and returns the binomial negative
log-likelihood value.

The models included here had the same statistical assumption regarding
the errors. Each model was fit to the data, minimizing the negative
value of the log-likelihood function by using a binomial density
probabilistic function (Aguirre-Villaseñor et al., 2022).

`resample()` This function resamples the organisms in the data frame
`df`, which includes the `Length` and `Binomial` columns, indicating
whether each organism is inactive (0) or active in reproduction (1).

The frequency of mature organisms to the total number of organisms is
calculated for each class mark using the `simodiff::freq_mature`
function.

The results are stored in a list, with the first item representing the
original data frequencies. The variable `B` defines the number of
resamplings to be performed.

`splot()` Plot of observed and predicted data using sigmoidal model. The
function utilizes ggplot2 to create a scatterplot that displays class
marks against the relative frequency of active organisms in relation to
reproduction (points) in a binomial distribution. The estimated value
**y_hat** (solid line), is calculated based on the chosen model.

where: the candidate model function was defined and stored in the
`models` list; the starting parameters values was defined and stored in
the `prm` list; and the `x` represents the independent variable.

To use this function, a data frame named `df` is required. This data
frame should include the class mark values **x**, the corresponding
relative frequencies **y**, and the estimated values of the independent
variable **y_hat**.

The labels for the X and Y axes were defined in `x_label` and `y_label`,
respectively.

Due to potential **Na** values, a warning may appear indicating that
rows with missing values or values outside the scale range have been
removed.

### Model functions

For all models, the variables and parameters are defined in the
following manner:

    `y` is a vector of binomial response: inactive to reproduction (0) or active to reproduction (1).
    `x` is a vector of fish total length
    `b1` is the length at 50% maturity (l50) defined as the point of inflection of the curve
    `b2` is directly related to the width of the interval, whereas `b1` influences the shape of the curve in the Weibull model. In Gamma, `b1` (alpha) influences the shape of the curve and `b2` (beta) influences the width of the interval.

The attributes for each model function are: *prm* refers to the model’s
parameters, while *x* represents the independent variable.

`GoM()` The Gompertz model function was implemented to find the value of
the cumulative density function of a Gompertz distribution with certain
shape **b1** and rate parameters **b2**.

$$p_{i}=e^{e^{-b_{2}*(x_{i}-b_{1})}}$$

Where:

$p_{i}$ represents a binomial variable expressed as a fraction of n; for
example, the proportion of active organisms to the total number of
organisms in the ith class interval.

$b_{1}$ is the point of inflection of the curve.

$b_{2}$ is related directly to the width of the interval.

$e$ is the base of the natural logarithm (2.71828…)

`HiM()` The Hill model function was implemented to find the value of the
cumulative density function of a Hill distribution with certain shape
**b1** and rate parameters **b2**.

$$p_{i}= \frac{1}{1+^{\left( \frac{b_{1}}{x_{i}} \right)^{b_{2}}}}$$

Where:

$p_{i}$ represents a binomial variable expressed as a fraction of n; for
example, the proportion of active organisms to the total number of
organisms in the ith class interval.

$b_{1}$ is the point of inflection of the curve.

$b_{2}$ is related directly to the width of the interval.

`LoM()` The Logistic model function was implemented to find the value of
the cumulative density function of a Logistic distribution with certain
shape **b1** and rate parameters **b2**.

$$p_{i}= \frac{1}{1+e^{-\left(\frac{x_{i}-b_{1}}{b_{2}} \right)}}$$

Where: $p_{i}$ represents a binomial variable expressed as a fraction of
n; for example, the proportion of active organisms to the total number
of organisms in the ith class interval.

$b_{1}$ is the point of inflection of the curve.

$b_{2}$ is related directly to the width of the interval.

`WeM()` The Weibull model function was implemented to find the value of
the cumulative density function of a Weibull distribution with certain
shape **b1** and rate parameters **b2**.

$$p_{i}=1-e^{-\left( \left(\frac{x_{i}}{b_{1}}\right)^{b_{2}} \right)}$$

Where: $p_{i}$ represents a binomial variable expressed as a fraction of
n; for example, the proportion of active organisms to the total number
of organisms in the ith class interval.

$b_{1}$ is the point of inflection of the curve.

$b_{2}$ influences the functional form of the curve.

`GaM()` The Gamma model function uses the `gamma()` function from the
`stats` package to find the value of the cumulative density function of
a gamma distribution with certain shape `b1` and rate parameters `b2`.

`b1` is a numerical value that affects the curve’s shape, while `b2` is
a numerical value directly related to the rate. Both are stored in the
`prm` list.

`prm` a list that stores the gamma model’s parameter values b1 and b2.
`x` is a numeric vector of fish total length.

It returns a numerical vector with the estimated values.

## More details

For more information, please refer to the respective vignettes, which
offer detailed descriptions of each function, its operations, and
examples.

## Example

To demonstrate how the package works, please follow the step-by-step
process outlined in the “simodiff_steps” vignette, which reconstructs
the results presented in the article by Aguirre-Villaseñor et
al. (2022).

## References

Aguirre-Villaseñor, H., Morales-Bojórquez, E., & Espino-Barr, E. (2022).
Implementation of sigmoidal models with different functional forms to
estimate length at 50% maturity: A case study of the Pacific red snapper
*Lutjanus peru*. Fisheries Research, 248, 106204.
<https://doi.org/10.1016/j.fishres.2021.106204>

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict.fast_multinom.R
\name{predict.fast_multinom}
\alias{predict.fast_multinom}
\title{Prediction method for fast_multinom fits}
\usage{
\method{predict}{fast_multinom}(object, newdata = NULL)
}
\arguments{
\item{object}{Object of class fast_multinom.}

\item{newdata}{Optionally, a data frame for which to predict.}
}
\description{
Obtains predictions from a multinomial model fitted using fast_multinom.
}
\details{
Only output on the level of probabilities are generated. This is equivalent to type="response" in a logistic regression model estimated with glm with family=binomial(link="logit").

Note that the factor levels and contrasts defined in the fast_multinom object are used. This allows to run prediction on a dataset with fewer levels and different contrasts (in this case, the contrasts are overwritten and there is a warning. There can be the same warning, when the contrasts are not changed -- I don't know why, it is issued by \code{\link[MatrixModels]{model.Matrix}}.)
}
\examples{

data(cancermutations)

# the APOBEC signature is only relevant for transitions and transversions to a G:C basepair -- construct the corresponding subset of parameters for the 3 binomial models:
subs = matrix(T, ncol=3, nrow=4)
subs[3,2] = F

# fit the multinomial model
fit = fast_multinom(cbind(NO, I, VA, VG) ~ strong + apobec + cancer_type, data = cancermutations, refLevel=1, VC=T, subsetmatrix=subs, predictions=T)

# predictions on the data that was used for fitting (only available, because predictions=T in the function fast_multinom):
head(predict.fast_multinom(fit))

# predict on new data (with fewer factor levels):
set.seed(123)
new = droplevels(cancermutations[sample.int(nrow(cancermutations), 5),])
pred = predict.fast_multinom(fit, new)


}
\references{
Bertl, J.; Guo, Q.; Rasmussen, M. J.; Besenbacher, S; Nielsen, M. M.; Hornshøj, H.; Pedersen, J. S. & Hobolth, A. A Site Specific Model And Analysis Of The Neutral Somatic Mutation Rate In Whole-Genome Cancer Data. bioRxiv, 2017. doi: https://doi.org/10.1101/122879 \url{http://www.biorxiv.org/content/early/2017/06/21/122879}
}
\author{
Johanna Bertl
}

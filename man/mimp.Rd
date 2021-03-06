% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/multiple_imputation.R
\name{mimp}
\alias{mimp}
\title{Multiple imputation for count data}
\usage{
mimp(x, to.impute, m)
}
\arguments{
\item{x}{data frame with ncols-1 categorical columns (do not need to be factors, but note that numeric vectors are handled as if they were categorical) and one column with counts, named "count".}

\item{to.impute}{character vector of names of the columns where the missing values should be imputed (if there are any, this is tested in the function)}

\item{m}{number of multiple imputations}
}
\value{
If there are no missing values in the specified columns, there is no output and the function throws a warning. Otherwise, a list of \code{m} complete data frames. Note that they have the same number of counts, but they will usually not have the same number of rows as the original data frame.
}
\description{
The function \code{mimp} produces multiply imputed datasets for categorical count data.
}
\details{
A count dataset consists of a set of categorical variables and a column of counts (named "count"). It is not necessary that each combination of categories is present in the dataset. The imputation is conducted for each variable independently by sampling from its empirical distribution function.

Functionalities from the package \code{\link{data.table}} are used to speed up computations.

There are sophisticated and flexible R packages for multiple imputation available. I wrote this function because the functions from package \code{cat}, e. g. \code{\link[cat]{em.cat}}, can't handle the large counts that we have in our dataset (it uses the integer class for communicating with an underlying Fortran function, so it can cause integer overflows) and the package \code{\link[mice]{mice}} doesn't support count data.
}
\examples{

# use a subset of the raw dataset that was installed along with the package:
location = system.file("extdata", "set0", package = "multinomutils")
count_table = fread(file=location) 
count_table = count_table[count_table$cancer_type \%in\% c("KICH", "LGG")]
count_table[,left:=NULL]
count_table[,right:=NULL]

# number of missing values per column of count_table
missing = apply(count_table, 2, FUN = function(x) sum(is.na(x)))
names(missing) = names(count_table)

# 3-fold multiple imputation
count_table_imp = mimp(x = count_table, to.impute = names(missing[missing>0]), m = 3)

}
\seealso{
\link[cat]{imp.cat}, \link[mice]{mice}
}
\author{
Johanna Bertl
}

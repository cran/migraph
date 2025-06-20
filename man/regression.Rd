% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_regression.R
\name{regression}
\alias{regression}
\alias{net_regression}
\title{Linear and logistic regression for network data}
\usage{
net_regression(
  formula,
  .data,
  method = c("qap", "qapy"),
  times = 1000,
  strategy = "sequential",
  verbose = FALSE
)
}
\arguments{
\item{formula}{A formula describing the relationship being tested.
Several additional terms are available to assist users investigate
the effects they are interested in. These include:
\itemize{
\item \code{ego()} constructs a matrix where the cells reflect the value of
a named nodal attribute for an edge's sending node
\item \code{alter()} constructs a matrix where the cells reflect the value of
a named nodal attribute for an edge's receiving node
\item \code{same()} constructs a matrix where a 1 reflects
if two nodes' attribute values are the same
\item \code{dist()} constructs a matrix where the cells reflect the
absolute difference between the attribute's values
for the sending and receiving nodes
\item \code{sim()} constructs a matrix where the cells reflect the
proportional similarity between the attribute's values
for the sending and receiving nodes
\item \code{tertius()} constructs a matrix where the cells reflect some
aggregate of an attribute associated with a node's other ties.
Currently "mean" and "sum" are available aggregating functions.
'ego' is excluded from these calculations.
See Haunss and Hollway (2023) for more on this effect.
\item dyadic covariates (other networks) can just be named
}}

\item{.data}{A manynet-consistent network.
See e.g. \code{manynet::as_tidygraph()} for more details.}

\item{method}{A method for establishing the null hypothesis.
Note that "qap" uses Dekker et al's (2007) double semi-partialling technique,
whereas "qapy" permutes only the $y$ variable.
"qap" is the default.}

\item{times}{Integer indicating number of simulations used for quantile estimation.
(Relevant to the null hypothesis test only -
the analysis itself is unaffected by this parameter.)
Note that, as for all Monte Carlo procedures, convergence is slower for more
extreme quantiles.
By default, \code{times=1000}.
1,000 - 10,000 repetitions recommended for publication-ready results.}

\item{strategy}{If \code{{furrr}} is installed,
then multiple cores can be used to accelerate the function.
By default \code{"sequential"},
but if multiple cores available,
then \code{"multisession"} or \code{"multicore"} may be useful.
Generally this is useful only when \code{times} > 1000.
See \href{https://furrr.futureverse.org}{\code{{furrr}}} for more.}

\item{verbose}{Whether the function should report on its progress.
By default FALSE.
See \href{https://progressr.futureverse.org}{\code{{progressr}}} for more.}
}
\description{
This function provides an implementation of
the multiple regression quadratic assignment procedure (MRQAP)
for both one-mode and two-mode network linear models.
It offers several advantages:
\itemize{
\item it works with combined graph/network objects such as igraph and network objects
by constructing the various dependent and independent matrices for the user.
\item it uses a more intuitive formula-based system for specifying the model,
with several ways to specify how nodal attributes should be handled.
\item it can handle categorical variables (factors/characters) and
interactions intuitively, naming the reference variable where appropriate.
\item it relies on \href{https://furrr.futureverse.org}{\code{{furrr}}} for parallelising
and \href{https://progressr.futureverse.org}{\code{{progressr}}}
for reporting progress to the user,
which can be useful when many simulations are required.
\item results are \href{https://broom.tidymodels.org}{\code{{broom}}}-compatible,
with \code{tidy()} and \code{glance()} reports to facilitate comparison
with results from different models.
Note that a \emph{t}- or \emph{z}-value is always used as the test statistic,
and properties of the dependent network
-- modes, directedness, loops, etc --
will always be respected in permutations and analysis.
}
}
\examples{
networkers <- ison_networkers \%>\% to_subgraph(Discipline == "Sociology")
model1 <- net_regression(weight ~ ego(Citations) + alter(Citations) + sim(Citations), 
                      networkers, times = 20)
# Should be run many more `times` for publication-ready results
tidy(model1)
glance(model1)
# if(require("autograph")) plot(model1)
}
\references{
Krackhardt, David. 1988.
“Predicting with Networks: Nonparametric Multiple Regression Analysis of Dyadic Data.”
\emph{Social Networks} 10(4):359–81.
\doi{10.1016/0378-8733(88)90004-4}.

Dekker, David, David Krackhard, and Tom A. B. Snijders. 2007.
“Sensitivity of MRQAP tests to collinearity and autocorrelation conditions.”
\emph{Psychometrika} 72(4): 563-581.
\doi{10.1007/s11336-007-9016-1}.
}
\seealso{
Other models: 
\code{\link{test_distributions}},
\code{\link{tests}}
}
\concept{models}

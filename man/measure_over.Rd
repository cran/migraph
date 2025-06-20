% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/measure_over.R
\name{measure_over}
\alias{measure_over}
\alias{over_membership}
\alias{over_waves}
\alias{over_time}
\title{Helper functions for measuring over splits of networks}
\usage{
over_membership(
  .data,
  FUN,
  ...,
  membership,
  strategy = "sequential",
  verbose = FALSE
)

over_waves(
  .data,
  FUN,
  ...,
  attribute = "wave",
  strategy = "sequential",
  verbose = FALSE
)

over_time(
  .data,
  FUN,
  ...,
  attribute = "time",
  slice = NULL,
  strategy = "sequential",
  verbose = FALSE
)
}
\arguments{
\item{.data}{A manynet-consistent network.
See e.g. \code{manynet::as_tidygraph()} for more details.}

\item{FUN}{A function to run over all splits.}

\item{...}{Further arguments to be passed on to FUN.}

\item{membership}{A categorical membership vector.}

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

\item{attribute}{A string naming the attribute to be split upon.}

\item{slice}{Optionally, a vector of specific slices.
Otherwise all observed slices will be returned.}
}
\description{
\itemize{
\item \code{over_membership()} runs a function, e.g. a measure,
over different group memberships
\item \code{over_waves()} runs a function, e.g. a measure,
over waves of a panel network
\item \code{over_time()} runs a function, e.g. a measure,
over time slices of a dynamic network
}
}

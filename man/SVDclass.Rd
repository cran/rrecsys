\name{SVDclass}
\docType{class}
\alias{SVDclass-class}
\alias{SVDclass}
\alias{show,SVDclass-method}
\title{
SVD model.
}
\description{
Container for the model learned using any matrix factorization algorithm.  
}
\section{Slots}{
  \describe{
    \item{\code{alg}:}{The algorithm denominator, of class \code{"character"}.}
    \item{\code{data}:}{the dataset used for training the model, class \code{"matrix"}.}
    \item{\code{factors}:}{user(U) and items(V) factors, class \code{"list"}.}
    \item{\code{parameters}:}{the parameters used in the model, class \code{"list"}.}
    \item{\code{baselines}:}{Global, user and item baselines, class \code{"list"}.}
  }
}
\section{Methods}{
  \describe{
  \item{\code{show}}{signature(object = "SVDclass")}
  }
}
\seealso{
\code{\link{rrecsys}.}
}

%\examples{}



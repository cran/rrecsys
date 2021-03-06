\name{evalRec}
\alias{evalRec}
\alias{evalRec,evalModel-method}
\alias{evalRec,evalModel,list-method}
\title{
Evaluates the requested recommendation algorithm.
}
\description{
Evaluates the recommendation task of an algorithm with a given configuration and based on the given evaluation model.  
}
%\usage{
%evalRec(model, ...)
%\S4method{evalRec}{evalModel}(model, alg = NULL, topN = 3, topNGen = "hpr", %positiveThreshold = NULL, alpha = 10, ... )
%}

\arguments{
  \item{model}{
  Object of type \code{evalModel}. See \code{\link{evalModel-class}.}
}
  \item{alg}{
  The algorithm to be used in the evaluation. Of class \code{character}. 
}
  \item{topN}{ 
  Object of class \code{numeric}, specifying the number of items to be recommended per user.
  }
    \item{topNGen}{ 
  Object of class \code{character}, specifying the function used to produce the recommendations. Values: "hpr" and "mf" (currently available only for IB and UB methods). 
  }
  \item{positiveThreshold}{
  Object of class \code{numeric}, indicating the threshold of the ratings to be considered a good. This attribute is not used when evaluating implicit feedback.
  }
  \item{alpha}{
  Object of class \code{numeric}, is the half-life parameter for the rankscore metric.
  }
  \item{\dots}{
  other attributes specific to the algorithm to be deployed. Refer to \code{\link{rrecsys}}.
}
}

\value{Returns an object of class \code{evalRecResults} with the \code{precision}, \code{recall}, \code{F1}, \code{nDCG}, \code{RankScore}, \code{true positives(TP)}, \code{false positives(FP)}, \code{true negatives(TN)}, \code{false negatives(FN)}  for each of the k-folds defined in the evaluation model and the overall average.}
\references{
F. Ricci, L. Rokach, B. Shapira, and P. B. Kantor, editors. \emph{Recommender Systems Handbook}. Springer, 2011. ISBN 978-0-387-85819-7. URL \url{http://www.springerlink.com/content/978-0-387-85819-7}.
}

\seealso{
  \code{\link{evalModel-class}}, \code{\link{rrecsys}}, \code{\link{evalRecResults-class}}.
}
\examples{
  x <- matrix(sample(c(0:5), size = 200, replace = TRUE, 
        prob = c(.6,.8,.8,.8,.8,.8)), nrow = 20, byrow = TRUE)
  
  x <- defineData(x)
        
  e <- evalModel(x, 2)
  
  SVDEvaluation <- evalRec(e, "FunkSVD", positiveThreshold = 4, k = 4) 
  
  SVDEvaluation         
  
  
  
}
  
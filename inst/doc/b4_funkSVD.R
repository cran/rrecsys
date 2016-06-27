## ----global_options, include=FALSE---------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(rrecsys)
data("mlLatest100k")
ML <- defineData(mlLatest100k, minimum = .5, maximum = 5, halfStar = TRUE)
smallML <- ML[rowRatings(ML)>=60, colRatings(ML)>=50]

## ------------------------------------------------------------------------
svd <- rrecsys(smallML, "FunkSVD", k = 10, gamma = .015, lambda = .001)
svd


## ----global_options, include=FALSE---------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(rrecsys)
data("mlLatest100k")
ML <- defineData(mlLatest100k, minimum = .5, maximum = 5, halfStar = TRUE)
smallML <- ML[rowRatings(ML)>=90, colRatings(ML)>=90]
setStoppingCriteria(nrLoops = 10)

## ------------------------------------------------------------------------
wALS <- rrecsys(smallML, "wALS", k = 5, lambda = 0.01, scheme = "uni", delta = 0.04)
wALS


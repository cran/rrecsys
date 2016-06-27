## ----global_options, include=FALSE---------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(rrecsys)
data("mlLatest100k")
ML <- defineData(mlLatest100k, minimum = .5, maximum = 5, halfStar = TRUE)
smallML <- ML[rowRatings(ML)>=60, colRatings(ML)>=50]
setStoppingCriteria(nrLoops = 10)

## ------------------------------------------------------------------------
bpr <- rrecsys(smallML, "BPR", k = 10, regU = .0025, regI = .0025, regJ = 0.0025, updateJ = TRUE)
bpr


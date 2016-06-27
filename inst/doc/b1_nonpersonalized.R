## ----global_options, include=FALSE---------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(rrecsys)
data("mlLatest100k")
ML <- defineData(mlLatest100k, minimum = .5, maximum = 5, halfStar = TRUE)
smallML <- ML[rowRatings(ML)>=60, colRatings(ML)>=50]

## ------------------------------------------------------------------------
# The maximum value of the dataset might not be required since the default value coincides to the actual maximal value of the dataset.
globAv <- rrecsys(smallML, alg = "globalaverage")
globAv
# Algorithm names might be matched on the registry partially.
itemAv <- rrecsys(smallML, "itemAver")
itemAv
userAv <- rrecsys(smallML, "useraverage")
userAv


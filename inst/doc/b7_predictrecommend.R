## ----global_options, include=FALSE---------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(rrecsys)
data("mlLatest100k")
ML <- defineData(mlLatest100k, minimum = .5, maximum = 5, halfStar = TRUE)
smallML <- ML[rowRatings(ML)>=90, colRatings(ML)>=90]
svd <- rrecsys(smallML, "FunkSVD", k = 10, gamma = .015, lambda = .001)
ibknn <- rrecsys(smallML, "ibknn", neigh = 20)

## ------------------------------------------------------------------------
pSVD <- predict(svd)
pIB <- predict(ibknn)
# Lets compare predicted results for user 1, 4 and 7 on two movies:
pSVD[c(1,4,6), c("Jumanji (1995)", "GoldenEye (1995)")]
pIB[c(1,4,6), c("Jumanji (1995)", "GoldenEye (1995)")]

## ------------------------------------------------------------------------
rSVD <- recommend(svd, topN = 3)
rIB <- recommend(ibknn, topN = 3)
# Let’s compare results on user 3:
rSVD[4]
rIB[4]


## ----global_options, include=FALSE---------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(rrecsys)

## ---- message=FALSE------------------------------------------------------
data("mlLatest100k")

## ------------------------------------------------------------------------
ML <- defineData(mlLatest100k, minimum = .5, maximum = 5, halfStar = TRUE)
ML

## ------------------------------------------------------------------------
binML <- defineData(mlLatest100k, binary = TRUE, goodRating = 3)
binML

## ---- eval=FALSE---------------------------------------------------------
#  # Number of times an item was rated.
#  colRatings(ML)
#  # Number of times a user has rated.
#  rowRatings(ML)
#  # Total number of rating in the rating matrix.
#  numRatings(ML)
#  # Sparsity.
#  sparsity(ML)

## ------------------------------------------------------------------------
# Removing users that rated less than 40 items and items that were rated less than 30 times.
subML <- ML[rowRatings(ML)>=40, colRatings(ML)>=30]
sparsity(ML)
sparsity(subML)


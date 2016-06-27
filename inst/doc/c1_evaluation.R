## ----global_options, include=FALSE---------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(rrecsys)

## ---- eval=FALSE---------------------------------------------------------
#  e <- evalModel(smallML, folds = 5)

## ---- eval=FALSE---------------------------------------------------------
#  evalPred(e, "ibknn", neigh = 5)

## ---- eval=FALSE---------------------------------------------------------
#  evalRec(e, "funk", k = 5, lambda = 0.001, goodRating = 3, topN = 3)

## ---- eval=FALSE---------------------------------------------------------
#  getAUC(e, "globalAv")


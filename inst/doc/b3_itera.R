## ----global_options, include=FALSE---------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(rrecsys)

## ------------------------------------------------------------------------
showStoppingCriteria()

## ------------------------------------------------------------------------
setStoppingCriteria(nrLoops = 10)

## ------------------------------------------------------------------------
setStoppingCriteria(autoConverge = TRUE, deltaErrorThreshold = 1e-5, minNrLoops = 10)


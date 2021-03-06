eval_nDCG <- function(recommendedIDX, testSetIDX){
  
  #extract index of the hits
  match_TS <- which(recommendedIDX %in% testSetIDX)
  
  if(length(match_TS)==0) return(0)
  #generate ideal discounted comulative gain
  idcg <- getiDCG(length(recommendedIDX))
  
  if(1 %in% match_TS){
    dcg <- 1/log2(match_TS[-1])
    dcg <- 1 + sum(dcg)
  }else{
    dcg <- sum(1/log2(match_TS))
  }
  
  dcg/idcg
}

getiDCG <- function(n){
  
  idcg <- 1
  
  if(n > 1){
  idcg <- idcg + sum(1/log2(2:n))
  }
  
  idcg
}

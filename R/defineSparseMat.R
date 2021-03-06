#define####
defineSparseMat <- function(data, 
                               binary, 
                               minimum, 
                               maximum, 
                            intScale, 
                              positiveThreshold){
  
  data <- as.data.frame(data)
  
  if(NCOL(data)>3) stop("Currently Rrecsys can manage only user-item rating matrices! Your dataset has more than 3 columns, please check it.")
  
  cat("WARNING: Please make sure that columns first to third are respectively user's IDs, item's IDs and user's score for that item.\n\n")
  
  names(data) <- c("user", "item", "score")
  
  data <- data[order(data$user, data$item), ]
  
  # Remove all the rows where is missing a valid score.
  if(binary){
    data <- data[-which(data$score < positiveThreshold), ]
  }
  
  # Ids of the user.
  userID <- unique(data$user)
  # Ids of the items.
  itemID <- unique(data$item)
  # Number of users.
  nrUsers <- length(userID)
  # Number of items.
  nrItems <- length(itemID)
  # Number of ratings.
  nrScores <- length(data$score)
  # Pointers to users position in the data goruped by ID.
  userPointers <- getPointers(userID, data$user)
  # Pointers to items position in the data goruped by ID.
  itemPointers <- getPointers(itemID, data$item)
  
  
  # Map user and item IDs to continous values.
  for(i in 1:length(userPointers)) data$user[userPointers[[i]]] <- i
  
  for(i in 1:length(itemPointers)) data$item[itemPointers[[i]]] <- i

  
  
  rownames(data) <- NULL
  
  new("sparseDataSet", 
      data = data,
      binary = binary,
      minimum = minimum,
      maximum = maximum,
      intScale = intScale,
      userID = userID,
      itemID = itemID,
      userPointers = userPointers,
      itemPointers = itemPointers
  )
  #END
}

#Conver####
setMethod("convert2DataSet", signature(x = "sparseDataSet"), function(x){

            data <- matrix(NA, nrow = nrow(x), ncol = ncol(x))
            
            idx <- nrow(x) * (x@data$item-1) + x@data$user
            
            data[idx] <- x@data$score
            
            new("dataSet", 
                data = data, 
                binary = x@binary, 
                minimum = x@minimum, 
                maximum = x@maximum, 
                intScale = x@intScale)
            
          })


#SHOW####

#getPointers####
getPointers <- function(IDs, vector){
  
  lapply(IDs, function(i) which(vector == i))
  
}

#dim####
setMethod("dim", signature(x = "sparseDataSet"), function(x) c(nrow(x),ncol(x)))
#ncol####
setMethod("ncol", signature(x = "sparseDataSet"), function(x) length(x@itemID))
#nrow####
setMethod("nrow", signature(x = "sparseDataSet"), function(x) length(x@userID))
#colRatings####
setMethod("colRatings", signature(x = "sparseDataSet"), function(x) {
  s <- sapply(x@itemPointers, length)
  s
})

#rowRatings####
setMethod("rowRatings", signature(x = "sparseDataSet"), function(x) {
  s <- sapply(x@userPointers, length)
  s
})
#numRatings####
setMethod("numRatings", signature(x = "sparseDataSet"), function(x) {
  nrow(x@data)
})

#colMeans####
setMethod("colAverages", signature(x = "sparseDataSet"), function(x, damping) {
  
  if(missing(damping)){
    
    m <- sapply(x@itemPointers, function(i) sum(x@data$score[i]))/colRatings(x)
    m[which(is.na(m))] <- 0
    m
    
  }else{
    
    m <- sapply(x@itemPointers, function(i) sum(x@data$score[i]))/(colRatings(x) + damping)
    m[which(is.na(m))] <- 0
    m
    
  }
  
})

#rowMeans####
setMethod("rowAverages", signature(x = "sparseDataSet"), function(x, damping) {
  
  if(missing(damping)){
    
    m <- sapply(x@userPointers, function(i) sum(x@data$score[i]))/rowRatings(x)
    m[which(is.na(m))] <- 0
    m
    
  }else{
    
    m <- sapply(x@userPointers, function(i) sum(x@data$score[i]))/(rowRatings(x) + damping)
    m[which(is.na(m))] <- 0
    m
    
  }
})

#Possible optimization!!!####
setMethod("[", signature(x = "sparseDataSet", i = "ANY", j = "ANY", drop = "missing"), function(x, i, j, ..., drop) {

  if (missing(i))
    i <- 1:nrow(x)
  if (missing(j))
    j <- 1:ncol(x)

  if(class(i) == "logical") 
    i <- which(i)
  
  if(class(i) == "logical") 
    j <- which(j)

  i <- unlist(x@userPointers[i])
  j <- unlist(x@itemPointers[j])
  
  
  new_x <- x@data[i[which(i %in% j)],]
  
  defineData(new_x, sparseMatrix = TRUE, binary = x@binary, 
             minimum = x@minimum, maximum = x@maximum, intScale =  x@intScale)

})


setMethod("averageRating", signature(x = "sparseDataSet"), function(x) {
  
  sum(x@data$score)/numRatings(x)
  
})



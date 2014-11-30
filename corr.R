

corr <- function(directory, threshold=0){
  
  ## Preparing an Empty Vector resultset
  cor_result<-c()
  
  ## Identifying number of files to loop
  n<-length(list.files(directory, full.names=TRUE))
  
  ## Using Complete.R to identify  complete cases 
  clear_data<-complete(directory, 1:n)
  
  ## Comparing the Threshold against complete case dataset
  thres_match<-clear_data$id[clear_data$nobs>=threshold]
  
  ## Looping across files to calculate correlation
  for(i in thres_match)
  {
    data_dist <- read.csv(fileloc[i])
    clear_set<-data_dist[complete.cases(data_dist),]
    t<-clear_set[,2]
    v<-clear_set[,3]
    cor_result<-c(cor_result,cor(t,v))
    
  }
  ##Sending the result
  cor_result
}

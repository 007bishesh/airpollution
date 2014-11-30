

complete <- function(directory, id=1:332 ){
  
  ## Preparing an Empty Data Frame
  combdata<-data.frame()
  filter_data<-data.frame()
  dist_data<-data.frame()
  wrong_data<-data.frame()
  
  ## Creating  a list of files in the directory with full location
  filelist<- list.files(directory, full.names=TRUE)
  
  ##Looping to read multiple files based upon the ID given as the parameter
  ##Since list.files lists files in ascending order we are able to identify exact files
  for (i in id)
  {
    combdata <- rbind(combdata, read.csv(filelist[i]))
  
  }
  
  #Calculating mean of sulfate or nitrate received by pollutant argurment . 
  ## Extraction function is used i.e [[]] to decrypt what pollutant carries
  ## Missing values NA is discarded
  
  
  
    filter_data<-rbind(combdata[complete.cases(combdata),])
    wrong_data<-rbind(combdata[!complete.cases(combdata),])
  
  # Checking ascending or descending order
  if (length(id)>1)
  {
  order_check<-id[1]-id[2]
  }
  else {
    order_check<-1
  }
  
 
  if (order_check==1)
  { 
    dist_data<-sqldf("select * from (SELECT ID as id ,count(*) as nobs FROM filter_data GROUP BY ID 
                 union 
                 select ID , '0' as nobs from wrong_data where id not in (select 
                 id from filter_data)) order by 1 desc 
                 ") 
    dist_data
  }
  else {
    dist_data<-sqldf("select * from (SELECT ID as id ,count(*) as nobs FROM filter_data GROUP BY ID 
                 union 
                 select ID , '0' as nobs from wrong_data where id not in (select 
                 id from filter_data)) order by 1 asc 
                 ") 
    dist_data
  }
  
}

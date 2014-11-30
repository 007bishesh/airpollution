

pollutantmean<-function(directory,pollutant, id=1:332){
    
    ## Preparing an Empty Data Frame
    combdata<-data.frame()
    
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
    round(mean(combdata[[pollutant]],na.rm=TRUE),3)
}
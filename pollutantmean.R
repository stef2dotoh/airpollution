## This function will return the mean of the specified pollutant
## across all monitors (ignoring NA values)

pollutantmean <- function(directory, pollutant, id = 1:332) {
  # create character vector of filenames based on passed id
  datafiles <- c()
  datafiles <- c(datafiles, paste(directory, "/", formatC(id, width=3, flag="0"), ".csv", sep=""))
  
  # read all files specified above
  my_data <- lapply(datafiles, read.csv)
  my_data <- do.call(rbind, my_data)
  
  #display sulfate or nitrate mean
  if (pollutant == colnames(my_data)[2]) {
    sulfate <- mean(my_data[,2], na.rm = TRUE)
    sulfate <- round(sulfate, digits = 3)
    return(sulfate)
  } else {
    nitrate <- mean(my_data[,3], na.rm = TRUE)
    nitrate <- round(nitrate, digits = 3)
    return(nitrate) 
  }       
}
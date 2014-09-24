## This function will read a directory full of files and report the number of
## completely observed cases in each data file

complete <- function(directory, id = 1:332) {
  # create character vector of filenames based on passed id
  datafiles <- c()
  datafiles <- c(datafiles, 
    paste(directory, "/", formatC(id, width=3, flag="0"), ".csv", sep=""))
  
  # read data from files
  my_data <- lapply(datafiles, read.csv)
  my_data <- do.call(rbind, my_data)
  
  #get completely observed cases
  my_data <- my_data[complete.cases(my_data), ]
   
  # create character vector to hold results
  data_vector <- c()
  
  # break data into subsets based on monitor ID
  # assign results of each subset to data_vector
  for (j in 1:length(id)) {
    data <- subset(my_data, my_data[,4]==id[j])
    data_vector <- c(data_vector, id[j], nrow(data))
  } 
  
  # convert vector to matrix
  data_matrix <- matrix(data_vector, nrow=length(id), ncol=2, byrow=TRUE)
  
  #convert matrix to data frame
  finaldata <- data.frame(data_matrix)
  
  # rename columns
  colnames(finaldata) <- c("id", "nobs")
  
  return(finaldata)
}
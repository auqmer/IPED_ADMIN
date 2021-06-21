build_ipedsdataset <- function(regexzip, conditions = NULL, vars = NULL) {
  ## combine IPEDS yearly files into single file.
  ## bring in list of zip files
  zfiles <- sort(grep(regexzip, list.files(), value = TRUE))
  ## loop through files
  for (i in 1:length(zfiles)) {
    ## unzip data with read_zip function
    data <- read_zip(zfiles[i])
    ## lower variable names in dataset
    #names(data) <- tolower(names(data))
    # get year from file name
    year <- as.numeric(gsub("\\D", "", zfiles[i]))
    # convert split year (e.g., 0910 to 2009)
    if (year < 1980 & year > 99) {
      year <- floor(year/100) + 2000
    }
    if (year < 100) {
      year <- year + 1900
    }
    if (year > 8000) {
      year <- floor(year/100) + 1900
    }
    ## add year column
    data$year <- year    
    # append dataset to prior data (data0)
     if(i == 1) {
    ## save a new data name for later rbind
       data0 <- data
       } else if(i == 2) {
       ## first appending
       result <- rbind(data0, data)
     } else {
       ##
       result <- rbind(result, data)
     }
  }
  # sort dataset: unitid by year
  result <- result[order(result$unitid,result$year),]
  ## return dataset
  return(result)
}

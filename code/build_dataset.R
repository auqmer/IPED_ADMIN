build_dataset <- function(regexzip, conditions = NULL, vars = NULL) {
  ## combine IPEDS yearly files into single file.
  ## bring in list of zip files
  zfiles <- sort(grep(regexzip, list.files(), value = TRUE))
  ## loop through files
  for (i in 1:length(zfiles)) {
    ## unzip data with read.zip function
    data <- read.zip(zfiles[i])
    ## lower variable names in dataset
    names(data) <- tolower(names(data))
    ## subset data based on conditions
    if (!is.null(conditions)) {
      cond <- eval(parse(text = (gsub("(\\b[[:alpha:]]+\\b)",
                                      "data$\\1", conditions))))
      data <- data[cond,]
    }
    ## subset data based on rows needed
    if (!is.null(vars)) {
      data <- data[,vars]
    }
    ## get year from file name
    year <- as.numeric(gsub("\\D", "", zfiles[i]))
    ## convert split year (e.g., 0910 to 2009)
    if (year < 2000) {
      year <- round(year/100, digits=0) + 2000
    }
    ## add year column
    data$year <- year
    ## append dataset to prior data (data0)
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
  ## sort dataset: unitid by year
  result <- result[order(result$unitid,result$year),]
  ## return dataset
  return(result)
}
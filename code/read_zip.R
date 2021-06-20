read_zip <- function(zipfile) {
  ## unzip function (modified) from
  ## http://stackoverflow.com/questions/8986818/automate-zip-file-reading-in-r
  # Create a name for the dir where we'll unzip
  zipdir <- tempfile()
  # Create the dir using that name
  dir.create(zipdir)
  # Unzip the file into the dir
  unzip(zipfile, exdir=zipdir)
  # Get the files into the dir
  files <- list.files(zipdir, recursive = TRUE)
  # Chose rv file if more than two
  if(length(files)>1) {
    file <- grep("*_rv.csv", files, value = TRUE)
  } else {
    file <- files[1]
  }
  # Get the full name of the file
  file <- paste(zipdir, file, sep="/")
  # Read the file
  read.csv(file, header=TRUE)
}

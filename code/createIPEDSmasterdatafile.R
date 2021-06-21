#************************************************************************
# Title: Create IPEDS Mater Data File
# Author: William Murrah
# Description: Create master data file from zip files on QMER drive.
# Created: Monday, 21 June 2021
# R version: R version 4.1.0 (2021-05-18)
# Project(working) directory: /home/hank01/Projects/QMER/IPED_ADMIN
#************************************************************************



origdir <- getwd()

source("code/build_dataset.R")
source("code/read_zip.R")

setwd("~/qmer/source_data/IPEDS/data/")

regexzip <- "HD[0-9]*.zip$"


hd1 <- read_zip(zfiles[1])
HDdat <- build_ipedsdataset(regexzip = regexzip)

regexzip <- "EF[0-9]*B.zip$"
cond <- "lstudy == 1 & line == 412"
var <- c("unitid","efage01","efage02")
enroll.data <- build_dataset(regexzip = regexzip, 
                             conditions = NULL, vars = NULL)




mdata <- merge(data0, data, by.x = "unitid", all.x = TRUE)



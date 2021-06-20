merge_ipedsdatasets <- function(obj.pattern = ".data\\b") {
  ## NB: this code requires survey datasets with *.data
  datasets <- ls(pattern = obj.pattern)
  for(i in 1:length(datasets)) {
    if (i == 1) {
      final.data <- eval(parse(text = datasets[i]))
      } else {
        merge.data <- eval(parse(text = datasets[i]))
        final.data <- merge(final.data, merge.data,
                        by = c("unitid", "year"),
                        all.x = TRUE)
      }
  }
  return(final.data)
}

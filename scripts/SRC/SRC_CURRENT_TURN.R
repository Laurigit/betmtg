#SRC_CURRENT_TURN
if(!file.exists("../common_data/current_turn.csv")) {

  res_table <- data.table(TSID = 0,
                               Peli_ID =0,
                               time_stamp = as.character(now(tz = "EET")))

} else {
  res_table <- as.data.table(read.csv(paste0("../common_data/", "current_turn.csv"),
                                  sep = ";",
                                  stringsAsFactors = FALSE,
                                  dec = ",",
                                  colClasses = "character",
                                  fileEncoding = "UTF-8"))
}
SRC_CURRENT_TURN <- res_table

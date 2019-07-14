setBettingResult <- function(PELI_ID, RESULT) {
  data_rows <- data.table(PELI_ID, RESULT)
  dbIoU("AVAILABLE_BETS", data_rows)
  closeBetting(PELI_ID)
}


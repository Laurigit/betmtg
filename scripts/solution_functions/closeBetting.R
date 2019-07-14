closeBetting <- function(PELI_ID) {

  data_row <- data.table(PELI_ID, CLOSING = now())
  dbIoU("AVAILABLE_BETS", data_row)
}


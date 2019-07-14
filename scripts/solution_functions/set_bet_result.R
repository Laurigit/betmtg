set_bet_result <- function(PELI_ID, RESULT) {

  dbIoU("AVAILABLE_BETS", data.table(PELI_ID, RESULT))

}

#set_bet_result(10, 1)

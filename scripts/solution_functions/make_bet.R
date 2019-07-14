#input_Better_ID <- 1
#input_Odds <- 34
#input_Peli_ID <-20

make_bet <- function(input_Peli_ID, input_Better_ID, input_Odds, input_BET_DT = now()) {
  #check if peli is available for betting

  if (nrow(get_available_betting()[PELI_ID %in% input_Peli_ID]) > 0) {
    insRow <- data.table(PELI_ID = input_Peli_ID,
                         BETTER_ID = input_Better_ID,
                         ODDS = input_Odds,
                         BET_DT = input_BET_DT)
    dbIoU("BETS", insRow)
    return(TRUE)
  } else {
    return(FALSE)
  }
}


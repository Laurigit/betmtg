open_betting <- function(input_Peli_ID, closing_time, input_T1_name, input_T2_name) {

  ins_row <- data.table(Peli_ID = input_Peli_ID,
                        T1_NAME = input_T1_name,
                        T2_NAME = input_T2_name,
                        CLOSING = closing_time)
  dbIoU("AVAILABLE_BETS", ins_row)

}

#open_betting(10, now(), "L", "M")


test_that("lisätään rivi AVAILABLE_BETS tauluun ja poistetaan se",
          {open_betting(50, now(),"Lauri", "Martti")
            delete_test_row("AVAILABLE_BETS")}

)

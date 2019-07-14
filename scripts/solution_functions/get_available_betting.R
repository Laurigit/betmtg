get_available_betting <- function() {
  res <- dbSelectAll("AVAILABLE_BETS")
  avail <- res[CLOSING > now()]
  return(avail)
}

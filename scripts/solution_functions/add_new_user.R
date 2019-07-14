add_new_user <- function(USERNAME, PW, EMAIL = NULL) {

  #check if exists
  res <- dbQ(paste0("SELECT id FROM BETTER_DIM WHERE USERNAME = \"" , USERNAME, "\""))
  if (nrow(res) == 0) {
  dbIns("BETTER_DIM", data.table(USERNAME, PW, EMAIL))
    res <- TRUE
  } else {
    res <- FALSE
  }
  return(res)
}

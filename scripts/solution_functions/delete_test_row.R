delete_test_row <- function(table) {
  con <- connDB(con)
  row_id <- dbFetch(dbSendQuery(con, paste0("SELECT COUNT(*) as MAX_ID FROM ",
                                            table
  )))
  delRow(table, row_id)
}


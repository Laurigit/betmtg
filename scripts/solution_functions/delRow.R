delRow <- function(table, row_id) {
  con <- connDB(con)
  dbFetch(dbSendQuery(con, paste0("DELETE FROM ", table, " WHERE ID = ", row_id)))
}

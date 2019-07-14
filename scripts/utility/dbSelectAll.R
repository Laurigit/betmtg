dbSelectAll <- function(table) {
  con <- connDB(con)
  res <- as.data.table(dbFetch(dbSendQuery(con, paste0("SELECT * FROM ",
                                                    table))))
  return(res)
}



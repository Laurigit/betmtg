connDB <- function(con) {
  con <- tryCatch({

    res <- dbFetch(dbSendQuery(con, "SHOW TABLES"))

    con
  }, error = function(ef) {

    con <<- dbConnect(MySQL(),
                     user = 'root',
                     password = 'my-spw',
                     host = '127.0.0.1',
                     port = 3306,
                     dbname = 'betmtg')
  })
  return(con)
}



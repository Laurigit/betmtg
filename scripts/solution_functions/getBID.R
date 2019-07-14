getBID <- function(BUsername) {
 res <- dbQ(paste0("SELECT id FROM BETTER_DIM WHERE USERNAME = \"", BUsername, "\""))[, id]

}

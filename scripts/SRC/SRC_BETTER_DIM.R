#SRC_BETTER_DIM
temp <- dbSelectAll("BETTER_DIM")
if (nrow(temp) == 0) {
  add_new_user("Lauri",  "user1", EMAIL = NULL)
  temp <- dbSelectAll("BETTER_DIM")
}
SRC_BETTER_DIM <- temp
#add_new_user("LAURI", "ss")

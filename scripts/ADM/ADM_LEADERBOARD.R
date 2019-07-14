#ADM_LEADERBOARD
#set_bet_result(1338, 0)
required_data(c("ADM_BETTING_RESULTS", "STG_BETS"))
#revUpdate("ADM_BETTING_RESULTS")
#revUpdate( "STG_BETS")
join_res <- STG_BETS[ADM_BETTING_RESULTS, on = "PELI_ID"][order(PELI_ID, ODDS)]
join_res[, ':=' (odds_if_1 = 1 / ((frank(- ODDS) ) / .N )), by = PELI_ID]
#join_res[, ':=' (odds_if_0 =  1 / (frank(ODDS) / .N), odds_if_1 = 1 / ((frank(- ODDS) ) / .N )), by = PELI_ID]
join_res[, vaadittu_kerroin_etta_pelaan_1 := 1 / (ODDS / 100)]
join_res[, USER_BET := ifelse(vaadittu_kerroin_etta_pelaan_1 < odds_if_1, 1, 0), by = .(PELI_ID, BETTER_ID)]


#join_res <- STG_BETS[ADM_BETTING_RESULTS, on = "PELI_ID"][order(PELI_ID, ODDS)]
join_res[, ':=' (odds_if_0 = 1 / ((frank(ODDS) / .N )  )), by = PELI_ID]
join_res[, vaadittu_kerroin_etta_pelaan_0:= 1 / ((100 - ODDS) / 100)]
join_res[, USER_BET_validate := ifelse(vaadittu_kerroin_etta_pelaan_0 < odds_if_0, 0, 1), by = .(PELI_ID, BETTER_ID)]
join_res[, .(ODDS, odds_if_1, vaadittu_kerroin_etta_pelaan_1, odds_if_0, vaadittu_kerroin_etta_pelaan_0, USER_BET, USER_BET_validate)]
join_res[, pct_order := 1 / (.N + 1 ) * frank(ODDS), by = PELI_ID]
join_res[, final_bet := ifelse(USER_BET_validate == USER_BET, USER_BET,
                               ifelse( ODDS > 100 * pct_order, 1, 0))]

sscols <- join_res[, .(final_bet, PELI_ID, RESULT, COMPETITION, BETTER_ID)]
sscols[, pay_off := ifelse(final_bet == RESULT, (.N / sum(final_bet == RESULT)) - 1, -1), by = PELI_ID]

ADM_LEADERBOARD <- sscols[, .(Score = sum(pay_off)), by = .(COMPETITION, BETTER_ID)][order(-Score)]
# join_res[, vaadittu_kerroin := 1 / (ODDS / 100)]
# join_res[, pct_order := round((1 / (.N + 1) * frank(ODDS) * 100)), by = PELI_ID]
# join_res[, order_kerroin :=  .N / (frank(ODDS)), by = PELI_ID]
# join_res[order(PELI_ID, ODDS)]
# join_res[, USER_BET := ifelse(ODDS < pct_order, 0, 1), by = .(PELI_ID, BETTER_ID)]
# join_res[order(PELI_ID, ODDS)]
# 1/7

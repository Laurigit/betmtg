#PELI_ID <- 1338
# generate_AI_bets(1338)
# open_betting(1338, now()+1000,"A", "B")
generate_AI_bets <- function(PELI_ID) {
required_data("STG_PELISTATSIT")
pelidata <- STG_PELISTATSIT[Peli_ID == PELI_ID]

#aloittaja voittaa 60%
AI_ID <- getBID("AI_go_first_wins")
aloittaja <- pelidata[Aloittaja == 1, Omistaja_ID]
if (aloittaja == "M") {predict <- 55 } else {predict <- 45}
make_bet(PELI_ID, AI_ID, predict)

#luottaa tilastoennusteeseen
predict <- round(pelidata[Omistaja_ID == "M", Prediction] * 100)
AI_ID <- getBID("AI_statistical")
make_bet(PELI_ID, AI_ID, predict)

#LAURI VOITTAA AINA
AI_ID <- getBID("AI_Lauri_wins_always")
make_bet(PELI_ID, AI_ID, 1)

#MARTII VOITTAA AINA
AI_ID <- getBID("AI_Martti_wins_always")
make_bet(PELI_ID, AI_ID, 99)

#Voitto_PCT_MA_VS
AI_ID <- getBID("AI_Recent_VS_games")
predict <- pelidata[Omistaja_ID == "M", round(Voitto_PCT_MA_VS * 100)]
make_bet(PELI_ID, AI_ID, predict)

#AI_deck_size/sum(deck_size)
AI_ID <- getBID("AI_smaller_deck_wins")
predict <- round(100 * pelidata[Omistaja_ID == "L", Deck_size] / (pelidata[Omistaja_ID == "M", Deck_size] + pelidata[Omistaja_ID == "L", Deck_size]))
make_bet(PELI_ID, AI_ID, predict)

#A_no_I_just_guessing
AI_ID <- getBID("A_no_I_just_guessing")
predict <- round(runif(1) * 100)
make_bet(PELI_ID, AI_ID, predict)
}


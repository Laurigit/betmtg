#tab_betting
# see available bets
# make bet


#avialble bets
#Peli_ID, T1_nimi, T2_nimi, Expected_closing_time

#inserted_ets
#Peli_ID, odds, Better_ID, Timestamp
# req(credentials()$user_auth)

nextGame_for_betting <- reactiveFileReader(1000, session, "next_game_ID.csv", rc)
closeBetting_file <- reactiveFileReader(1000, session, "temp_data_storage.csv", rc)

fileUpdates_betting <- reactiveValues(closeBetting_file = "", nextGame_for_betting = "")

observe({

  invalidateLater(1000, session)
  closeBetting_file <- as.character(file.info("../common_data/temp_data_storage.csv")$mtime)

  nextGame_for_betting <- as.character(file.info("../common_data/next_game_ID.csv")$mtime)

  next_peli_ID <- rc("next_game_ID.csv")[, Peli_ID]
  if (is.na(next_peli_ID)) {
    next_peli_ID <- 0
  }

  if (closeBetting_file != fileUpdates_betting$closeBetting_file) {

    close_peli_ID <- rc("temp_data_storage.csv")[muuttuja == "Peli_ID", arvo]
    if (next_peli_ID == close_peli_ID) {

      closeBetting(next_peli_ID)
      revUpdate("ADM_AVAILABLE_BETS_OPEN")
    }
    fileUpdates_betting$closeBetting_file <- closeBetting_file

  }

  if (nextGame_for_betting != fileUpdates_betting$nextGame_for_betting) {
    print("mentais lisaan uutta")

    required_data("STG_PELISTATSIT")
    #check that game exists
    if (nrow(STG_PELISTATSIT[Peli_ID == next_peli_ID]) > 0) {
    P1 <- STG_PELISTATSIT[Peli_ID == next_peli_ID & Omistaja_ID == "L", Pakka_NM]
    P2 <- STG_PELISTATSIT[Peli_ID == next_peli_ID & Omistaja_ID == "M", Pakka_NM]

    open_betting(next_peli_ID, now() + 1000, P1, P2)
    generate_AI_bets(next_peli_ID)
    revUpdate("ADM_AVAILABLE_BETS_OPEN")
    }
    fileUpdates_betting$nextGame_for_betting <- nextGame_for_betting
  }

  #check if got new results
  filelist <- data.table(filename = dir("../common_data"))
  filelist[, file_alku := str_sub(filename, 1, 10)]
  results <- filelist[file_alku == "Result_for", filename]
  if (length(results) > 0 ) {
    for (filelista in results) {

      match_result <- rc(paste0("../common_data/", filelista))
      peli_ID_input <- str_remove(str_remove(filelista, "Result_for_betting"), ".csv")
      setBettingResult(peli_ID_input, match_result[, Voittaja])
    }
  }
})





output$openBetsRadio <- renderUI({
  #take_dep
  print("UI PÄIVITTYY")
  fileUpdates_betting$nextGame_for_betting
  fileUpdates_betting$closeBetting_file
 ###
  #tää ei päivity ilman käsyä
  revUpdate("ADM_AVAILABLE_BETS_OPEN")
  looppiData <- ADM_AVAILABLE_BETS_OPEN
  open_bets <- TRUE
  if (nrow(looppiData) == 0) {
    looppiData <- data.table(PELI_ID = 0, T1_NAME = "NO", T2_NAME = "OPEN", closing = "GAMES TO BET")
    open_bets <- FALSE
  }
  looppiData[, teksti := paste0(T1_NAME, " VS ", T2_NAME)]
    if(open_bets == TRUE) {
      shinyjs::enable("buttonSaveBet")
      radioButtons("radio_available_bets", label = "Choose game to bet", choiceNames = looppiData[, teksti], choiceValues = looppiData[, PELI_ID])
    } else {
      HTML("No open bets")
      shinyjs::disable("buttonSaveBet")
    }


})



output$openBetsSlider <- renderUI({
  req(input$radio_available_bets)
required_data("ADM_AVAILABLE_BETS_OPEN")
  sliderInput("slider_betting_odds",
              min = 0,
              max = 100,
              value = 50,
              step = 1,
              label = paste0("Set likelihood of ",
                             ADM_AVAILABLE_BETS_OPEN[PELI_ID == input$radio_available_bets, T2_NAME], " winning. 0-100%"))

  #box(HTML(looppiData[,teksti]), background = "black")

})



observeEvent(input$buttonSaveBet, {
    required_data("ADM_AVAILABLE_BETS_OPEN")
    input_Peli_ID <- input$radio_available_bets

    make_bet(input_Peli_ID,
             getBID(user_data()$user),
             input$slider_betting_odds,
             now())
})

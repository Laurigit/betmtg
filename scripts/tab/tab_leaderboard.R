#tab_leaderboard

output$lb <- renderDataTable({
  required_data("ADM_LEADERBOARD")
  ADM_LEADERBOARD
})

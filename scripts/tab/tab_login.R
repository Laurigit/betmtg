#tab_login


observeEvent(input$signup,{
  add_new_user(input$new_user_name, input$new_pw, input$new_e_mail)
  revUpdate("ADM_USER_LOGIN")
updateActionButton(session, "signup", label = "REFRESH BROWSER AND LOGIN")
})




observe( {

  if (credentials()$user_auth) {
  updateTabItems(session,"sidebarmenu", "tab_betting")
  }
})


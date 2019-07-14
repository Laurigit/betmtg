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


# call login module supplying data frame, user and password cols
# and reactive trigger
required_data("ADM_USER_LOGIN")
credentials <- callModule(shinyauthr::login,
                          id = "login",
                          data = ADM_USER_LOGIN,
                          user_col = user,
                          pwd_col = password,
                          log_out = reactive(logout_init()))
logout_init <- callModule(shinyauthr::logout,
                          id = "logout",
                          active = reactive(credentials()$user_auth))
user_data <- reactive({credentials()$info})



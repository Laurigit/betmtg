#ui_login

tabItem(tabName = "tab_login",
        fluidPage(
#add logout button UI

          # must turn shinyjs on
          shinyjs::useShinyjs(),


#add login panel UI function
fluidRow(shinyauthr::loginUI(id = "login")),
fluidRow(h3("New user sign-up")),
fluidRow(textInput("new_user_name", label = "Choose username"),
fluidRow(textInput("new_pw", label = "Choose password. Stored in plain text and unsecured")),
fluidRow(textInput("new_e_mail", label = "Optional e-mail. Used for claiming prizes and password recovery"))),
fluidRow(actionButton("signup", label = "Sign up"))
)
)

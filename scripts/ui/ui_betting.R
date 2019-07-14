#ui_betting
tabItem(tabName = "tab_betting",
        fluidPage(
            uiOutput("openBetsRadio"),
            uiOutput("openBetsSlider"),
            actionButton("buttonSaveBet", "Place bet")
        )
)

source('global.R')
source('functions.R')
# sourceEntireFolder('data/US_COVID')
# sourceEntireFolder('data/WW_COVID')

header <- source('ui/dashboard_files/dashboardheader.R', local = TRUE)$value
sidebar <- source('ui/dashboard_files/dashboardsidebar.R', local = TRUE)$value
body <- source('ui/dashboard_files/dashboardbody.R', local = TRUE)$value
# controlbar <- source('ui/dashboard_files/dashboardbody.R', local = TRUE)$value

ui <- dashboardPage(
  header,
  sidebar,
  # controlbar = dashboardControlbar(
  #   skin = "dark",
  #   controlbarMenu(
  #     id = "menu",
  #     controlbarItem(
  #       "Tab 1",
  #       "Welcome to tab 1"
  #     ),
  #     controlbarItem(
  #       "Tab 2",
  #       "Welcome to tab 2"
  #     )
  #   )
  # ),
  body
)


server <- function(input,output,session) {
  
  observe(
    source(file.path("server", "Graphs", "Global_Covid.R"), local = T)$value
  )
  
  observe({
    if (input$selectall > 0) {
      if (input$selectall %% 2 == 0){
        updateCheckboxGroupButtons(session=session, inputId="checkbox1",
                                   choices = list("Confirmed", "Recovered", "Deaths"),
                                   checkIcon = list(
                                     yes = tags$i(class = "fa fa-check-square", 
                                                  style = "color: steelblue"),
                                     no = tags$i(class = "fa fa-square-o", 
                                                 style = "color: steelblue")),
                                   selected = c("Confirmed", "Recovered", "Deaths"))

      }
      else {
        updateCheckboxGroupButtons(session=session, inputId="checkbox1",
                                   choices = list("Confirmed", "Recovered", "Deaths"),
                                   checkIcon = list(
                                     yes = tags$i(class = "fa fa-check-square", 
                                                  style = "color: steelblue"),
                                     no = tags$i(class = "fa fa-square-o", 
                                                 style = "color: steelblue")),
                                   selected = c())

      }}
  })
}

shinyApp(ui , server = server)
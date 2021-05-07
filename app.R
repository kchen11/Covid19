source('global.R')
source('functions.R')
sourceEntireFolder('data/US_COVID')
sourceEntireFolder('data/WW_COVID')

header = source('ui/dashboard_files/dashboardheader.R', local = TRUE)$value
sidebar = source('ui/dashboard_files/dashboardsidebar.R', local = TRUE)$value
body = source('ui/dashboard_files/dashboardbody.R', local = TRUE)$value


ui <- dashboardPage(
  header,
  sidebar,
  body
)


server <- function(input,output,session) {
  
}

shinyApp(ui = ui, server = server)

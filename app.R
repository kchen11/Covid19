source('global.R')
source('functions.R')
sourceEntireFolder('data/US_COVID')
sourceEntireFolder('data/WW_COVID')

header <- source('ui/dashboard_files/dashboardheader.R', local = TRUE)$value
sidebar <- source('ui/dashboard_files/dashboardsidebar.R', local = TRUE)$value
body <- source('ui/dashboard_files/dashboardbody.R', local = TRUE)$value
# controlbar <- source('ui/dashboard_files/dashboardbody.R', local = TRUE)$value


runApp(
  shinyApp(
    ui = dashboardPage(
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
    ),
    server = function(input,output,session) {
      
      observe({
        invalidateLater(time_convert(12,0,0), session)
        source('data/WW_COVID/data_world.R')
        source('data/US_COVID/data.R')
      })
      
      observe(
        source(file.path("server", "Graphs", "Global_Covid.R"), local = T)$value
      )
    }
  
))

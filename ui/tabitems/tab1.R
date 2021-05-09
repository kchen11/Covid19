tabItem(tabName = "tab1",
        h1(""),
        fluidPage(
          fluidRow(
            column(9, withSpinner(plotlyOutput("Glo_Covid")), type = 3),
            column(3, box(title = 'Input Options',
                          width = 12, 
                          solidHeader = T,
                          # control the date
                          dateRangeInput(inputId = 'dateRange1',
                                         label = "Date Range Input",
                                         start = min(global_aggregate$Date), end = max(global_aggregate$Date),
                                         min = min(global_aggregate$Date), max(global_aggregate$Date),
                                         separator = " / ", format = "mm/dd/yy",
                                         startview = 'year', language = 'en', weekstart = 1
                          ),
                          # control the parameter (deaths, recovered, confirmed)
                          checkboxGroupButtons(
                            inputId = "checkbox1",
                            label = "Case Type Picker",
                            choices = c("Confirmed", "Recovered", "Deaths"),
                            selected = c("Confirmed", "Recovered", "Deaths"),
                            justified = T, 
                            checkIcon = list(
                              yes = tags$i(class = "fa fa-check-square", 
                                           style = "color: steelblue"),
                              no = tags$i(class = "fa fa-square-o", 
                                          style = "color: steelblue"))
                          ),
                          actionLink("selectall","Select/Deselect All") ,
                          align = 'center',
                          collapsible = T, 
                          collapsed = F, 
                          closable = F, 
                          icon = NULL, 
                          gradient = F,
                          boxToolSize = "sm",
                          headerBorder = TRUE,
                          label = NULL,
                          dropdownMenu = NULL,
                          # sidebar = boxSidebar(
                          #   startOpen = TRUE,
                          #   id = "mycardsidebar",
                          #   sliderInput(
                          #     "obs", 
                          #     "Number of observations:",
                          #     min = 0, 
                          #     max = 1000, 
                          #     value = 500
                          #   )
                          # ),
                          id = 'input1'
                          
            ))
          )
        )
)

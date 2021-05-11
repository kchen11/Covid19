tabItem(tabName = "tab1",
        h1(""),
        fluidPage(
          fluidRow(
            column(12,
                   valueBoxOutput("box1", width = 4),
                   valueBoxOutput("box2", width = 4),
                   valueBoxOutput("box3", width = 4)
                   )
          ),
          fluidRow(
            column(9, withSpinner(plotlyOutput("Glo_Covid")), type = 3),
            column(3, box(title = 'Input Options',
                          width = 12, 
                          solidHeader = T,
                          # control the date
                          dateRangeInput(inputId = 'dateRange1',
                                         label = "Date Range Input",
                                         start = min(global_aggregate$Date), end = maxdate,
                                         min = min(global_aggregate$Date), max = maxdate,
                                         separator = " / ", format = "mm/dd/yy",
                                         startview = 'year', language = 'en', weekstart = 1
                          ),
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

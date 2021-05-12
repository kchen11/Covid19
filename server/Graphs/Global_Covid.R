# https://stackoverflow.com/questions/21515800/subset-a-data-frame-based-on-user-input-shiny

observeEvent(input$dateRange1[1],{
  
  
  if(input$dateRange1[1] > input$dateRange1[2]) {
    
    start_date <- input$dateRange1[1]
    end_date <- input$dateRange1[1]
    
    updateDateRangeInput(session, "dateRange1", start = start_date, end = end_date)
  }
})  

output$Glo_Covid <- renderPlotly({
  
  validate(
    need(input$dateRange1, 'Select both beginning and ending date')
  )
  
  global_aggregate <- global_aggregate %>%
    filter(global_aggregate$Date >= input$dateRange1[1] & 
             global_aggregate$Date <= input$dateRange1[2])
  
  fig <- plot_ly(global_aggregate, x = global_aggregate$Date)

  fig <- fig %>%
    add_trace(y = global_aggregate$Confirmed, 
              type = 'scatter', 
              mode = 'lines',
              name = 'Confirmed') %>%
    add_trace(y = global_aggregate$Recovered, 
              type = 'scatter', 
              mode = 'lines',
              name = 'Recovered') %>%
    add_trace(y = global_aggregate$Deaths, 
              type = 'scatter', 
              mode = 'lines',
              name = 'Deaths') 
  
  
  fig <- fig %>%
    layout(
      title = 'Global Aggregated Cases',
      xaxis = list(
        title = 'Date',
        # tickvals = global_aggregate$Date,
        # tickformat = '%b %y',
        tickangle = -30,
        type = 'date',
        showgrid = T,
        showline = T,
        zeroline = F,
        ticks = "outside"
      ),
      yaxis = list(
        title = 'Number of Cases',
        showgrid = T,
        showline = T, 
        zeroline = T,
        ticks = "outside"
      ),
      autosize = T,
      hovermode = "x unified",
      colorway = c('#0073b7', '#00a65a', '#dd4b39'),
      legend = list(orientation = 'h', 
                    traceorder = 'normal',
                    xanchor = "left",
                    y = -.25,
                    x = 0)
    )
  
  
  fig
})

output$box1 <- renderValueBox({
  global_aggregate_box <- global_aggregate %>%
    filter(Date == max(Date))
  
  global_aggregate_hc <- global_aggregate %>%
    filter(Date >= max(Date) - days(13))
  
  vb <- valueBoxSpark(
    value = paste(round(global_aggregate_box$Confirmed/1000000, digits = 2), 'M'),
    title = toupper("Confirmed Cases to Date"),
    sparkobj = 
      hchart(global_aggregate_hc, "spline", hcaes(Date, Confirmed), name = "Confirmed", marker = F)  %>% 
      hc_size(height = 50) %>% 
      hc_credits(enabled = FALSE) %>%
      hc_add_theme(hc_theme_sparkline_vb()),
    subtitle = tagList(HTML("&uarr;"), 
                       paste(percent(global_aggregate_box$Increase_rate, accuracy = 1), "from the previous day")),
    info = NULL,
    icon = icon("lungs-virus"), 
    width = 3,
    color = "blue", 
    href = NULL
  )
  
  vb
  
})
output$box2 <- renderValueBox({
  global_aggregate_box <- global_aggregate %>%
    filter(Date == max(Date))
  
  global_aggregate_hc <- global_aggregate %>%
    filter(Date >= max(Date) - days(13)) %>%
    mutate(recovered_rate = (Recovered - lag(Recovered))/lag(Recovered) * 100)
  
  vb <- valueBoxSpark(
    value = paste(round(global_aggregate_box$Recovered/1000000, digits = 2), 'M'),
    title = toupper("Recovered Cases to Date"),
    sparkobj = 
      hc2 <- hchart(global_aggregate_hc, "spline", hcaes(Date, Recovered), name = "Recovered", marker = F)  %>%
      hc_size(height = 50) %>%
      hc_credits(enabled = FALSE) %>%
      hc_add_theme(hc_theme_sparkline_vb()),
    subtitle = tagList(HTML("&uarr;"), 
                       paste(percent(tail(global_aggregate_hc$recovered_rate, 1), accuracy = 1), "from the previous day")),
    info = NULL,
    icon = icon("medkit"), 
    width = 3,
    color = "green", 
    href = NULL
  )
  
  vb
  
})
output$box3 <- renderValueBox({
  global_aggregate_box <- global_aggregate %>%
    filter(Date == max(Date))
  
  # org_value - new value / org
  global_aggregate_hc <- global_aggregate %>%
    filter(Date >= max(Date) - days(13)) %>% 
    mutate(death_rate = (Deaths - lag(Deaths))/lag(Deaths) * 100)
  
  vb <- valueBoxSpark(
    value = paste(round(global_aggregate_box$Deaths/1000000, digits = 2), 'M'),
    title = toupper("Deaths to Date"),
    sparkobj = 
      hchart(global_aggregate_hc, "area", hcaes(Date, Deaths), name = "Deaths", marker = F)  %>%
      hc_size(height = 50) %>%
      hc_credits(enabled = FALSE) %>%
      hc_add_theme(hc_theme_sparkline_vb()),
    subtitle = tagList(HTML("&uarr;"), 
                       paste(percent(tail(global_aggregate_hc$death_rate, 1), accuracy = 1), "from the previous day")),
    info = NULL,
    icon = icon("procedures"), 
    width = 3,
    color = "red", 
    href = NULL
  )
  
  vb
  
})


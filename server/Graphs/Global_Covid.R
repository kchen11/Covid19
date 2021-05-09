# https://stackoverflow.com/questions/21515800/subset-a-data-frame-based-on-user-input-shiny

category <- c("Confirmed", "Recovered", "Deaths")

df_subset <- reactive({
  a <- subset(global_aggregate, category == input$checkbox1)
  return(a)
})

output$Glo_Covid <- renderPlotly({
  
  validate(
    need(input$dateRange1, 'Select both beginning and ending date'),
    need(input$checkbox1, 'Select at least one case type')
  )
  
  global_aggregate$Date <- as.Date(global_aggregate$Date)
  
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
        tickformat = '%b %y',
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
      hovermode = "closest"
    )
  
  
  
  fig
})
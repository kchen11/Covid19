dashboardBody(
  shinyjs::useShinyjs(),
  tabItems(
    source(file.path("ui", "tabitems", "tab1.R"), local = TRUE)$value
  )
)

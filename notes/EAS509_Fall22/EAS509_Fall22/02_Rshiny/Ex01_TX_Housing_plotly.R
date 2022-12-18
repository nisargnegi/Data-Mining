library(shiny)
library(plotly)


# User Interface Description
# - defines how inputs and output widgets are displayed on the page
ui <- fluidPage(
  selectizeInput(
    inputId = "cities", 
    label = "Select a city", 
    choices = unique(txhousing$city), 
    selected = "Abilene",
    multiple = TRUE
  ),
  plotlyOutput(outputId = "plotly1")
)

# The server function
# - defines a mapping from input values to output widgets
server <- function(input, output, session) {
  # note that element of output matches outputId in ui
  output$plotly1 <- renderPlotly({
    # note that element of input matches inputId in ui
    plot_ly(txhousing, x = ~date, y = ~median) %>%
      filter(city %in% input$cities) %>%
      group_by(city) %>%
      add_lines()
  })
}

# Start shiny web-server
shinyApp(ui, server)

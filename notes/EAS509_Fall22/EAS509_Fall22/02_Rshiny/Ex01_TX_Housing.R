library(shiny)
library(ggplot2)


# User Interface Description
# - defines how inputs and output widgets are displayed on the page
ui <- fluidPage(
  selectInput(
    inputId = "cities", 
    label = "Select a city", 
    choices = unique(txhousing$city), 
    selected = "Abilene",
    multiple = TRUE
  ),
  plotOutput(outputId = 'ggplot1')
)

# The server function
# - defines a mapping from input values to output widgets
server <- function(input, output, session) {
  print("server function")
  output$ggplot1 <- renderPlot({
    print("server::renderPlot function")
    ggplot(txhousing %>% filter(city %in% input$cities),
           aes(x=date, y=median, color=city)) + geom_line()
  })
}

# Start shiny web-server
shinyApp(ui, server)

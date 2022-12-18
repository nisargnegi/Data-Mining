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
  # note that element of output matches outputId in ui
  output$ggplot1 <- renderPlot({ 
    # note that element of input matches inputId in ui
    ggplot(txhousing %>% filter(city %in% input$cities),
           aes(x=date, y=median, color=city)) + geom_line()
    # what is that syntax and what does it return?
  })
}

# Start shiny web-server
shinyApp(ui, server)

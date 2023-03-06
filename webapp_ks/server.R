


library(shiny)
library(tidyverse)

cereal <- read_delim("../data/cereal.csv")

# Define server logic required to draw a histogram
function(input, output, session) {
  
  # calories per serving vs sugars
  output$plot <- renderPlot({
    data <- cereal %>%
      filter(calories > input$range[1], calories < input$range[2])
    
    ggplot(
      data = data, 
      mapping = aes(x = calories, y = sugars)) +
      geom_point(col = input$color, size= 3) + 
      labs(x = "Calories", y = "Sugars") 
  })
  
  output$plottext <- renderText({
    paste("You have chosen a range that goes from",
          input$range[1], "to", input$range[2])
  })
  
  # name vs rating
  namevsrate <- reactive({
    ratingname <- cereal %>%
      filter(rating > input$range2[1], rating < input$range2[2])
    
    ratingname[input$range2[1]:input$range2[2], ] %>% 
      select(rating, input$manu) %>% 
      arrange(rating)
  })
  
  output$table <- renderTable({
    namevsrate()
  })
  
  output$tabletext <- renderText({
    paste("You have chosen a range that goes from",
          input$range2[1], "to", input$range2[2])
  })
  
}
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

cereal <- read_delim("../data/cereal.csv")
cal_range <- range(cereal$calories)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Cereal"),

    tabsetPanel(
      
        tabPanel(
          "Page Overview",
          h2("Overview"),
          mainPanel(
            "This data set contains the various nutritional facts about 80 brands of cereals.
            The facts include manufacturers, calories, protein, fat, sodium, fiber, and more.
            This dataset was accessed from kaggle.com, with the data collected by Sonia Sharma, 
            Rachael Tatman, and Nadin Tamer."
          )
        ),
          
        
        tabPanel(
          "Plot",
          h2("Plot Page"),
          sidebarLayout(
            sidebarPanel(
              "Calories compared to Sugars. Feel free to choose a different color and adjust
              the range for calories.",
              selectInput(
                "color",
                label = "Color",
                choices = c("red", "blue", "green"),
                selected = "red"
              ),
              sliderInput("range", "Range:",
                          min = cal_range[1],
                          max = cal_range[2],
                          value = cal_range)
            ),
            mainPanel(
              textOutput("plottext"),
              plotOutput("plot")
            )
          )
        ),
          
        
        tabPanel(
          "Table",
          h2("Table Page"),
          
          sidebarLayout(
            sidebarPanel(
              "Select between calories, protein, fat, sodium, fiber, carbohydrates, 
              sugars, potassium, vitamins, shelf life, weight, cups, and rating.",
              sliderInput("range2", "Rating range:",
                          min = 0,
                          max = 100,
                          value = c(20, 60)),
              checkboxGroupInput("manu", "Select categories: ",
                                 choices = c("calories", "protein", "fat",
                                             "sodium", "fiber", "carbo", "sugars",
                                             "potass", "vitamins", "shelf", "weight",
                                             "cups", "rating"),
                                 selected = "rating"),
            ),
            mainPanel(
              textOutput("tabletext"),
              tableOutput("table")
            )
          )
        )
      
    )
)


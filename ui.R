library(shiny)
library(leaflet)


shinyUI(fluidPage( 
    fluidRow(
        column(12,
               h1("Significant Earthquakes, 2000-2016 Map")
               )
    ),
    fluidRow(
        column(12,
               p("by Ryan J. Porter")
               )
    ),    
    fluidRow(
        column(8,
               leafletOutput("leaf")),
        column(4,
               p(strong("To start click the 'submit' button."),
                 br("Each represents an earth quake, more red dots represent higher magnitude earthquakes. 
                     Use the sliders to select the years and magnitudes shown, click submit to apply changes to the sliders."),
                 br("Click a circle to display the exact date and magnitude of that quake."),
                 br("The dataset used is from the",
                    HTML("<a href=https://www.kaggle.com/usgs/earthquake-database>earthquake database</a>"),
                    "on ", HTML("<a href=https://www.kaggle.com/>kaggle.com</a>."))
                 ))
    ),
    fluidRow(
        column(4,
               sliderInput("year_select", "Select Year Range", min = 2000, max = 2016, value = c(2000, 2016), sep = "")),
        column(4,
               sliderInput("mag_select", "Select Magnitude Range", min = 5, max = 10, value = c(5, 10), step = 0.1)
               ),
        column(2,
               actionButton("button", "submit")
        )
    )
))


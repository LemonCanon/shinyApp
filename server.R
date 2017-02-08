library(shiny)
library(leaflet)


earth <- read.csv("database.csv")
tmp <- as.Date(earth$Date, "%m/%d/%Y") %>% format("%Y") %>% as.numeric()
earth$year <- tmp
rm(tmp)
earth <- earth[!is.na(earth$year) & !is.na(earth$Longitude) & !is.na(earth$Latitude),]
earth <- earth[earth$year >= 2000,]

shinyServer(function(input, output) {
    
   dataset <- eventReactive(input$button, {
        in_years_low <- input$year_select[1] <= earth$year
        in_years_high <- input$year_select[2] >= earth$year
        in_mag_low <- input$mag_select[1] <= earth$Magnitude
        in_mag_high <- input$mag_select[2] >= earth$Magnitude
        earth[in_years_low & in_years_high &
                      in_mag_low & in_mag_high,]
    })
    
    pal <- colorNumeric(c("yellow","red"), earth$Magnitude)
    output$leaf <- renderLeaflet({
        
        l <- leaflet(dataset()) %>% addTiles() %>% 
            addCircleMarkers(fillOpacity = 0.33, radius = 6,
                             popup =~ paste(sep = "</br>", Date, Type, 
                                            paste("magnitude:", Magnitude),
                                            paste("Latitude:", Latitude),
                                            paste("Longitude:", Longitude)),
                             color =~ pal(dataset()$Magnitude))
            
            
        print(l)
    
    })
    shiny:::flushReact()
})

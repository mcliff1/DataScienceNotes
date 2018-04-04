#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
library(shiny)
library(leaflet)

r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()


# runs the application
shinyServer(function(input, output, session) {

  points <- eventReactive(input$recalc, {
      cbind(rnorm(30) * 2 + 13, rnorm(30) + 48)
  }, ignoreNULL = FALSE)

         
  output$mymap <- renderLeaflet({

      leaflet() %>%  
          addProviderTiles(providers$Stamen.TonerLite,
                           options=providerTileOptions(noWrap = TRUE)
                           ) %>%
          addMarkers(data = points())
  })
  
})

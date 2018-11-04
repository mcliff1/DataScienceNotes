# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
# this is called one-time to build the html shell
library(shiny)
library(leaflet)

# Define UI for map controls
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Denver Maps"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        p("Here is where you would select data")
    ),
  
  
  
    # Show a plot of the generated distribution
    mainPanel(
        
        p("here I will put the map"),
        leafletOutput("mymap"),
        p(),
        actionButton("recalc", "New points")
        
    )
  )
))

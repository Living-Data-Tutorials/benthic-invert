#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("../plotRankAbundance.R")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$RankAbundPlot <- renderPlot({
      plotRankAbundance(datapath = "../../../Data/TLW_invertebrateDensity.csv",
                        select_catchment = input$catchment, 
                        select_month = input$month,
                        select_year=input$year, 
                        log=input$log)
    })

})

#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Get options for year, season and catchment
df = read.csv("Data/TLW_invertebrateDensity.csv")
year_options      = df %>% pull(year) %>% unique
month_options     = df %>% pull(month) %>% unique
catchment_options = df %>% pull(catchment) %>% unique

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Rank-Abundance Curve for Benthic Invertebrates in Turkey Lakes"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          checkboxGroupInput("year", 
                             h3("Year"), 
                             choices = year_options,
                             selected = 1998)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))

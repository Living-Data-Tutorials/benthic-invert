library(readr)
library(dplyr)
library(ggplot2)

## The following function could be used as a part of a Shiny app.

plotRankAbundance <- function(
  select_catchment = "34L",    ## 31 & 34L most heavily deforested
  select_year      = 1998,     ## Harvesting operation: 1997
  select_month     = c("september", "june")   ## June or September
)
{
  # Load & filter to options selected above
  df <- read.csv("Data/TLW_invertebrateDensity.csv") %>% 
    filter(catchment == !! select_catchment, 
           year      == !! select_year, 
           month     == !! select_month) %>%
    # Tidy data for plotting
    tidyr::pivot_longer( "Aeshna":"Trichoptera", names_to = "Species", values_to = "Density" ) %>%
    mutate(
      Count = Density * 0.33) %>%
    group_by(Species) %>%
    summarise(TotalCount = sum(Count)) %>%
    tidyr::drop_na() %>%
    arrange(desc(TotalCount)) 
  
  # PLOT
  df %>%
    ggplot(aes(x=reorder(Species, TotalCount), y=TotalCount)) + 
    xlab("Taxon") + 
    ylab("Total count (sum of replicates)") + 
    geom_col() + 
    coord_flip() +
    theme_classic() +
    theme(axis.text.y = element_text(face="italic"))
}

## DEBUG
# plotRankAbundance()

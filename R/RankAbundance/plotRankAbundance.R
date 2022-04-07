library(readr)
library(dplyr)
library(ggplot2)

## The following function could be used as a part of a Shiny app.
plotRankAbundance <- function (
  df,
  select_catchment = "34L",             ## 31 & 34L most heavily deforested
  select_year      = c(1998, 1999),     ## Harvesting operation: 1997
  select_month     = c("september", "june"),   
  datapath         = "Data/TLW_invertebrateDensity.csv",
  log              = T
)
{
  # Load & filter to options selected above
  df <- df %>% 
    filter(catchment %in% !! select_catchment, 
           year   >= select_year[1], 
           year   <= select_year[2],
           month     %in% !! select_month) %>%
    group_by(Species) %>%
    summarise(
      TotalCount = sum(Count))  %>%
    arrange(desc(TotalCount)) 
    

  # PLOT
  plot = df %>%
    ggplot(aes(x=reorder(Species, TotalCount), y=TotalCount)) + 
    xlab("Taxon") + 
    ylab("Total count (sum of replicates)") + 
    geom_col() + 
    coord_flip() +
    theme_classic() +
    theme(axis.text.y = element_text(face="italic"))
  if(log) {
    plot = plot + scale_y_log10() + ylab("log Total count (sum of replicates)")
  }
  plot
}

## DEBUG
# plotRankAbundance()

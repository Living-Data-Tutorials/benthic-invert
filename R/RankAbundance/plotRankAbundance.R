library(readr)
library(dplyr)
library(ggplot2)

## The following options could be part of a Shiny app.
select_catchment = "34L"    ## 31 & 34L most heavily deforested
select_year      = 1998     ## Harvesting operation: 1997
select_month     = "june"   ## June or spetember


# Load & filter to options selected above
read.csv("Data/TLW_invertebrateDensity.csv") %>% 
  filter(catchment == !! select_catchment, 
         year      == !! select_year, 
         month     == !! select_month) %>%
  # summarise(across(where(is.numeric), ~mean(.x) ) ) %>%
  tidyr::pivot_longer( "Aeshna":"Trichoptera", names_to = "Species", values_to = "Density" ) %>%
  mutate(Count = Density * 0.33) %>%
  group_by(Species) %>%
  summarise(TotalCount = sum(Count)) %>%
  tidyr::drop_na() %>%
  arrange(desc(TotalCount)) %>%
  ggplot(aes(x=reorder(Species, TotalCount), y=TotalCount)) + 
  ylab("Species") + 
  xlab("Total count (across replicates)") + 
  geom_col() + 
  coord_flip() +
  theme_classic()


# %>% summary()


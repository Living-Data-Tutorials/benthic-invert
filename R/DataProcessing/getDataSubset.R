library(dplyr)


# Make a smaller, more palatable version of the dataset
df = read.csv("Data/TLW_invertebrateDensity.csv") %>%
  tidyr::pivot_longer( "Aeshna":"Trichoptera", names_to = "Species", values_to = "Density" ) %>%
  mutate(
    Count = Density * 0.33, 
    Count = tidyr::replace_na(Count, 0)) %>%
  filter(year >= 1995, 
         year <= 2001, 
         stringr::str_starts(catchment, stringr::fixed("34")), 
         month=="june")

## Find species that have 0 abudnance across all sites and years.
NA_sp = df %>%
  group_by(Species) %>%
  summarize(Count = sum(Count, na.rm=T)) %>%
  filter(Count==0) %>%
  select(Species)

## Remove those species from the dataset
df %>% 
  anti_join(NA_sp)

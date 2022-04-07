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
df = df %>% 
  anti_join(NA_sp)

## Check replicate consistency
if( df %>% group_by(catchment, year, Species) %>%
  summarise(n=sum(replicate)) %>%
  filter(n!=55) %>% nrow){
  warning("WARNING! Data contains missing replicates! -Egor")
}

## All catchment/year/Species combos have exactly 10 replicates!




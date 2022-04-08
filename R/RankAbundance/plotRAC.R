library(ggplot2)
source("R/DataProcessing/getDataSubset.R")

plotRAC <- function() {
  df %>%
    ungroup() %>%
    group_by(year, `Logging Intensity`) %>%
    arrange(desc(TotalCount), .by_group = T) %>%
    mutate( Rank = seq_along(Species) ) %>%
    ggplot(aes(x=Rank, y=TotalCount, color=`Logging Intensity`)) + 
    xlab("Taxon Rank") + 
    ylab("Total count (sum of replicates)") + 
    geom_line(aes(size=`Logging Intensity`)) + 
    scale_size_manual(values=c(2.5, 2, 1.5)) +
    facet_wrap(vars(year)) + 
    theme_classic(base_size=16) +
    scale_y_log10()
}

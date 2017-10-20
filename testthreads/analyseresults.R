library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)

source("loadJobStats.R")
allResults <- bind_rows(
                        loadJobStats("csfIvybridge.rda"),
                         loadJobStats("csfSandybridge.rda"),
                         loadJobStats("csfHaswell.rda"),
                         loadJobStats("csfBroadwell.rda"),
                         loadJobStats("csfWestmere.rda"))

allResults %>%  filter(infile != "csfWestmere.rda") %>% 
  ggplot(aes(x = threads, y = time, colour = task)) + geom_point() + 
  geom_line() + facet_wrap(~ infile) + scale_x_continuous(limits = c(1,8)) +
  scale_y_continuous(limits = c(0,15))
  
allResults %>% filter(infile == "csfIvybridge.rda") %>% ggplot( aes(x = threads, y = time, colour = task)) + geom_point() + 
  geom_line() + facet_wrap(~ infile) 

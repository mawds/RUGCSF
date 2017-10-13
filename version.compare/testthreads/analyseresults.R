library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)

source("loadJobStats.R")
allResults <- bind_rows(loadJobStats("LaptopLinuxMSR.rda"),
                        loadJobStats("LaptopLinuxStandardR.rda"),
                        loadJobStats("csf_short.rda"),
                        loadJobStats("csf.rda")
)

ggplot(allResults, aes(x = threads, y = time, colour = task)) + geom_point() + 
  geom_line() + facet_wrap(~ infile) 
  
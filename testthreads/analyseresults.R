library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
rm(list=ls())

source("loadJobStats.R")
allResults <- bind_rows(
                        loadJobStats("./csfBaseR/csfIvybridge.rda"),
                         loadJobStats("./csfBaseR/csfSandybridge.rda"),
                         loadJobStats("./csfBaseR/csfHaswell.rda"),
                         loadJobStats("./csfBaseR/csfBroadwell.rda"),
                         loadJobStats("./csfBaseR/csfWestmere.rda"),

                        loadJobStats("csfIvybridge.rda"),
                         loadJobStats("csfSandybridge.rda"),
                         loadJobStats("csfHaswell.rda"),
                         loadJobStats("csfBroadwell.rda"),
                         loadJobStats("csfWestmere.rda")
)

allResults %>%  filter(infile != "csfWestmere.rda") %>% 
  ggplot(aes(x = quasithread, y = time, colour = task, shape = RProvider)) + geom_point() + 
  geom_line() + facet_wrap(~ infile) + scale_x_continuous(limits = c(0,8)) +
 scale_y_log10() + labs(x = "Threads",
                        y = "Time (seconds) - log scale",
                        main = "CSF",
                        shape = "R Version",
                        colout = "Task")


  
CSFBasetimes <- allResults %>% 
  filter(RProvider != "Microsoft") %>%
  rename(basetime = time) %>% 
  select(task, basetime,infile)

allResults %>%  
  filter(RProvider == "Microsoft") %>% 
  inner_join(CSFBasetimes, by = c("task", "infile")) %>% 
  mutate(speedup = basetime / time)  %>% 
  ggplot(aes(x = threads, y=speedup, colour=task, group = task)) + geom_point() + geom_line() +
  facet_wrap(~ infile) + 
  labs(x = "Threads", y = "Speedup wrt standard R",  colour = "Task",
       title = "CSF; speedup over standard R") +
      coord_cartesian(xlim=c(1,8), ylim = c(0,80)) + geom_hline(aes(yintercept = 1))

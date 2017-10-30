
loadJobStats <- function(infile){
  load(infile)
  
  resultframe <- do.call(cbind.data.frame,lapply(results, data.frame))
  
  tidyresults <- resultframe %>% as_tibble() %>%
    mutate(task = row.names(.)) %>%   
    gather( key = "version", value = "time", -task) %>% 
    mutate(threads = as.numeric(str_match(version, "\\.(\\d+)\\.thread")[,2])) %>% 
    mutate(RProvider = if_else(grepl("Microsoft", version), "Microsoft", "Standard")) %>% 
    mutate(RProvider = parse_factor(RProvider, levels=c("Microsoft", "Standard"))) %>% 
    mutate(quasithread = if_else(RProvider == "Standard", 0, threads)) %>% 
    mutate(infile = basename(UQ(infile)))
  
  return(tidyresults)
  
}

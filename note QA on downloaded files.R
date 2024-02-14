## note quality check downloaded files 

library(tidyverse)
library(tools)

## identical files have the exact same checksums 

downloaded <- list.files('data', full.names = T)
downloaded <-
  downloaded[downloaded %>% grepl(pattern = '.zip')] ## only keep zip files

downloaded %>% length ## 313 zip files 

## I've tested that files with same content but different names have same checksums

md5sum(downloaded) %>% duplicated() %>% table ## Check complete no duplciates 



### Let's download 5 random MCS files and manually and check their contents (WIP)
set.seed(123)
downloaded[sample.int(313, size = 5)]
## Test these: 
# "data/North Lincolnshire.zip" 
# "data/Bassetlaw.zip"          
# "data/Peterborough.zip"       
# "data/Woking.zip"            
# "data/Harrogate.zip"     

QA_dl <- list.files('QA test', full.names = T)

md5sum(QA_dl) %in% md5sum(downloaded) 
## Result: cannot do this (likely due to the realtime nature of the MCS dashboard)
## manually check first few rows? 

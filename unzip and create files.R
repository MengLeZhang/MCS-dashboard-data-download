## utils to run first 

## packages to load 


## unzip
downloaded <- list.files('data', full.names = F)
downloaded <-
  downloaded[downloaded %>% grepl(pattern = '\\.zip')] ## only keep zip files

## create directories and unzip
unzip_this <- 
  function(zipFilename){
    
    zipFilename_noExt <- zipFilename %>% gsub(pattern = '.zip', replacement ='')
    
    out_dir <- file.path('data/unzipped data', zipFilename_noExt)
    out_dir %>% dir.create()
    
    file.path('data', zipFilename) %>% unzip(exdir = out_dir)
    
    
    out_dir <- NULL
    
  } 

## now run and catch any warnings
errors <- list(NULL)
for (this_zip in downloaded){
  errors[[this_zip]] <-
  tryCatch(
    unzip_this(this_zip),
    error=function(e) e, warning=function(w) w
  )
  
}

## okay no major errors -- slight warning because it chooses the unzipped folder


# Create files in table format --------------------------------------------

list.dirs('data/unzipped data', full.names = F)
las <- downloaded %>% gsub(pattern = '.zip', replacement ='')
names(las) <- las ## creating named vector for later functions

## Solar panels

## each zip has a technology by month so needs to be identified

solar_pv_filename <- 
  'Monthly_Installation_Timeline_Records_Solar_PV.csv'

## Read it all and catch errors 

solar_pv_tab <-
  las %>% 
  map_dfr(
    .f = function(la_name){
      tryCatch(
        file.path('data/unzipped data', 
                  la_name, 
                  solar_pv_filename) %>% 
          read_csv(),
        error=function(e) e, warning=function(w) w
      )
    },
    .id = 'la'
  )


## QA the data
solar_pv_tab %>% head()
solar_pv_tab %>% summary ## col 3 is entirely empty 


solar_pv_tab <-
  solar_pv_tab %>% select(-...3) %>% mutate(tech = 'solar pv')

## save
write_csv(solar_pv_tab, 'outputs/solar pv by la (mcs).csv')

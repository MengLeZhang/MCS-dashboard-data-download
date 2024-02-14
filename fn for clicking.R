## fn for repeated dling from la list

## click la box, checkbox, get rid of box

la_box <- 
  function(la_n){
    
    ## Check LA box
    drop_la_xpath = '/html/body/div[1]/section/section/aside[1]/div/ul/li[2]/ul/li[2]/span/div/div/label'
    drop_la = remDr$findElement(using = 'xpath', drop_la_xpath)
    drop_la$clickElement()
    
    Sys.sleep(runif(1, min = 2, max = 5))
    

    ## check box 
    la_checkbox_xpath <-
      paste0('/html/body/div[2]/div[2]/ul/li[', la_n, ']') ## we can add /div/div for the checkbox img itself but not needed
    
    
    this_la = la_checkbox_xpath %>% remDr$findElement(using = 'xpath') 
    la_name = this_la$getElementText() ## la name
    this_la$clickElement()
    
    Sys.sleep(runif(1, min = 3, max = 6))
    
    ## uncheck LA box
    drop_la = remDr$findElement(using = 'xpath', drop_la_xpath)
    drop_la$clickElement()
    
    Sys.sleep(runif(1, min = 8, max = 13))
    
    return(la_name)
  }

### function to click the download button, save a file and rename it to an LA name

dl_and_rename <-
  function(la_name){
    
    ## hover over the download button
    dl_img = 
      '/html/body/div[1]/section/section/main/div[2]/div/div/div/div[2]/div[2]/div/button/span/img' %>%
      remDr$findElement(using = 'xpath') 
    dl_img$clickElement()
    
    Sys.sleep(runif(1, min = 2, max = 4))
    
    ## manually hover -- we need the popup to show 
    dl_button_xpath = '/html/body/div/section/section/main/div[2]/div/div/div/div[2]/div[2]/div/ul/li[2]/a'
    dl_button = remDr$findElement(using = 'xpath', dl_button_xpath)
    dl_button$clickElement()
    
    Sys.sleep(runif(1, min = 8, max = 12))
    
    ## step 5: Rename the file
    
    file.rename(
      from = 'C:/Users/Meng-Le/Downloads/MCS_installation_timeline_chart_data.zip', 
      to = paste0('data/',la_name, '.zip') ## renames and send the file to this folder
    )
    
    Sys.sleep(runif(1, min = 1, max = 2))
    
  }
dl_and_rename('Allerdale')
dir.exists('data')

### put the two functions together 



mcs_dashboard_loop <-
  function(la_n){
    
    default_mcs_file = 
      'C:/Users/Meng-Le/Downloads/MCS_installation_timeline_chart_data.zip'
    if(
      file.exists(default_mcs_file)
       ){
      file.remove(default_mcs_file)
    }
    
    ## check LA
    la_name <- la_box(la_n)

    ## download and rename
    dl_and_rename(la_name)
    
    ## uncheck la for next loop
    la_box(la_n)
    
    did_it_dl <- file.exists(
      paste0('data/',la_name, '.zip') 
    )
    
    return(
      ifelse(did_it_dl, 
             la_name %>% paste('downloaded'),
             paste('Error:', la_name, 'not downloaded')
             )
    )
  }

# test first to check
mcs_dashboard_loop(151 + 19)

## loop
log <-
  map(
    .x = 250:313,
    .f = mcs_dashboard_loop
  )
 
log %>% grepl(pattern = 'not downloaded') %>% table 
## each file should be like <10kb
## lancaster not dled
## had to redl lancaster
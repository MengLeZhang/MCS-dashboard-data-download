### download dashboard data 

## load functions
source('utils.R')


## Step 1: Opens firefox and navigates to dashboard
rD <- rsDriver(browser="firefox", port=4545L, verbose=F, chromever= NULL)
remDr <- rD[["client"]]
remDr$navigate("https://datadashboard.mcscertified.com/InstallationInsights")


print('Now manually sign in')

## Step 2: Click England 

eng_button_xpath = '/html/body/div/section/section/aside[1]/div/ul/li[2]/ul/div/div/div/label[1]/span[1]/span'
england_button = remDr$findElement(using = 'xpath', eng_button_xpath)
england_button$clickElement()

## Step two: click the drop down menu -- need to wait till the element shows 

drop_la_xpath = '/html/body/div[1]/section/section/aside[1]/div/ul/li[2]/ul/li[2]/span/div/div/label'
drop_la = remDr$findElement(using = 'xpath', drop_la_xpath)
drop_la$clickElement()

## step three: Loop the clicking, download and file renameing
## See function in utils.R 

### First there is a bizzare bug; we must click around in the box twice to get things to work
la_box(1); la_box(1)

## by default it locate teh download folder on my comptuer -- change to yours 
## Test run 1st LA = adur
# mcs_dashboard_loop(1)

## Run with option to output messages to a log
log <-
  map(
    .x = 1:313, ## or do it in chunch, e.g. 1:50 then 51:100 etc
    .f = mcs_dashboard_loop
  )

### Check everything is downloaded
log %>% grepl(pattern = 'not downloaded') %>% table 




### end loop 
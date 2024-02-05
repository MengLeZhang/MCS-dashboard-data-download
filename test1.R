
library(tidyverse)
library('RSelenium')


rD <- rsDriver(browser="firefox", port=4545L, verbose=F, chromever= NULL)
remDr <- rD[["client"]]
## should open a new browser 
### login to the MCS dashboard 
## https://datadashboard.mcscertified.com/InstallationInsights

## goal we want to download data 
remDr$navigate("https://datadashboard.mcscertified.com/InstallationInsights")


# rsDriver(chromever= NULL, port = 4444L) # search for and download Selenium Server java binary.  Only need to run once. -- 
# 
# 
# ## starts startServer() # run Selenium Server binary
# remDr <- remoteDriver(browserName="firefox", chromever= NULL ,port=6666) # instantiate remote driver to connect to Selenium Server
# remDr$open(silent=T) # open web browser


## Step one: Click England 

eng_button_xpath = '/html/body/div/section/section/aside[1]/div/ul/li[2]/ul/div/div/div/label[1]/span[1]/span'
england_button = remDr$findElement(using = 'xpath', eng_button_xpath)
england_button$clickElement()

## Step two: click the drop down menu -- need to wait till the element shows 

drop_la_xpath = '/html/body/div[1]/section/section/aside[1]/div/ul/li[2]/ul/li[2]/span/div/div/label'
drop_la = remDr$findElement(using = 'xpath', drop_la_xpath)
drop_la$clickElement()


## step three: click the xpath 
## The xpath seems to follow a pattern where li[N] where N is the id of the tick box
## '/html/body/div[2]/div[2]/ul/li[4]/div/div' ## example this is the example 
## last element is york 
## /html/body/div[2]/div[2]/ul/li[313] -- 313 


## Get the name of 

la_checkbox_xpath_list <-
  paste0('/html/body/div[2]/div[2]/ul/li[', 1:313, ']') ## we can add /div/div for the checkbox img itself but not needed



this_la = la_checkbox_xpath_list[1] %>% remDr$findElement(using = 'xpath') 

la_name = this_la$getElementText(); la_name %>% print()


this_la$clickElement() ## click 
# this_la$clickElement() ## click again to uncgeck 

## Click 

## Step 4: hover over the download button
dl_img = 
  '/html/body/div[1]/section/section/main/div[2]/div/div/div/div[2]/div[2]/div/button/span/img' %>%
  remDr$findElement(using = 'xpath') 
dl_img$clickElement()


## manually hover -- we need the popup to show 
dl_button_xpath = '/html/body/div/section/section/main/div[2]/div/div/div/div[2]/div[2]/div/ul/li[2]/a'
dl_button = remDr$findElement(using = 'xpath', dl_button_xpath)
dl_button$clickElement()

## step 5: 

file.rename(
  from = 'C:/Users/Meng-Le/Downloads/MCS_installation_timeline_chart_data.zip', 
  to = paste0(la_name, '.zip') ## renames and send the file to this folder
  )

## step 6: to restart uncheck the LA
drop_la_xpath = '/html/body/div[1]/section/section/aside[1]/div/ul/li[2]/ul/li[2]/span/div/div/label'
drop_la = remDr$findElement(using = 'xpath', drop_la_xpath)
drop_la$clickElement()

## Get the name of 

la_checkbox_xpath_list <-
  paste0('/html/body/div[2]/div[2]/ul/li[', 1:313, ']') ## we can add /div/div for the checkbox img itself but not needed



this_la = la_checkbox_xpath_list[1] %>% remDr$findElement(using = 'xpath') 

la_name = this_la$getElementText(); la_name %>% print()


this_la$clickElement() ## click 


### close box@
drop_la = remDr$findElement(using = 'xpath', drop_la_xpath)
drop_la$clickElement()



### end loop 
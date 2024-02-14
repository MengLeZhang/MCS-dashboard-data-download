# Microgeneration Certification Scheme (MCS) dashboard download 

Part of the 'Decarbonisation of Heat' project

The [MCS dashboard ](https://datadashboard.mcscertified.com/) holds data on small-scale renewable installations (examples: heat pumps, solar panels) accredited by the MCS scheme. The dashboard allows users to view and download data on installations over time for local authorities in the UK. However there is no API or batch download file so users are left to manually download data (there over 300 local authorities).  This repository uses R scripts to:

1. automatically navigate the MCS dashboard and download data using Selenium (a web automation tool, via the Rselenium package)
2. manipulate the MCS data for all English LAs into a table format for easier analysis 

Note the MCS dashboard was launched in 2023 and may be updated over time (the MCS is not affliated with this project). These scripts work as of 14 Feburary 2024 but may need to be amended to reflect any changes (dashboard layout, licensing). 
## Setup and usage

Requires:
- R (> version 4.0)
- Rstudio
- R packages:
	- tidyverse
	- Rselenium

Also requires a user account to access the MCS dashboard (register [here](https://datadashboard.mcscertified.com)). 

After signing into the dashboard, users can use script XX which will select the nessecary checkboxes to:
- Restrict data by England
- Open the open box to select individual local authorities (see below) 

![[Pasted image 20240214133035.png]]

Then the script will loop these actions for every local authority in England (n = 313 on dashboard):
- select a local authority
- click the download button to download the installations over time data
- renames the downloaded file and moves it to `/data` 
- unselects the local authority (for the next local authority)

There is a delay between actions to adjust for network speeds and to avoid innudating the MCS dashboard with requests. 


Script YY 
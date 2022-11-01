################################################################################
###   Author: Sean Chew
###   PURPOSE:
################################################################################

### Set Environment ------------------------------------------------------------
# Clear the environment
rm(list=ls())
gc()
# So the code will compile warnings as per usual
options(warn = 0)
# So that text data is not read in as factors
options(stringsAsFactors = F)
# Turn off scientific notation
options(scipen = 999)
### Load Packages --------------------------------------------------------------

if(!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, magrittr, stringr, reshape2, janitor,
lubridate, readxl, data.table, ggplot2, scales, readr,
tidyr, zoo, skimr, openxlsx,ggspatial, rgeos, data.table,RColorBrewer,
tidyverse, rio, collapse, sf, glue, XML, tm, here, purrr, repurrrsive,
tmap,tidygraph, nabor,igraph, viridis, hrbrthemes,RSocrata,soql)

### Begin Code -----------------------------------------------------------------


### Entire dataset for earlier year:

# "Joined" (rent stabilized) (only has up until 2017)
# "subsidized housing" (only has 2018)

### Entire dataset for most recent:
#https://portal.displacementalert.org/district-dashboard/community/107 
# Download Rent stbilized and subsidized.

subsidized_today <- read_csv("./data/subsidized_today.csv")%>% 
    select(c("BBL","Rent Stabilized Units"))

rent_stabilized_today <- read_csv("./data/rent_stabilized_today.csv") %>% 
    select(c("BBL","Rent Stabilized Units"))

today <- bind_rows(subsidized_today,rent_stabilized_today) %>% 
    clean_names() %>% 
    group_by(bbl)%>% 
    summarise(subsidized_today = sum(rent_stabilized_units))

sum(today$n)

# subsidized_today <- read_csv("./data/subsidized_today.csv")%>% 
#     select(c("BBL","Total Units"))
# 
# rent_stabilized_today <- read_csv("./data/rent_stabilized_today.csv") %>% 
#     select(c("BBL","Total Units"))
# 
# today <- bind_rows(subsidized_today,rent_stabilized_today) %>% 
#     clean_names() %>% 
#     group_by(bbl)%>% 
#     summarise(n = sum(total_units))
# 
# sum(today$n)

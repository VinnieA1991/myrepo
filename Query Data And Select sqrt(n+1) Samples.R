############ Install Packages

install.packages('odbc')
install.packages('DBI')
install.packages('RSQLite')
install.packages('tidyverse')


############ Load library

library(DBI)
library(odbc)
library(sqldf)
library(dplyr)
library(tidyverse)
library(RSQLite)


############ Connect to DB 

con <- dbConnect(odbc::odbc(), .connection_string = "Driver={SQL Server};server=az-demo01.yprimecloud.local;
          database=bms_ca209-73L;trusted_connection=true,timeout = 10")

############ Query Table


DrugKits_By_Site <- dbGetQuery(con, "Select drugkitnumber
                          , s.sitenumber
                          from drug d 
                          left join site s on
                          d.siteid = s.id
                          order by s.sitenumber
                         ")

############ Split Data by Site

split_list <-split(DrugKits_By_Site, DrugKits_By_Site$sitenumber)
Site0000 <- as.data.frame(split_list[[1]])

############ Count Observations

Site0000_Count <- as.integer(count(Site0000))

############ Add Rand

Site0000$Kit = c(1:Site0000_Count)
Site0000$Rand = sample(Site0000$Kit, Site0000_Count, replace=FALSE)

############ Randomly select for sqrt(n+1) samples

nsample <- round(sqrt(Site0000_Count+1))
Site0000_Test_Samples <- Site0000 %>% filter(Rand <= nsample)



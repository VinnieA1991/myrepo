#Transforming the (complete) SDTM --DTC variable from ISO 8601 format into the numeric analysis
#date, time, and datetime (ADaM ADT, ATM, ADTM). For example, AESTDTC=2021-01-18T12:00:00.

library(tidyverse)
library(lubridate)
library(dplyr)
library(tidyr)

df <- data.frame(AESTDTC = "2021-01-18T12:00:00")

df2 <- df %>%
  separate(AESTDTC, c("ADTC", "ATMC"),sep="T",remove=FALSE) %>%
  mutate(ADTM = ymd_hms(AESTDTC),
         ADT=ymd(ADTC),
         ATM=hms(ATMC)) %>%
  select(-ADTC,-ATMC)
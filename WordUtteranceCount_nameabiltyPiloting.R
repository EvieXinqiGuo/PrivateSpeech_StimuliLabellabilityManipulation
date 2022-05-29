library(tidyverse)
library(dplyr)
library(stringr)
#### apply the same logic of word count and utterance count
setwd("/Users/guoxinqieve/Applications/OneDrive - UC San Diego/Spring2022_nameability_pilot transcription")
L = list.files("/Users/guoxinqieve/Applications/OneDrive - UC San Diego/Spring2022_nameability_pilot transcription", ".csv")
O = lapply(L, function(x) {
  DF = read.csv(x, header = T, na.strings=c("","NA"), sep = ",")
  DF1 = DF %>%
    mutate(wordCountTrial5 = sum(str_count(Trial5, "\\w+"), na.rm = T),
           wordCountTrial6 = sum(str_count(Trial6, "\\w+"), na.rm = T),
           wordCountTrial7 = sum(str_count(Trial7, "\\w+"), na.rm = T),
           wordCountTrial8 = sum(str_count(Trial8, "\\w+"), na.rm = T),
           wordCountTrial9 = sum(str_count(Trial9, "\\w+"), na.rm = T),
           wordCountTrial10 = sum(str_count(Trial10, "\\w+"), na.rm = T),
           wordCountTrial11 = sum(str_count(Trial11, "\\w+"), na.rm = T),
           wordCountTrial12 = sum(str_count(Trial12, "\\w+"), na.rm = T),
           
           utteranceCountTrial5 = nrow(na.omit(as.data.frame(Trial5))),
           utteranceCountTrial6 = nrow(na.omit(as.data.frame(Trial6))),
           utteranceCountTrial7 = nrow(na.omit(as.data.frame(Trial7))),
           utteranceCountTrial8 = nrow(na.omit(as.data.frame(Trial8))),
           utteranceCountTrial9 = nrow(na.omit(as.data.frame(Trial9))),
           utteranceCountTrial10 = nrow(na.omit(as.data.frame(Trial10))),
           utteranceCountTrial11 = nrow(na.omit(as.data.frame(Trial11))),
           utteranceCountTrial12 = nrow(na.omit(as.data.frame(Trial12)))

           ) %>%
    
    select(wordCountTrial5, wordCountTrial6, wordCountTrial7, wordCountTrial8, 
           wordCountTrial9, wordCountTrial10, wordCountTrial11, wordCountTrial12,
           
           utteranceCountTrial5, utteranceCountTrial6, 
           utteranceCountTrial7, utteranceCountTrial8,
           utteranceCountTrial9, utteranceCountTrial10,
           utteranceCountTrial11, utteranceCountTrial12
           ) %>%
    distinct() 
  return(DF1)})

merged_df =  do.call(rbind, O)
merged_df = cbind(as.data.frame(L) ,merged_df)

write.csv(merged_df,"/Users/guoxinqieve/Applications/OneDrive - UC San Diego/Spring2022_nameability_pilot transcription/processed_everyone/wordUtteranceCountEveryone_nameability_pilot.csv", row.names = FALSE)

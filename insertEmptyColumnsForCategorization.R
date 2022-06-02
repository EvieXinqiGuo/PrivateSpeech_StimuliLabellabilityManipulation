### this R script will not go into the main rmd file since this is just preparing the CSV files
#### 1. load all the data files
#### 2. do the batch processing
#### 3. save the files

setwd("/Users/guoxinqieve/Applications/OneDrive - UC San Diego/Spring2022_nameability_pilot transcription/types/categorizing process with raw data")
Participants = list.files("/Users/guoxinqieve/Applications/OneDrive - UC San Diego/Spring2022_nameability_pilot transcription/types/categorizing process with raw data", ".csv")

tmp <- read.csv("original_file.csv")
tmp <- cbind(tmp, new_column)
write.csv(tmp, "modified_file.csv")

O = lapply(Participants, function(x) {
  DF = read.csv(x, header = T, na.strings=c("","NA"), sep = ",")
  DF1 = DF %>%
    mutate(wordCountTrial3 = sum(str_count(Trial3, "\\w+"), na.rm = T),
           wordCountTrial4 = sum(str_count(Trial4, "\\w+"), na.rm = T),
           utteranceCountTrial3 = nrow(na.omit(as.data.frame(Trial3))),
           utteranceCountTrial4 = nrow(na.omit(as.data.frame(Trial4)))) %>%
    select(wordCountTrial3, wordCountTrial4, utteranceCountTrial3, utteranceCountTrial4) %>%
    distinct() 
  return(DF1)})

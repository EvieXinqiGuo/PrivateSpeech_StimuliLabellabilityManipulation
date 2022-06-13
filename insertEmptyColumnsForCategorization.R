### this R script will not go into the main rmd file since this is just preparing the CSV files
#### 1. load all the data files
#### 2. do the batch processing
#### 3. save the files

setwd("/Users/guoxinqieve/Applications/OneDrive - UC San Diego/Spring2022_nameability_pilot transcription/types/categorizing process with raw data")
Participants = list.files("/Users/guoxinqieve/Applications/OneDrive - UC San Diego/Spring2022_nameability_pilot transcription/types/categorizing process with raw data", ".csv")
 
O = lapply(Participants, function(x) {
  DF = read.csv(x, header = T, na.strings = c("","NA"), sep = ",")
  newstuff_df <- data.frame(Categorized5 = double(), 
                            Categorized6 = double(), 
                            Categorized7 = double(),
                            Categorized8 = double(), 
                            Categorized9 = double(), 
                            Categorized10 = double(), 
                            Categorized11 = double(), 
                            Categorized12 = double())
  DF1 = rbind(DF, new_column)
  return(DF1)
  write.csv(x, file = paste0("categorizing_", x, row.names = FALSE))
})

O

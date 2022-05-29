##
library(tidyverse)
library(dplyr)
##### load data
##### combine performance and transcribed data
raw_perforamance = read_csv("/Users/guoxinqieve/Applications/OneDrive - UC San Diego/WinterSpring2022_TotalTapTime.csv")
wordUtterance = read_csv("/Users/guoxinqieve/Applications/OneDrive - UC San Diego/WinterSpring2022_NNPP_transcription/processed_everyone/wordUtteranceCountEveryone.csv")
##### see if there is an performance reversal effect

performance = raw_perforamance %>%
  
#### processing data - getting rid of outliers
####   

library(data.table)
library(stringr)
library(tidyverse)
setwd("/Users/guoxinqieve/Desktop/RawStimulusSelection")
getwd()
files <- list.files(pattern = ".csv")
temp <- lapply(files, fread, sep = ",") 
data = rbindlist(temp, fill = TRUE)
write.csv(data, file = "merged.csv", row.names = FALSE)
merged_df = read_csv("/Users/guoxinqieve/Applications/OneDrive - UC San Diego/RawStimulusSelection/merged.csv")

# 1. outliers
# 2. 
a <- ggplot(merged_df, aes(x = keyActual.rt))
# y axis scale = ..density.. (default behaviour)
density_keyActual.rt =  a + geom_density() +
  geom_vline(aes(xintercept = mean(keyActual.rt)), 
             linetype = "dashed", size = 0.6)

cleaned_df = merged_df %>%
  select(ImageFile, keyActual.rt) %>%
  mutate(mean_rt = mean(keyActual.rt, na.rm = T), sd_rt = mean(keyActual.rt, na.rm = T)) %>%
  filter(keyActual.rt <= mean_rt + 3*sd_rt & keyActual.rt >= mean_rt - 3*sd_rt)


cleaned_density_Actual.rt = ggplot(cleaned_df, aes(x = keyActual.rt)) + geom_density() +
  geom_vline(aes(xintercept = mean(keyActual.rt)), 
             linetype = "dashed", size = 0.6) +
  ggtitle("Density of Time \n After Removing Data 3 SDs Away") +
  xlab("Time Taken to Label or Describe") + ylab("Density")
  
grouped_df = cleaned_df %>%
  group_by(ImageFile) %>%
  mutate(ImageMeanRT = mean(keyActual.rt, na.rm = T))

topQuartileCutoff = quantile(grouped_df$ImageMeanRT)[2]
bottomQuartileCutoff = quantile(grouped_df$ImageMeanRT)[4]

grouped_df$name = str_sub(grouped_df$ImageFile, nchar("/Users/dobkinslab/Desktop//tangramActualStiSelection/")+1)
grouped_df$name = gsub(".png", "", grouped_df$name)



plot1 <- grouped_df %>% 
  ggplot(aes(x=reorder(name, keyActual.rt, FUN = mean), fill=name, color=name, y=keyActual.rt))+
  geom_jitter(width=0.25, size = 0.75, alpha=0.7)+
  stat_summary(fun.data = mean_se,
               geom="pointrange", 
               fatten = 2,
               size=1)+
  scale_y_continuous('Time (second +/1 sem)', breaks = seq(0, 15, by=1))+
  theme_minimal()+
  theme(legend.position = 'none') +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=0.5))+
  xlab("name") +
  ggtitle("Rank of Average Time for Name \n with Top and Bottom Quartile Cutoffs") +
  geom_hline(yintercept = c(topQuartileCutoff,bottomQuartileCutoff))

topQuartile = grouped_df %>%
  ungroup() %>%
  filter(ImageMeanRT <= topQuartileCutoff) %>%
  mutate(rank = dense_rank(ImageMeanRT)) %>%
  mutate(namerank = dense_rank(name)) %>%
  select(name, rank, namerank) %>%
  distinct() %>%
  mutate(oldFileName = paste(name, ".png", sep ="")) %>%
  mutate(newFileName = paste(rank,oldFileName, sep = "_"))

bottomQuartile = grouped_df %>%
  ungroup() %>%
  filter(ImageMeanRT >= bottomQuartileCutoff)  %>%
  mutate(rank = dense_rank(desc(ImageMeanRT))) %>%
  mutate(namerank = dense_rank(name)) %>%
  select(name, rank, namerank) %>%
  distinct() %>%
  mutate(oldFileName = paste(name, ".png", sep ="")) %>%
  mutate(newFileName = paste(rank,oldFileName, sep = "_"))

bottomQuartile = bottomQuartile[order(bottomQuartile$namerank),]
topQuartile = topQuartile[order(topQuartile$namerank),]
################ 
# Define working directory
working_directory <- "/Users/guoxinqieve/Applications/OneDrive - UC San Diego/tangram 3/easy/easy_all"
getwd()
setwd("/Users/guoxinqieve/Applications/OneDrive - UC San Diego/tangram 3/easy/easy_all")
# get list of current file
# names as character vector current_files
current_files <- list.files(working_directory)

# get file names after renaming
# as character vector new_files
new_files <- topQuartile$newFileName

setdiff(topQuartile$oldFileName, current_files)

# Use file.rename() function to rename files
file.rename(from = current_files, to = new_files)

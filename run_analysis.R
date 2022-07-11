## load packages
library(tidyverse)
library(data.table)

## read in and merge the data

unzip("data/getdata_projectfiles_UCI HAR Dataset.zip", exdir = "data")

testdf <- read.table("data/UCI HAR Dataset/test/X_test.txt") %>% 
  mutate(
    type = "test"
  )
traindf <- read.table("data/UCI HAR Dataset/train/X_train.txt") %>% 
  mutate(
    type = "train"
  )

data <- merge(testdf, traindf, all = TRUE)

## extract only the measurements on mean and standard deviation


## load packages
library(tidyverse)
library(data.table)

## step 1: read in and merge the data

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

## step 2: extract only the measurements on mean and standard deviation

variablenames <- read.table("data/UCI HAR Dataset/features.txt")
names(data) <- variablenames[ ,2]

data1 <- data[ ,grepl("mean|std", names(data))]

## step 3: use descriptive activity names to name the activities in the data set

test_activities <- read.table("data/UCI HAR Dataset/test/y_test.txt")
train_activities <- read.table("data/UCI HAR Dataset/train/y_train.txt")

activities <- c(test_activities[ ,1], train_activities[ ,1])

data1 = 
  data1 %>% 
  mutate(
    activity = activities,
    activity = as.factor(activity),
    activity = recode_factor(activity, "1" = "walking", "2" = "walking_upstairs", "3" = "walking_downstairs",
                             "4" = "sitting", "5" = "standing", "6" = "lying")
  )

## step 4: descriptive variable names [see step 2]
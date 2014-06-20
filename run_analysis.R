# name :  run_analysis.R
# Author : Saravanakumar S
# Date : 17-June-2014
# Course : Getting and Cleaning the data - Course Project
# Objective  : The purpose of this project is to demonstrate your ability to collect, work with, 
# and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
# Algorithm :
# Create one R script called run_analysis.R that does the following. 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#--------------------------------------------------------------------------------------------------------------------

file <- "getdata-projectfiles-UCI HAR Dataset.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Input_folder <- "UCI HAR Dataset"
base_dir <- getwd()

## Create data and folders 
if(!file.exists(file)){
  ##Downloads the data file
  print("Downloading the I/p Data...")
  download.file(url,file, mode = "wb")
  unzip(file,exdir="Data")
}

setwd("./Data/UCI HAR Dataset")
base_dir <- getwd()

if(!file.exists("Output")){
  print("Creating the output folder...")
  dir.create("Output")
} 

## Goals of Tidy data
## 1. Each variable should be in one column
## 2. Each observation of that variable should be in a diferent row
## 3. Include ids to link tables together

data.set = list()
Finaldata.set = list()

#Creating the data set for features.txt
message("Creating the data set for features.txt...")
data.set$features <- read.table(paste(base_dir,"features.txt",sep="/"),col.names=c("Id","Names"),stringsAsFactors=FALSE)

#Creating the data set for activity_labels.txt
message("Creating the data set for activity_labels.txt")
data.set$activity_labels <- read.table(paste(base_dir,"activity_labels.txt",sep="/"),col.names=c("Activity_Id","Activity_Name"),stringsAsFactors=FALSE)

#Creating the data set for test
message("Creating the data set for test...")
data.set$x_test <-  read.table(paste(base_dir,"test/X_test.txt",sep="/"))
data.set$y_test <- read.table(paste(base_dir,"test/Y_test.txt",sep="/"),col.names="Activity_id")
data.set$sub_test <- read.table(paste(base_dir,"test/subject_test.txt",sep="/"),col.names="Subject_id")
testing <- cbind(data.set$sub_test,data.set$y_test)

#Creating the data set for test
message("Creating the data set for train...")
data.set$x_train <-  read.table(paste(base_dir,"train/X_train.txt",sep="/"))
data.set$y_train <- read.table(paste(base_dir,"train/Y_train.txt",sep="/"),col.names="Activity_id")
data.set$sub_train <- read.table(paste(base_dir,"train/subject_train.txt",sep="/"),col.names="Subject_id")
training = cbind(data.set$sub_train,data.set$y_train)

#Getting the relevant ids to be extracted from features with keywords as "mean" and "std"
extracted_ids <- grep('mean\\(|std\\(',data.set$features$Names)

#Combine test and train data... Also extract only related features corresponding to extracted ids in the previous step
Extracted_data <- rbind(data.set$x_test[,extracted_ids],data.set$x_train[,extracted_ids])
Act_data <- rbind(testing,training)
Extracted_data <- cbind(Act_data,Extracted_data)

#Changing the columns names by removing the prefix "V"
col_names <- c("Subject","Activity",data.set$features[extracted_ids,2])
library("stringr")
colnames(Extracted_data) <- sapply(col_names, function(x) str_replace_all(x, "\\(\\)|-",""))

#Changing the names of activities from activities label list
Extracted_data$Activity <- factor(Extracted_data$Activity,levels=data.set$activity_labels$Activity_Id,labels=data.set$activity_labels$Activity_Name)

#Writing the tidy data into the file
write.csv(Extracted_data,paste(base_dir,"tidy_data.csv",sep="/Output/"))

#Calculating the mean on all variables for each activity and each subject
calc_mean <- aggregate(Extracted_data,by=list(Subject=Extracted_data$Subject,Activity=Extracted_data$Activity),FUN=mean)

calc_mean <- subset(calc_mean,select = -c(3,4))

colnames(calc_mean)[-c(1:2)] <- paste("Mean",colnames(calc_mean)[-c(1:2)],sep=" -" )

#Writing the second set of data into csv file
write.csv(calc_mean,paste(base_dir,"tidy_data2.csv",sep="/Output/"))

                                                  
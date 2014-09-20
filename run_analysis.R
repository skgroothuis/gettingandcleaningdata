#
# File Name: run_analysis.R
# Course: Getting and Cleaning Data (getdata-007)
#
#  The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
#  The goal is to prepare tidy data that can be used for later analysis. 
#  You will be graded by your peers on a series of yes/no questions related to the project. 
#  You will be required to submit: 
#
#     1) a tidy data set as described below, 
#     2) a link to a Github repository with your script for performing the analysis, and 
#     3) a code book that describes the variables, the data, and any transformations or work 
#        that you performed to clean up the data called CodeBook.md. You should also include a 
#        README.md in the repo with your scripts. This repo explains how all of the scripts 
#        work and how they are connected.  
#
#  Course Project Requirements
#  Here are the data for the project: 
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
#  You should create one R script called run_analysis.R that does the following.
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names. 
#  5. From the data set in step 4, creates a second, independent tidy data set with the 
#     average of each variable for each activity and each subject.
#

# PACKAGES INSTALLED
install.packages("plyr")

# LIBRARIES
library(plyr)

# DATA EXTRACTION FROM UCI HAR AND LOAD IN ./DATA
if(!file.exists("./data")){dir.create("./data")}
OrigDataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- paste("./data/", basename(OrigDataURL),sep = "")
download.file(OrigDataURL, file)
unzip(file, exdir = "./data")

# SETTING UP THE PATH VARIABLES FOR DATA EXTRACTION
dataDir <- "./data/UCI HAR Dataset"
testDataDir <- paste(dataDir, "/test", sep = "")
trainDataDir <- paste(dataDir, "/train", sep = "")

#----------------------------------------------------------------
# LOADING ALL APPROPRIATE DATA
#----------------------------------------------------------------
# 1: LOADING GENERAL DATA IN THE R WORKSPACE
features <- read.table(paste(dataDir, "/features.txt", sep = ""))
activityLabels <- read.table(paste(dataDir, "/activity_labels.txt", sep = ""))

# 2: LOADING THE TESTING DATA
XTest <- read.table(paste(testDataDir, "/X_test.txt", sep = ""))
yTest <- read.table(paste(testDataDir, "/y_test.txt", sep = ""))
subjectTest <- read.table(paste(testDataDir, "/subject_test.txt", sep = ""))

# 3: LOADING THE TRAINING DATA
XTrain <- read.table(paste(trainDataDir, "/X_train.txt", sep = ""))
yTrain <- read.table(paste(trainDataDir, "/y_train.txt", sep = ""))
subjectTrain <- read.table(paste(trainDataDir, "/subject_train.txt", sep = ""))

#----------------------------------------------------------------
# ADDING LABELS TO DATA
#----------------------------------------------------------------
# 1: ADDING LABELS TO THE ORGINAL TESTING DATA
features <- arrange(features,V1)
colnames(XTest)<- features$V2

# 2: ADDING LABELS TO THE ORIGINAL TRAINING DATA
features <- arrange(features,V1)
colnames(XTrain)<- features$V2

#----------------------------------------------------------------
# MERGING APPROPRIATE DATA
#----------------------------------------------------------------
# 1: MERGING TESTING SUBJECT DATA TO THE TESTING DATA
testData <- cbind(subjectTest,XTest)
colnames(testData)[1] <- "test_subject"

# 2: MERGING TESTING SUBJECT DATA TO THE TRAINING DATA
trainData <- cbind(subjectTrain,XTrain)
colnames(trainData)[1] <- "test_subject"

#----------------------------------------------------------------
# JOINING ALL APPROPRIATE FILES
#----------------------------------------------------------------
# 1: JOINING ACTIVITY DATA WITH TESTING TEST SUBJECTS 
testActivity <- join(yTest, activityLabels, by="V1")

# 2: JOINING ACTIVITY DATA WITH TRAINING TEST SUBJECTS 
trainActivity <- join(yTrain, activityLabels, by="V1")

# 3: JOINING ACTIVITY DATA WITH WITH THE OVERALL TEST DATA SET
testData <- cbind(testActivity, testData)
colnames(testData)[1] <- "activity_number"
colnames(testData)[2] <- "activity_label"

# 4: JOINING ACTIVITY DATA WITH WITH THE OVERALL TRAINING DATA SET
trainData <- cbind(trainActivity, trainData)
colnames(trainData)[1] <- "activity_number"
colnames(trainData)[2] <- "activity_label"

#----------------------------------------------------------------
# MERGING TESTING & TRAINING DATA
#----------------------------------------------------------------
# MERGING THE TESTING AND THE TRAINING DATA SETS
MergedData <- rbind(testData, trainData)
#----------------------------------------------------------------
# WORKING THE DATA STATISTICS
#----------------------------------------------------------------
# EXTRACTING ONLY COLUMNS WITH MEAN AND STD. DEV FOR EACH COLUMN
meanRegEx <- grep(("*.-mean[()].*"),colnames(MergedData))
stdRegEx <- grep(("*.-std[()].*"),colnames(MergedData))
MergedDataIndicators<- MergedData[, c(2:3,meanRegEx,stdRegEx)]

#----------------------------------------------------------------
# CREATING THE TIDY DATA SET
#----------------------------------------------------------------
# TAKING THE AVERAGE OF EACH COLUMN GROUPED BY EACH ACTIVITY AND BY EACH SUBJECT.
tidyDataSet <- aggregate(MergedDataIndicators[,3:68], by =list(MergedDataIndicators[,1], MergedDataIndicators[,2]), FUN = mean, na.rm = TRUE)
colnames(tidyDataSet)[1] <- "activity_label"
colnames(tidyDataSet)[2] <- "test_subject"

#----------------------------------------------------------------
# WRITING THE TIDY DATA SET
#----------------------------------------------------------------
# WRITING THE TIDY DATA SET IN .TXT
write.table(tidyDataSet, file ="./TidyData.txt",row.names=FALSE,sep=",")

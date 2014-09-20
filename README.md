UCI-HAR-DataPrep
================

### BACKGROUND
One of the most exciting areas in all of data science right now is wearable computing - <a href= "http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/"> see example here</a> . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. This project will utilize data from the Samsung Galaxy S smartphone collected by the <a href= "http://cml.ics.uci.edu/">University of California Irvine (UCI) Center for Machine Learning and Intelligent Systems</a>.  

### PURPOSE AND SCOPE
The purpose of this project is to to collect, work with, and clean a data set. The data set that will be used for this project can be found on the <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "> UCI Machine Learning Repository</a> and is named *Human Activity Recognition Using Smartphones Data Set* version 1.0.   

The goal is to prepare tidy data that can be used for later analysis. This project is done solely in the R programming language. This was done for the final project of the *Getting and Cleaning Data* course from the John Hopkins Bloomberg School of Public Health offered through Coursera.  

### COURSE PROJECT REQUIREMENTS
  You should create one R script called run_analysis.R that does the following.
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the 
     average of each variable for each activity and each subject.
  
### OTHER DOCUMENTS
The other documents in this repository are:   
**./README.md** - This file, which provides some context to the project.  
**./CodeBook.md** - A code book that should be referred to when reusing, reproducing or extending any of this work.   
**./run_analysis.R** - The R routine that extract, cleans and produces UCI-HAR-TidyDataSet.  
  
### OUTPUTS
**./data** - Folder on your working directory that contains the untouched zipped and unzipped data from UCI.  
**./UCI-HAR-TidyDataSet.txt** - The final product in .txt format.  

### GENERAL STATISTICS

##### CPU TIME MEASURES: 
 - user: 30.89s  
 - system: 4.83s  
 - elapsed 86.58s  

##### FILE/FOLDER SIZES: 
 - **./data** folder: 329MB
 - TidyDataSet.*: 220KB  
 - Overall folder (after <code>run\_analysis.R</code> execution): 399MB  

### REFERENCES
1. <a href= "http://cml.ics.uci.edu/">University of California (UCI) Center for Machine Learning and Intelligent Systems</a>  
2. <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "> UCI Machine Learning Repository</a> 
3. <a href="https://class.coursera.org/getdata-002"> Coursera: Getting and Cleaning Data</a>
4. <a href="http://www.biostat.jhsph.edu/~jleek/"> Professor Jeffrey Leek</a>

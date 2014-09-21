## Getting and Cleaning Data


This repository contains the files for the Getting and Cleaning Data course project.

The R source code file "run_analysis.R" executes the steps detailed below. 
Please ensure that the extracted data folders/files "UCI HAR Dataset" are in the same working directory.

Steps:
* Read in Features and Activity labels files from "UCI HAR Dataset" directory
* Read, combine, and add labels to Test data files from "UCI HAR Dataset/test" directory
* Read, combine, and add labels to Training data files from "UCI HAR Dataset/train" directory
* Merge Training and Test data sets into a consolidated data set
* From the consolidated data set, create a subset containing only "mean()" and "std()" measurement variables
* Use descriptive names from Activity labels file to label Activity_ID column in data subset
* Appropriately label data subset with descriptive variable names using a series of gsub commands
* Transform data subset into new tidy data set containing average of each measurement by Subject_ID and Activity_ID
* Write the tidy data set to "TidyData.txt" in the working directory

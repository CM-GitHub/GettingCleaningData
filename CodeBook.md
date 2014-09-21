## Code Book


This code book describes the variables, the data, and transformations or work performed by the "run_analysis.R" program to clean up the data. Please ensure that the extracted data folders/files "UCI HAR Dataset" are in the same working directory.



Merge Training and Test Data Sets

* Read in Features labels from "UCI HAR Dataset" directory (features.txt)
* Read in Test data files (X_test.txt, y_test.txt, subject_test.txt) from "UCI HAR Dataset/test" directory
* Add column names "Subject_ID" and "Activity_ID" to subject_text.txt and y_test.txt data respectively
* Add column names using Features labels to X_test.txt data columns 
* Read in Training data files (X_train.txt, y_train.txt, subject_train.txt) from "UCI HAR Dataset/test" directory
* Add column names "Subject_ID" and "Activity_ID" to subject_train.txt and y_train.txt data respectively
* Add column names using Features labels to X_train.txt data columns 
* Combine Training data sets using cbind command to Data_Train
* Combine Test data sets using cbind command to Data_Test
* Merge Data_Train and Data_Test using rbind command into Data_Merged



Extract Only Measurements on the Mean and Standard Deviation for Each Measurement

* Build Measurements_List containing measurement variables with "mean()" or "std()" using grep command
* From Data_Merged, create a subset Data_Merged_Sub with "Subject_ID", "Activity_ID", and Measurements_List columns



Use Decriptive Activity Names

* Read in Activity labels from "UCI HAR Dataset" directory (activity_labels.txt)
* Add Activity labels to "Activity_ID" column in Data_Merged_Sub



Label Data Set with Decriptive Variable Names

* Change variable names in Data_Merged_Sub using a series of gsub commands to remove special or problematic characters, and to improve readability of variable names.
* Specifically, (i) remove "()"; (ii) replace "-" with "_"; (iii) replace "t" prefix with "Time_"; (iv) replace "f" prefix with "Freq_"; (v) replace "mean" with "Mean"; (vi) replace "std" with "StdDev"



Transform Data Set into New Tidy Data Set Containing Average of Each Measurement by Subject_ID & Activity_ID

* Use Reshape2 library to melt and cast 
* Melt Data_Merged_Sub into Data_Melt with each of the measurement variables as the variable
* Cast Data_Melt into Data_Cast with Subject_ID+Activity_ID as identifier, and computed means for all measurement variables



Write the Tidy Data set

* Use write.table command to output Data_Cast to "TidyData.txt" in the working directory


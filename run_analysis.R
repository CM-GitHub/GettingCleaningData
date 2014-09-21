
# STEP 1 - Merge Training and Test Data Sets

# Read Features labels
features <- read.table("./UCI HAR Dataset/features.txt")

# Read Test related data and add variable names
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(X_test) <- features[,2]
names(subject_test) <- c("Subject_ID")
names(y_test) <- c("Activity_ID")

# Read Training related data and add variable names
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(X_train) <- features[,2]
names(subject_train) <- c("Subject_ID")
names(y_train) <- c("Activity_ID")

# Create consolidated Training and Test data sets
Data_Train <- cbind(subject_train, y_train, X_train)
Data_Test <- cbind(subject_test, y_test, X_test)

# Merge Training and Test data sets into one
Data_Merged <-rbind(Data_Train, Data_Test)

# Clean up workspace
rm(X_test)
rm(y_test)
rm(subject_test)
rm(Data_Test)
rm(X_train)
rm(y_train)
rm(subject_train)
rm(Data_Train)


# STEP 2 - Extract Only Measurements on the Mean and Standard Deviation for Each Measurement

# Extract measurements containing "mean()" or "std()"
Measurements_List <- grep("mean\\()|std\\()", features[,2], ignore.case=TRUE, value =TRUE)

# Create subset of merged Training and Test data sets containing only "mean()" or "std()" measurements
Data_Merged_Sub <- cbind(Data_Merged[, 1:2], Data_Merged[, Measurements_List])

# Clean up workspace
rm(Data_Merged)



# STEP 3 - Use Decriptive Activity Names to name activities in data set

# Read and add Activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
Data_Merged_Sub$Activity_ID <- factor(Data_Merged_Sub$Activity_ID, levels=c(1,2,3,4,5,6), labels=activity_labels[,2]) 



# STEP 4 - Appropriately Label Data Set with Decriptive Variable Names

# This was already partially completed as part of STEP 1 when Training and Test data were combined
# To further improve the labeling of descriptive variable names, the following changes were carried out 
#  Remove special and/or potentially problematic characters from variable names
#  Replace "t" prefix with "Time_"
#  Replace "f" prefix with "Freq_"
#  Replace "mean" with "Mean" for improved readability of variable names
#  Replace "std" with "StdDev" for improved readability of variable names

names(Data_Merged_Sub) <- gsub("\\()","",names(Data_Merged_Sub)) 
names(Data_Merged_Sub) <- gsub("-","_",names(Data_Merged_Sub)) 
names(Data_Merged_Sub) <- gsub("^t","Time_",names(Data_Merged_Sub)) 
names(Data_Merged_Sub) <- gsub("^f","Freq_",names(Data_Merged_Sub)) 
names(Data_Merged_Sub) <- gsub("mean","Mean",names(Data_Merged_Sub)) 
names(Data_Merged_Sub) <- gsub("std","StdDev",names(Data_Merged_Sub)) 



# STEP 5 - Transform Data Set in STEP 4 into New Tidy Data Set Containing
# Average of Each Measurement Variable for Each Activity and Each Subject

# Use Reshape library
library(reshape2)

# Reshape data and compute means
Data_Melt <- melt(Data_Merged_Sub, id=1:2, measure.vars=3:68)
Data_Cast <- dcast(Data_Melt, Subject_ID + Activity_ID ~ variable, mean)

# Write tidy data into a text file
write.table(Data_Cast, "TidyData.txt")
       

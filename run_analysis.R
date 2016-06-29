#unzip the file
unzip(zipfile="C:/Users/parul/Desktop/FUCI HAR Dataset.zip",exdir="./DataScience")

#loading the desired library
library(dplyr)
library(tidyr)

#working directory is set
setwd("C:/Users/parul/Desktop/DataScience/DataScience/UCI HAR Dataset")

#Reading Subject files,activity files & data files

train_y <- read.table("train/y_train.txt", quote="\"")
test_y <- read.table("test/y_test.txt", quote="\"")

features <- read.table("features.txt", quote="\"")
activity_labels <- read.table("activity_labels.txt", quote="\"")

subject_train <- read.table("train/subject_train.txt", quote="\"")
subject_test <- read.table("test/subject_test.txt", quote="\"")

train_X <- read.table("train/X_train.txt", quote="\"")
test_X <- read.table("test/X_test.txt", quote="\"")

colnames(activity_labels)<- c("V1","Activity")

#Merging the train_y with activity label
subject<- rename(subject_train, subject=V1)
train<- cbind(train_y,subject)
train_1<- merge(train,activity_labels, by=("V1"))

#assigning names
colnames(train_X)<- features[,2]

#Combining train_y, activity labels, train_X
train_2<- cbind(train_1,train_X)

#In order to remove the possibility of duplicacy in names, first column is removed from train_2
train_3<- train_2[,-1]

#Selecting on the columns with the mean and standard deviation
train_4<- select(train_3,contains("subject"), contains("Activity"), contains("mean"), contains("std"))
colnames(activity_labels)<- c("V1","Activity")

#merging the test_y with the activity label
subject_Z<- rename(subject_test, subject=V1)
test<- cbind(test_y,subject_Z)
test_1<- merge(test,activity_labels, by=("V1"))

#giving names from features to the X_test data frame
colnames(test_X)<- features[,2]

#Combining y_test, activity labels, X_test
test_2<- cbind(test_1,test_X)

#eliminating the first column from train2 to avoid error "duplicate column name"
test_3<- test_2[,-1]

#selecting only the columns that contains means and std
test_4<- select(test_3,contains("subject"), contains("Activity"), contains("mean"), contains("std"))

# Combining Train data with Test data
analysis<- rbind(train_4,test_4)

#Summarizing the data
run_analysis<- (analysis%>%group_by(subject,Activity) %>%summarise_each(funs(mean)))

#Labelling of data sets with descriptive variable names.
names(run_analysis) <- gsub("^t", "Time", names(run_analysis))
names(run_analysis) <- gsub("^f", "Frequence", names(run_analysis))
names(run_analysis) <- gsub("Acc", "Acceleration", names(run_analysis))
names(run_analysis) <- gsub("Mag", "Magnitude", names(run_analysis))
names(run_analysis) <- gsub("Gyro", "Gyroscope", names(run_analysis))
names(run_analysis) <- gsub("BodyBody", "Body", names(run_analysis))
names(run_analysis) <- gsub("\\()", "", names(run_analysis))
names(run_analysis) <- gsub("-mean", "Mean", names(run_analysis))
names(run_analysis) <- gsub("-std", "StdDev", names(run_analysis))
  
print(run_analysis)

#write to text files on disk
write.table(run_analysis,"./tidy_data.txt",sep=" ",row.name=FALSE) 
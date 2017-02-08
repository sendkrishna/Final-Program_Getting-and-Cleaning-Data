
## This is to read the files

subject_test <- read.table("subject_test.txt", head = FALSE)
activity_test <- read.table("y_test.txt", head = FALSE)
feature_test <- read.table("X_test.txt", head = FALSE)


subject_train <- read.table("subject_train.txt", head = FALSE)
activity_train <- read.table("y_train.txt", head = FALSE)
feature_train <- read.table("X_train.txt", head = FALSE)

## This is to combine the Subject column of test & train dataset and to assign name of the resulting column

data_subject <- rbind(subject_test, subject_train)
names(data_subject) <- c("Subject")

## This is to combine the Activity column of test & train dataset and to assign name of the resulting column
data_activity <- rbind(activity_test, activity_train)
names(data_activity) <- c("Activity")

## This is to combine the all features column of test & train dataset and to assign name of the resulting column
feature_file <- read.table("features.txt", head = FALSE)
data_feature <- rbind(feature_test, feature_train)
names(data_feature) <- feature_file$V2

## This is to generate the final dataset

final_dataset <- cbind(data_subject,data_activity, data_feature)

View(final_dataset)

## This is to select the column with mean and SD

col_mean <- grep("mean\\(\\)", names(final_dataset))
col_sd <- grep("std\\(\\)", names(final_dataset))
A <- names(final_dataset[,col_mean])
as.character(A)
B <- names(final_dataset[,col_sd])
as.character(B)
selected_column <- c(A,B,"Subject", "Activity")
New_data_set <- subset(final_dataset,select = selected_column)
View(New_data_set)
str(New_data_set)

## This is to assign detialed name
names(New_data_set)<-gsub("^t", "time", names(New_data_set))
names(New_data_set)<-gsub("^f", "frequency", names(New_data_set))
names(New_data_set)<-gsub("Acc", "Accelerometer", names(New_data_set))
names(New_data_set)<-gsub("Gyro", "Gyroscope", names(New_data_set))
names(New_data_set)<-gsub("Mag", "Magnitude", names(New_data_set))
names(New_data_set)<-gsub("BodyBody", "Body", names(New_data_set))

names(New_data_set)

## This is to assign descriptive name for Activity column
head(New_data_set$Activity, 30)

New_data_set$Activity <- sub("1","WALKING", New_data_set$Activity)
New_data_set$Activity <- sub("2","WALKING_UPSTAIRS", New_data_set$Activity)
New_data_set$Activity <- sub("3","WALKING_DOWNSTAIRS", New_data_set$Activity)
New_data_set$Activity <- sub("4","SITTING", New_data_set$Activity)
New_data_set$Activity <- sub("5","STANDING", New_data_set$Activity)
New_data_set$Activity <- sub("6","LAYING", New_data_set$Activity)


as.factor(New_data_set$Activity)

## This is to generate final data set with mean of all columns

library(dplyr)

library(ddply)

tidy_data_set <- aggregate(. ~ Subject + Activity, New_data_set, mean)
  
View(tidy_data_set)  
  
tidy_data_set <- tidy_data_set[order(tidy_data_set$Subject,tidy_data_set$Activity),]  
  
write.table(tidy_data_set, file = "tidy_data_set.txt", row.names = FALSE)  

getwd()  





  
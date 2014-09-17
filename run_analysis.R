##Load in the file and merge into one dataset
testset <- read.table("~/UCI HAR Dataset/test/X_test.txt")
trainset <- read.table("~/UCI HAR Dataset/train/X_train.txt")


data <- rbind(testset,trainset) #Merge to form one big dataset

##Load the feature labels
features <- read.table("C:/Users/User/Desktop/UCI HAR Dataset/features.txt", col.names = c("Number","Name"), colClasses=c("integer","character"))
mean_idx <- features$Number[grepl("mean()",features$Name)] ##Get column index for mean observations
std_idx <- features$Number[grepl("std()",features$Name)] ##Get column index for std observations

data2 <- data[,c(mean_idx,std_idx)]

##Get Activities and label them
act_train <- read.table("C:/Users/User/Desktop/UCI HAR Dataset/train/y_train.txt", col.names="Activity")
act_test <- read.table("C:/Users/User/Desktop/UCI HAR Dataset/test/y_test.txt",col.names="Activity")

testsub <- read.table("~/UCI HAR Dataset/test/subject_test.txt", col.names="Subject")
trainsub <- read.table("~/UCI HAR Dataset/train/subject_train.txt", col.names="Subject")

data3 <- cbind(data2,rbind(testsub, trainsub), rbind(act_test, act_train)) ##Merge Activity column with the processed data2 

##Label the activity names
data3$Activity[data3$Activity == 1] <- "Walking"
data3$Activity[data3$Activity == 2] <- "Walking Upstairs"
data3$Activity[data3$Activity == 3] <- "Walking Downstairs"
data3$Activity[data3$Activity == 4] <- "Sitting"
data3$Activity[data3$Activity == 5] <- "Standing"
data3$Activity[data3$Activity == 6] <- "Laying"

##Name the mean and std features
#Set up the mapping table
fullname <- data.frame("OriginalName" = c("tBodyAcc","tGravityAcc","tBodyAccJerk", "tBodyGyro", "tBodyGyroJerk", "tBodyAccMag", "tGravityAccMag", "tBodyAccJerkMag", "tBodyGyroMag", "tBodyGyroJerkMag", "fBodyAcc", "fBodyAccJerk", "fBodyGyro", "fBodyAccMag", "fBodyAccJerkMag", "fBodyGyroMag", "fBodyGyroJerkMag","fBodyBodyAccJerkMag", "fBodyBodyGyroMag", "fBodyBodyGyroJerkMag"),   "FullName" = c("Body Acceleration Signal in time", "Gravity Acceleration signal in time", "Body Acceleration Jerk Signal in time", "Body Gyroscope signal in time", "Body Gyroscope jerk signal in time", "Body Acceleration signal magnitude in time", "Gravity Acceleration signal magnitude in time", "Body Accerlation Jerk signal magnitude in time", "Body Gyroscope signal magnitude in time", "Body Gyroscope jerk signal in time", "Body Acceration signal in frequency" ,"Body Acceleration Jerk signal in frequency", "Body Gyroscope signal in frequency", "Body Acceleration signal magnitude in frequency", "Body Acceleration Jerk signal magnitude in frequency", "Body Gyroscope signal magnitude in frequency", "Body Gyroscope jerk signal magnitude in frequency", "Body Body Acceleration jerk signal magnitude in frequency", "Body Body gyroscope signal magnitude in frequency", "Body Body gyroscope jerk signal in magnitude")) ##Define Full name mapping table
statname <- data.frame("OriginalName" = c("mean()","std()", "meanFreq()"), "FullName" = c("mean", "standard deviation", "weight average frequency")) ##stat full name
direction <- data.frame("OriginalName" = c("X","Y", "Z"), "FullName" = c("X direction", "Y direction", "Z direction"))

#Extract the features
new_features <- features[c(mean_idx,std_idx),]

#Fill the full names
splitstr <- strsplit(new_features$Name, "-")

for (i in 1:length(new_features$Name))
{
        vName <- as.character(fullname$FullName[fullname$OriginalName==splitstr[[i]][1]])
        sName <- as.character(statname$FullName[statname$OriginalName==splitstr[[i]][2]])
        
        new_features$FullName[i] <- paste(sName, "of", vName)
        
        if(is.na(splitstr[[i]][3]) == FALSE)
        {
                dName <- as.character(direction$FullName[direction$OriginalName==splitstr[[i]][3]])
                new_features$FullName[i] <- paste(new_features$FullName[i], "in", dName)
        }
        
}

#Set the feature names!
names(data3) <- c(new_features$FullName,"Subject", "Activity")

#Get a new dataset with the mean of each activity of each subject
library(dplyr)
clean_dataset <- tbl_df(data3) %>% group_by(Activity, Subject)
clean_dataset <- clean_dataset %>% summarise_each(funs(mean))

#Output the file
write.table(clean_dataset, file="step5.txt", row.names=FALSE)
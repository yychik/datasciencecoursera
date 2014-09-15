##Load in the file and merge into one dataset
testset <- read.table("C:/Users/User/Desktop/UCI HAR Dataset/test/X_test.txt")
trainset <- read.table("C:/Users/User/Desktop/UCI HAR Dataset/train/X_train.txt")

data <- rbind(testset,trainset) #Merge to form one big dataset

##Load the feature labels
features <- read.table("C:/Users/User/Desktop/UCI HAR Dataset/features.txt", col.names = c("Number","Name"), colClasses=c("integer","character"))
mean_idx <- features$Number[grepl("mean()",features$Name)] ##Get column index for mean observations
std_idx <- features$Number[grepl("std()",features$Name)] ##Get column index for std observations

data2 <- data[,c(mean_idx,std_idx)]

##Get Activities and label them
act_train <- read.table("C:/Users/User/Desktop/UCI HAR Dataset/train/y_train.txt", col.names="Activity")
act_test <- read.table("C:/Users/User/Desktop/UCI HAR Dataset/test/y_test.txt",col.names="Activity")

data3 <- cbind(data2,rbind(act_test, act_train)) ##Merge Activity column with the processed data2 

##Label the activity names
data3$Activity[data3$Activity == 1] <- "Walking"
data3$Activity[data3$Activity == 2] <- "Walking Upstairs"
data3$Activity[data3$Activity == 3] <- "Walking Downstairs"
data3$Activity[data3$Activity == 4] <- "Sitting"
data3$Activity[data3$Activity == 5] <- "Standing"
data3$Activity[data3$Activity == 6] <- "Laying"

##Name the mean and std features
new_features <- features[c(mean_idx,std_idx),]

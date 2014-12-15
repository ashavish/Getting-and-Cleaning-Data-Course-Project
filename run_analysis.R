#Download the zip and unzip the contents in the working directory

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","./Dataset.zip",mode="wb")

#unzip the file contents

unzip("Dataset.zip")

# Load the data sets

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
body_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
total_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")
body_gyro_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")


subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
body_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
total_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")
body_gyro_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")

# Merge Subject and Activity columns into Test & Train Datasets

test <- X_test
test$Subject <- as.numeric(unlist(subject_test))
test$ActivityId <- as.numeric(unlist(Y_test))

train <- X_train
train$Subject <- as.numeric(unlist(subject_train))
train$ActivityId <- as.numeric(unlist(Y_train))

# Merge the data
data <- rbind(train,test)

# Assign names to columns from features except column names for Subject and ActivityId
features$V2 <- as.character(features$V2)
colnames(data)[1:561] <- features$V2

# Search for column names which have mean() in them and assign to a vector
Cname <- grep("mean()",names(data),value=TRUE,fixed=TRUE)

# Search for column names which have std() in them and append to the vector
Cname <- c(Cname, grep("std()",names(data),value=TRUE,fixed=TRUE))

# Add Subject and Activity to the vector
Cname <- c(c("Subject","ActivityId"),Cname)

# Extract data set with only the required columns
data <- data[,Cname]

# Update Activity names by looking up activity_labels
names(activity_labels) <- c("ActivityId","ActivityName")
data <- merge(activity_labels,data,by.x="ActivityId",by.y="ActivityId",all=TRUE)

# Drop the column with Activity Id
data$ActivityId <- NULL

# Assign Descriptive names for all the columns by substitution

names(data) <- gsub("tB","TimeB",names(data))
names(data) <- gsub("tG","TimeG",names(data))
names(data) <- gsub("fB","FrequencyB",names(data))
names(data) <- gsub("BodyBody","Body",names(data))
names(data) <- gsub("Acc","Acceleration",names(data))
names(data) <- gsub("-mean","Mean",names(data))
names(data) <- gsub("Gyro","Gyroscope",names(data))
names(data) <- gsub("-std","StandardDeviation",names(data))
names(data) <- gsub("Mag","Magnitude",names(data))
names(data) <- gsub("\\(\\)","",names(data))


# Creation of tidy data set

install.packages("plyr")
library(plyr)
tidyData <- ddply(data,.(Subject,ActivityName),numcolwise(mean))

# Write tidyData to a text file

write.table(tidyData,file="tidyData.txt",row.names=FALSE)

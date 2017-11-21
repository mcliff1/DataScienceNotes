# working notes for the Week 4 project on Getting and Cleaning data
# started 11/21/2017
# https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

require(dplyr)

if (!file.exists("./data")) {dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileLocal <- "./data/uci-har-dataset.zip"

if (!file.exists(fileLocal)) {
    download.file(fileUrl, destfile = fileLocal)
}

# read in several key tables from the zip file
XTrain <- read.table(unz(fileLocal, "UCI HAR Dataset/train/X_train.txt"))
yTrain <- read.table(unz(fileLocal, "UCI HAR Dataset/train/y_train.txt"))
SubjectTrain <- read.table(unz(fileLocal, "UCI HAR Dataset/train/subject_train.txt"))
XTest <- read.table(unz(fileLocal, "UCI HAR Dataset/test/X_test.txt"))
yTest <- read.table(unz(fileLocal, "UCI HAR Dataset/test/y_test.txt"))
SubjectTest <- read.table(unz(fileLocal, "UCI HAR Dataset/test/subject_test.txt"))

activityLabels <-read.table(unz(fileLocal, "UCI HAR Dataset/activity_labels.txt"))
features <- read.table(unz(fileLocal, "UCI HAR Dataset/features.txt"))


#
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# add the activity code and subject id to each test and training set
names(SubjectTrain)[1] <- "SubjectId"
names(SubjectTest)[1] <- "SubjectId"
names(yTrain)[1] <- "ActivityId"
names(yTest)[1] <- "ActivityId"
names(XTrain) <- features$V2
names(XTest) <- features$V2

# columns to keep are the ones with std or mean in them (but not meanFreq)
# get an index of everthing with std or mean in it (includes meanFreq)
colsToKeep <- setdiff(grep("(mean|std)", features$V2), grep("meanFreq", features$V2))

XTrain <- XTrain[colsToKeep]
XTest <- XTest[colsToKeep]


train <- cbind(yTrain, SubjectTrain, XTrain)
test <- cbind(yTest, SubjectTest, XTest)
combo <- rbind(train, test)

# convert the ActivityId to the Activty factor
combo <- cbind(Activity=factor(combo$ActivityId, levels=activityLabels$V1, labels=activityLabels$V2), subset(combo, select=-ActivityId))


# clean up all the column/attribute names
colNames <- names(combo)
colNames <- gsub("[()-]", "", colNames)
colNames <- sub("^t", "Time", colNames)
colNames <- sub("^f", "Frequency", colNames)
colNames <- sub("Acc", "Acceleration", colNames)
colNames <- sub("Gyro", "Gyroscope", colNames)
colNames <- sub("Mag", "Magnitude", colNames)
colNames <- sub("mean", "Mean", colNames)
colNames <- sub("std", "Std", colNames)
names(combo) <- colNames

# go ahead and save it
write.table(combo, file="./data/quiz4-tidy.txt", quote=FALSE)


# 5 - get the mean by Activity, SubjectId for the tidy data
# using summari
#combo %>% group_by(Activity) %>% summarize(tBodyAccMeanX=mean(TimeBodyAccelerationMeanX))


comboMean <- combo %>% group_by(Activity, SubjectId) %>% summarize_all(.funs = c(mean="mean"))

write.table(comboMean, file="./data/quiz4-tidymean.txt", quote=FALSE)

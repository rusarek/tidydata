# Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Script requires reshape2 and data.table packages!!!##

##Read reshape2 and data.table into memeory
library(reshape2)
library(data.table)
##Merging Training and Test Data Sets##

##Reading Activity Labels
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

##Reading Data Variable Names
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

##Locating Only Mean and Std varaiables
extract_features <- grepl("mean|std", features)

##Reading in Test Data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Labelling x data
names(x_test)<-features

#Extract only the measurements on the mean and standard deviation for each measurement.
x_test = x_test[,extract_features]

#Load activity labels on test data
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

#Binding Test data
test_data <- cbind(as.data.table(subject_test), y_test, x_test)

# Reading in Training data.
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(x_train)<- features

# Extract only the measurements on the mean and standard deviation for each measurement.
x_train = x_train[,extract_features]

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Binding Training  data
train_data <- cbind(as.data.table(subject_train), y_train, x_train)

# Merge test and train data
data = rbind(test_data, train_data)
id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

#Renaming variables to make 
varNames = names(tidy_data)
varNames <- gsub(pattern="^t",replacement="time",x=varNames)
varNames <- gsub(pattern="^f",replacement="frequency",x=varNames)
varNames <- gsub(pattern="BodyBody",replacement="Body",x=varNames)
names(tidy_data) <- varNames


write.table(tidy_data, file = "./tidy_data.txt", row.names=FALSE)

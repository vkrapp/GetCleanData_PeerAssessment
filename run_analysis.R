# This script assumes that the data was already downloaded from:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# and unzipped in the current working directory. 

# The data represent data collected from the accelerometers from the Samsung 
# Galaxy S smartphone. A full description is available at the site where the 
# data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


# This is the name of the unzipped folder containing the data
folder = "UCI HAR Dataset"

# Load and if neccessary install needed packages
if(!require("plyr")) 
    install.packages("plyr")
library(dplyr)


# Read data, activity labels and subjects of training set
xtrain <- read.table(paste0(folder, "/train/X_train.txt"))
ytrain <- read.table(paste0(folder, "/train/y_train.txt"))
subject_train <- read.table(paste0(folder, "/train/subject_train.txt"))

# Read data, activity labels and subjects of test set
xtest <- read.table(paste0(folder, "/test/X_test.txt"))
ytest <- read.table(paste0(folder, "/test/y_test.txt"))
subject_test <- read.table(paste0(folder, "/test/subject_test.txt"))

# Read features and activity labels
features <- read.table(paste0(folder, "/features.txt"))
activitylabels <-  read.table(paste0(folder, "/activity_labels.txt"))


#######################################################################
# Merge the data of the training and test sets to create one data set #
#######################################################################

# Join data, activity labels and subjects
xdata <- rbind(xtrain, xtest)
ydata <- rbind(ytrain, ytest)
subjectdata <- rbind(subject_train, subject_test)

# Add features as names to the data set
names(xdata) <- features$V2

# Add variable names for activity label and subjects
names(ydata) <- "activity"
names(subjectdata) <- "subject"

# Add data for subjects and activity labels to the data set
data <- cbind(subjectdata, ydata, xdata)

# Tidy up workspace:
rm(list = ls(pattern="^x|^y|^sub"))

####################################################################
# Extract only the measurements on the mean and standard deviation #
# for each measurement                                             # 
####################################################################

# Get only the columns 'subject', 'activity' and with either 'std' or 'mean' 
# in their names
subindices <- grep("std|mean", names(data))
data <- data[,c(1,2, subindices)]

# The variables representing the 'weighted average of the frequency components to 
# obtain a mean frequency' are excluded
meanFreq <- grep("meanFreq", names(data))
data <- data[,-meanFreq]

dim(data) #-> [1] 10299    68

#########################################################################
# Use descriptive activity names to name the activities in the data set #
#########################################################################

# The labels saved in 'activity_labels.txt' are used as descriptive activity names

# Merge data and activity labels
data <- data %>%
    merge(activitylabels, by.x="activity", by.y="V1", all=TRUE) %>%

        # Sort the data according to subject and activity as a number
        arrange(subject, activity)

dim(data) # [1] 10299    69
    
# Subset activity as a number with the descriptive names
data$activity <- data$V2

# Delete the column V2 which is at the end of the data frame
data <- data[-69]


######################################################
# Label the data set with descriptive variable names #
######################################################

# The names of the feature variables are updated: '-' and '()' are removed, the 
# BodyBody problem is fixed and abbreviations are written out in full
featurenames <- names(data[3:68])
featurenames <- sub("^t", "time", featurenames)
featurenames <- sub("^f", "frequency", featurenames)
featurenames <- sub("-", "", featurenames, fixed=TRUE)
featurenames <- sub("()", "", featurenames, fixed=TRUE)
featurenames <- sub("mean", "Mean", featurenames)
featurenames <- sub("std", "Std", featurenames)
featurenames <- sub("Acc", "Acceleration", featurenames)
featurenames <- sub("BodyBody", "Body",featurenames)
featurenames <- sub("BodyBody", "Body", featurenames)
featurenames <- sub("Mag", "Magnitude", featurenames)
featurenames <- sub("-", "", featurenames, fixed=TRUE)

names(data)[3:68] <- featurenames

######################################################################
# From the data set, create a second, independent tidy data set with #
# the average of each variable for each activity and each subject    #
######################################################################

# Group data by subject and activity and calculate the mean
finaldata <- aggregate(data[,3:68], by=list(data$subject, data$activity), FUN = mean)

# Adjust names because aggregate renames subject and activity
names(finaldata)[1:2] <- c("subject", "activity")

# Sort according to subjects
finaldata <- arrange(finaldata, subject)

# Save new data as textfile
write.table(finaldata, "UCI_HAR_data.txt", row.name=FALSE)
# GetCleanData_PeerAssessment
  
The goal of this project is to prepare tidy data that can be used for later analysis. 
   
 To run the script 'run_analysis.R', you need to download and unzip the following data set  into your current working directory: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip   
  
These data were collected from accelerometers from the Samsung Galaxy S smartphone. A full description is available at this site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones   
  

### Analysis
The following steps are performed on the data set:

* The data are read in R's workspace (8 textfiles in total)
* To create one data set, the training and test data sets are merged, the subject numbers and the activities encoded as numbers are added to the data set, and for identification, names are added to the columns
* Only the measurements on the mean and standard deviation for each measurement are extracted; the features representing the 'weighted average of the frequency components to obtain a mean frequency' (meanFreq) are not counted as measurement on the mean
* Descriptive names are added to the data set: 
    * The numbers in the variable activity are subsetted with the activity labels
    * Feature names are improved
* A second, independent tidy data set with the average of each variable for each activity and each subject is created and saved in a textfile called 'UCI_HAR_data.txt'

# Code Book

When running 'run_analysis.R' on the data obtained from this site: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, a textfile 'UCI_HAR_data.txt' is created that contains a 180x68 data set.

The original data were collected from accelerometers from the Samsung Galaxy S smartphone. A full description is available at this site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

A description of the analysis steps performed by 'run_analysis.R' can be found in the README. 
Steps are also commented in the script.

## Variables in UCI_HAR_data.txt

* subject: the unique identifying number for a subject
* activity: one of the following six activities
    + WALKING
    + WALKING_UPSTAIRS
    + WALKING_DOWNSTAIRS
    + SITTING
    + STANDING
    + LAYING

The following 66 variables contain the mean of a feature vector grouped by subject and activity. 

As feature only those were taken into account that contain measurements of the mean or standard deviation. A description of all features can be found in the 'feature_info.txt' provided with the original data in the zipfile. 
  
 A few changes were made to the names of the features:  
  * () and - were removed    
  * f was changed to frequency  
  * t was changed to time  
  * Acc was changed to Acceleration  
  * Mag was changed to Magnitude  
  * std became Std  
  * mean became Mean  
  * the repetition of Body in a few features was deleted  

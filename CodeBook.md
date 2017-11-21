# CodeBook for Human Activity Data

## tidy.txt - contains tidy data set for mean and std measurements

### Summary of tidy contents
10299 observations of 68 variables; the first two columns are

* Activity - activity the participant was engaged in during observation
* SubjectId - unique identifier for the participant in the study

The remaining 66 variables are normalized measurements between `[-1, 1]`
* 40 of them begin with Time, are time-domain signals from the accelerometer and gyroscope in 3-axials `(X,Y, Z)`.  
* 26 of them are FFT (Fast Fourier Transform) to capture the frequencies of those signals

Generally these come in groups of 8 for each sensor processed one of 2 ways (Time or Frequency)
* Mean-X
* Std-X
* Mean-Y
* Std-Y
* Mean-Z
* Std-Z
* Mean-Magnitude
* Std-Magnitutde

For the 40 measurements in the Time domain at 50Hz, these are 5 of these groupings
* Gravity Measurement of the Accelerometer
* Body Measurement of the Acceleratometer
* Body Measurement of the Gyroscope (Angular Acceleration)
* Jerk (rate of change) for the Body Measurement of Accelerometer
* Jerk (rate of change) for the Body Measurement of Gyroscope

The 26 Frequency domain measurements taking the FFT (Fast Fourier Transform); three more groups of 8, but we only have the mean and std for the magnitude of the the frequency transform of jerk (rate of change of acceleration) on the angular motion.
* FFT of Body Measurement of  Accelerometer
* FFT of Jerk of the Body measurement of Accelerometer
* FFT of Body Measurement of Angular Acceleration (Gyroscope)


### Summary of tidy-summary data




### Processing steps for Tidy 

The code [run_analysis.R](run_analysis.R) will execute the following steps to produce both tidy
data sets from the original published materials.

First download from 
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


we then load in the following data files
* train/X_train.txt  contains the  571 different measurments from the sensors
* train/y_train.txt list of the activity codes for the test dataset
* train/subject_train.txt list of the Subject Id for the test datasets
* test/X_test.txt  contains the 571 different measurements from the sensors
* test/y_test.txt  activity codes for the test dataset
* test/subject_test.txt list of the Subject Id for the test datasets

and the two label files
* activity_labels.txt used to get the better factor names for the Activity column
* features.txt used to get the names of the columns


We then rename the column headings for the SubjectId, ActivityId, and features list. Make a list
of the indexes of data to keep (out of the original 571) so we are only including data attribtues about mean and std measurements.

Next we combine the Activity Data, Subject Id's, and measurement data for the training and test sets and put it all together in a single dataframe.

We then replace the Activity Id's the the Acvity factor and do one last manipulation to remove some special characters and better spell out the column names and write out to a local file for future use.


The Tidy Summary is a grouping by the Activity and SubjectId of the tidy table, calculating the mean of each attribute by that grouping.

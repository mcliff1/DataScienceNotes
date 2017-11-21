# CodeBook for Human Activity Data

tidy.txt - contains tidy data set for mean and std measurements
10299 observations of 68 variables; the first two columns are

* Activity - activity the participant was engaged in during observation
* SubjectId - unique identifier for the participant in the study

The remain 66 variables are normalized measurements between `[-1, 1]`, 40 of them begin with Time, are time-domain signals from the accelerometer and gyroscope in 3-axials `(X,Y, Z)`.  

Generally these come in groups of 8 for each sensor processed one of 2 ways
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


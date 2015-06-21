# Introduction and Study Design

This repository contains an R script for processing Samsung cell phone motion data.  The data was accumulated by having a group of people wear a Samsung Galaxy II cell phone at their waist and perform certain physical activities. The script in this repository processes the raw data (source links below) by combining data from multiple text files and labeling the data in R.  Although the raw dataset contains many values, only mean and standard deviation values are included in the output.  These values are correlated with the activity and the test subject (person).
The result is a "tidy" data set containing data values which are an average of available values collected for each activity and person.

# Using the script

To use the the script:

1. Start the R environment and change the working directory to the location of the raw data.  Example:

```r
setwd('c:\path\to\raw\data')
```

2. Load the script:
    ```r
    source('run_analysis.r')
    ```
3. Run the analysis script and capture the results:
```
    results <- run_analysis()
```
4. Optionally, the results can be saved using a helper function.  The results are written to a file with the given name:

~~~
    run_analysis_write_output("tidy_data_output_file.txt")
~~~

The raw data is available from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  A description of the data can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).



# Tidy data set output "code book"

The features selected for this database come from the cell phone's accelerometer and gyroscope, measured on three axes, X, Y, and Z. (Note: Below examples are given for the X axis only, but the same pattern can be applied for the Y and Z components.) The features were recorded and then further processed.  First, the signal values were combined to calculate a mean and standard deviation.  Then, for each person and activity recorded, the values were averaged together.  
Time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc.mean..X and tGravityAcc.mean..X) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (e.g. tBodyAccJerk.mean..X and tBodyGyroJerk.mean..X). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

A full list of features can be found in features.md

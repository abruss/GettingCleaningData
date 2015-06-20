# GettingCleaningData

This repository contains an R script for processing Samsung cell phone motion data.  The data was accumulated by having a group of people wear a Samsung Galaxy II cell phone at their waist and perform certain physical activities. The script in this repository processes the raw data (source links below) by combining data from multiple text files and labeling the data in R.  Although the raw dataset contains many values, only mean and standard deviation values are included in the output.  These values are correlated with the activity and the test subject (person).
The result is a "tidy" data set containing data values which are an average of available values collected for each activity and person.

To us the the script:
1. Start the R environment and change the working directory to the location of the raw data.  Example:

    setwd('c:\path\to\raw\data')

2. Load the script:

~~~R
    source('run_analysis.r')
~~~

4. Run the analysis script and capture the results:

    results <- run_analysis();

The raw data is available from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
A description of the data can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



# Tidy data set output "code book"



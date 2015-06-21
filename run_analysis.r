run_analysis <- function() {

	# Load data from data sets using current working directory.
	trainingDataSet <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
  trainingActivities <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
  trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt ", header = FALSE)
  
  # trainingData <- cbind(trainingDataSet, trainingActivities)
  	
	testDataSet <- read.table("UCI HAR Dataset/test/X_test.txt", header= FALSE)
	testActivities <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
	testSubjects <-  read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
	# testData <- cbind(testDataSet, testActivities)
	
	activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
	featureLabels <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
	
	# 1.Merges the training and the test sets to create one data set.
	dataSet <- rbind(trainingDataSet, testDataSet)   
  activityData <- rbind(trainingActivities, testActivities)
  subjectData <- rbind(trainingSubjects, testSubjects)
  
	# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
  # Note: This assignment item is unclear to me.  Interpreting this requirement as "filter the data set to only include those
	#   features which are mean or std deviation values"
  # This is reducing the numbers of columns but not the number of rows.
	selectedFeatures <- featureLabels[ grepl("mean|std", featureLabels[,2]), ]
	selectedFeatureColumns <- dataSet[ , selectedFeatures[ , 1]]
	
	# 3.Uses descriptive activity names to name the activities in the data set
	# Convert activity code to label text, then attach the activity description text to the exiting data set.
	activityDescr <- lapply(activityData, function(x) { lookup(activityLabels, x)})
	dataSet2 <- cbind(selectedFeatureColumns, activityDescr)
	
	# 4.Appropriately labels the data set with descriptive variable names. 
	# Just naming the table columns here and that's all.  Most column names come from the original data sets feature list, 
	# but the last column, which we've created, has an explicit name added here.
	names(dataSet2) <- c(as.character( selectedFeatures[,2] ), "ActivityDescription")
	
	# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  dataSet3 <- cbind(dataSet2, subjectData)
  names(dataSet3) <- c(as.character( selectedFeatures[,2] ), "ActivityDescription", "SubjectNumber")
  
  result <- buildAverageTidyDataFrame(dataSet3)
  result[, 2:ncol(result)]
}

run_analysis_write_output <- function(filename)
{
  result <- run_analysis();
  write.table(result, file = filename, row.names=FALSE)
}

# Given a table where the first column is an ID and an id value to search for, return the matching row.
lookup <- function(table, idValue) {
  endCol = ncol(table)
  indices = match(idValue, table[,1])
  table[indices, 2:endCol]
}

buildAverageTidyDataFrame <- function(dataSet) {
  bySubject <- split(dataSet, dataSet$SubjectNumber)
  endCol <- ncol(dataSet) - 2   # Do not create average for activity and subject columns
  result <- dataSet[0,]  # Create a dataframe with same columns but no rows.
  
  myList<- lapply(bySubject, function(singleSubject) {
    byActivity <- split(singleSubject, singleSubject$ActivityDescription)
    v<-lapply(byActivity, function(singleActivity) {
      aveResult <- apply(singleActivity[, 1:endCol], 2 , mean)
      result <- rbind(result, c(aveResult, singleActivity[1, (endCol+1):(endCol+2)]))
    })
    ldply(v)
  })
  ldply(myList)
}



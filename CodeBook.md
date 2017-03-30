
Getting-and-Cleaning-Data-Course-Project

1. Variables

============

  fileURL - URL of the data source
  
  destfile - temporary file to store the zip file
  
  features - store features.txt
  
  activities - store activity_labels.txt
  
  testlabels - store y_test.txt
  
  trainlabels - store y_train.txt
  
  testsubject - store subject_test.txt
  
  trainsubject - store subject_train.txt
  
  testdata - store X_test.txt
  
  traindata - store X_train.txt
  
  data - store the merge rows of testdata and traindata
  
  mean.std.data - store only data of mean() and std() variables and to merge colums of activities and subjects.
  
  melted.data - store melted data subset
  
  tidy.data - store tidy data subset

2. Data

=======

  The site where the data was obtained:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

  The data for the project:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


3. Transformations

==================

3.1 The script extract, read and store in variables a set of files form the zip file:

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

3.2 Add column names to test data and train data from features. 

3.3 Merge rows of test data and train data in a new data set

3.4 Extract only the measurements of mean and standard deviation from the data set

3.5 Merge columms of labels (activities) and subjects to the previous data set

3.6 Replace activity labels in the data set to the activity names from activities_labels.txt

3.7 Made variable names lower case and remove "_", ")", "(".

3.8 Generates the new tidy data set with the average of each variable for each activity and each subject:

  ## melted.data <- melt(mean.std.data,id.vars=c("subject","activity"))

  ## tidy.data <- dcast(melted.data, subject + activity ~ variable, mean)                                





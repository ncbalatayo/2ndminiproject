# Description of the run_analysis.R script
The R script run_analysis.R does the following:
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement
3) Uses descriptive activity names to name the activities in the dataset
4) Appropriately labels the data set with descriptive variable names
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script work this way:
1) First, it set ups the local working directory (Line 2)
2) Then, it loads the packages that will used in the script which is data.table and dplyr (Line 5-6)
3) Next, it set ups the working directory for the unzip file (Line 9-11) 
    - dir is the directory for the UCI HAR Dataset
    - tesdir and traindir if for the test files and train files, respectively
4) After that it loads the data from activity_labels.txt to R (line 14) 
    - On Line 17-23, a function is define that will be used to set the descriptive      
      equialent of the activity labels of test and train data
6) Next, is to load the column names of the measurement data in test and train from features.txt file (Line 26)
     - Line 29 extracts the data (column names) with mean and st (from the features), and save its equavalent index to neededFatures which will be used later on to determine        which of test and train measurement is its equivalent
     - Line 32-35 fixed the columns names by removing the parenthesis and dashes and capitalizing the first letter of mean and std
9) Then it loads the test subject data and the quivalent activity into R (line 38-39) and then loads the set of mean and standard deviation test data into R (line 42)
11) After that it merge the data subject data, descriptive activity names and the test data and save it in a data frame testdata (Line 45)
     - Line 48 assigned the column names, Subject for column 1, Activity for column 2, and the values inside the vector neededFeatures for the succeding columns
12) After that, it does the same to the train data. It loads the train subject data and the quivalent activity into R (line 51-52) and then loads the set of mean and standard deviation train data into R (line 55). After that it merge the data subject data, descriptive activity names and the train data and save it in a data frame traindata (Line 58). Line 61 do the same thing that happend to test data in line 48 to traindata.
13) Then, it merge the tidy train data and test data in the data frame tidydata (line 64). (Setting up the same column names for traindata and testdata is needed to row bind the data.)
14) The script also ceates another tidy set (line 70-73) that contains the average of all variables for each subject and activity. It its done through grouping first the data in tidyData by subject then by activity, and then generate the average or mean summary of the avariable (summarize_all(list(mean=mean))
15) Lastly, it saved the tidy data sets in a csv file (line 67 for the first tidydata dataset and line 76 for the tidydata.means dataset)
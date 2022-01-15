# setting up the directory
setwd("C:\\Users\\Username\\Documents\\specdata")

# load the package data.table and dplyr
library(data.table)
library(dplyr)

# defining directories from the unzip file
dir<-"UCI HAR Dataset"
testdir<-paste(dir, "test", sep = "/")
traindir<-paste(dir, "train", sep = "/")

# Load: activity labels
activitylabels <- read.table(paste(dir, "activity_labels.txt", sep="/"))

# set the name of the activity label
set_label_name<-function(labels){
  labels_name<-{}
  for(i in 1:nrow(labels)){
    labels_name[i]<-activitylabels[labels[i,1],2]
  }
  return (labels_name)
}

# Load: data column names
features <- read.table(paste(dir, "features.txt", sep="/"))

# extracting mean and standard deviation features
neededFeatures<- grep(".*mean.*|.*std.*", features[,2])

# Fixed the the variable names
descriptiveFeatures.names<-features[neededFeatures,2]
descriptiveFeatures.names=gsub("mean", "Mean", descriptiveFeatures.names) # replace mean by Mean
descriptiveFeatures.names=gsub("std", "Std", descriptiveFeatures.names) #replace std by Std
descriptiveFeatures.names=gsub("[()-]", "", descriptiveFeatures.names) # remove parenthesis and dashes 

#load the  subject and activity test data from test in unzip file 
subject_test <- read.table(paste(testdir, "subject_test.txt", sep="/"))
testlabels <- read.table(paste(testdir, "y_test.txt", sep="/"))

#load only the mean and std data from test set
testset <- read.table(paste(testdir, "X_test.txt", sep="/"))[neededFeatures]

#merge the data on test subject, test activity labels and test set
testdata<-cbind(subject_test, set_label_name(testlabels), testset)
is.data.frame(testdata)
#set Subject, Activity and value inside the vector descriptiveFeatures.names as (descriptive) column names.
colnames(testdata)<- c("Subject", "Activity", descriptiveFeatures.names)

#load the subjects and activity train data from train in unzip file 
subject_train <- read.table(paste(traindir, "subject_train.txt", sep="/"))
trainlabels <- read.table(paste(traindir, "y_train.txt", sep="/"))

#load only the mean and std data from train set
trainset <- read.table(paste(traindir, "X_train.txt", sep="/"))[neededFeatures]

#merge the data on training subject, training activity labels and train set
traindata<-cbind(subject_train, set_label_name(trainlabels), trainset)

#set Subject, Activity and value inside the vector descriptiveFeatures.names as (descriptive) column names.
colnames(traindata)<- c("Subject", "Activity", descriptiveFeatures.names)

# merge training and test data in one dataset 'tidydata'
tidyData<-rbind(testdata, traindata)

# write the tidy data in csv file
write.csv(tidyData, file ="tidydata.csv", row.names = FALSE)

# Get the average(mean) of all the variables group by subject then activity
tidyData.means <- 
  tidyData %>% 
  group_by(Subject, Activity) %>%
  summarize_all(list(mean=mean))

# write the tidy data in csv file
write.csv(tidyData.means, file ="tidydata.means.csv", row.names = FALSE)




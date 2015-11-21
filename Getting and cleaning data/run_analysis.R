library(data.table)
library(plyr)
library(dplyr)

run_analysis <- function(){
  indices <- c(1:3, 41:43, 81:83, 121:123, 161:163, 266:268, 345:347, 424:426, 201, 214, 227, 240, 253, 503, 516, 529, 542, 4:6, 44:46, 84:86, 124:126, 164:166, 348:350, 427:429, 202, 215, 228, 241, 254, 269, 270, 271, 504, 517, 530, 543)
  
  ## Read feature names and select interesting ones
  featurenames <- read.table("UCI HAR Dataset/features.txt")
  featurenames <- featurenames$V2
  select_features <- as.character(featurenames[indices])
  
  ## Read training data
  data <- fread("UCI HAR Dataset/train/X_train.txt")
  data <- data[, indices, with = FALSE]
  colnames(data) <- select_features
  
  
  ## Read testing data
  test_data <- fread("UCI HAR Dataset/test/X_test.txt")
  test_data <- test_data[,indices, with = FALSE]
  colnames(test_data) <- select_features
  
  
  ## Requirement 1:: combine training and test data
  data <- rbind(data, test_data)
  
  ## Read subject data and attach them to dataset as column "subject"
  subjects <- fread("UCI HAR Dataset/train/subject_train.txt")
  subjects <- subjects$V1
  test_subjects <- fread("UCI HAR Dataset/test/subject_test.txt")
  test_subjects <- test_subjects$V1
  subjects <- c(subjects, test_subjects)
  data <- data[, subject:= subjects]
  
  ## Read labels for training and test data and combine them 
  labels <- fread("UCI HAR Dataset/train/y_train.txt")
  labels <- labels$V1
  test_labels <- fread("UCI HAR Dataset/test/y_test.txt")
  test_labels <- test_labels$V1
  labels <- c(labels, test_labels)
  
  
  ## Read in activity label mappings and attach labels to dataset as column "activity"
  activity_labels <- fread("UCI HAR Dataset/activity_labels.txt")
  activity_labels <- as.factor(activity_labels$V2)
  labels <- sapply(labels, function(x){activity_labels[x]})
  data <- data[, activity := labels]
  
  
  ddply(data, .variables = c("subject", "activity"), numcolwise(mean))
  
}
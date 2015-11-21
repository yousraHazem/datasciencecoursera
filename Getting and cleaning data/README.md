The script works by performing the following steps:
 1- It reads feature names from "UCI HAR Dataset/features.txt" and selects the interesting ones using their indices.
 2- Then it reads the training data from "UCI HAR Dataset/train/X_train.txt" and testing data from "UCI HAR Dataset/test/X_test.txt" then sets the correct descriptive column names to them.
 3- It fulfills requirement one by combining training and test data.
4- It reads the subject data and attaches them to dataset as column "subject" 
5- It reads labels for training and test data as numbers and combines them into variable "labels".
6- It reads in activity label mappings and attaches it to the dataset as column "activity".
7-  Then it calculates the column means using the function ddply.
#Readme file for Project

##Purpose
This package contains a script to perform data cleaning and extraction from the UCI HAR Dataset. This script will first merge the test set, training set, subjects in the test set, subjects in the training set, activities in the test set amd activity in the training set into one data set, and then extract the mean and standard deviation columns from the original dataset (feature variable names containing "mean()"" and "std()"). Then the script will name the variable with descriptive names. Finally a second independent data set containing the mean values of each feature variable for each subject and each activity will be outputted. 

##File Package
The file package contain 3 files:

1.run_analysis.R -- Main script for performing the cleaning and extraction action

2.README.md -- A README markdown file containing instructions to run the script as well as purpose

3.CODEBOOK.md -- Codebook containing description of the variables

##How to run?
In order to run the script, you would require the following R packages

1.R base package

2.dplyr package

You will need to put the UCI HAR Dataset downloaded through here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Extract and put all the files (including all sub-directories) to your R working directory

##Inputs
UCI HAR Dataset downloaded through this link

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Outputs
data3 - a merged data frame from the training set and test set data, alongside with subjects and activities.

clean_dataset - an independent data framecontaining the mean values of each feature variable for each subject for each activity 

step5.txt - a text file created by outputting clean_dataset 
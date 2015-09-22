---
title: "Codebook"
author: "Asma Falah Shakir"
date: "22 Sep 2015"
output: html_document
---
##Describtion
This is the codebook for the course project of getting and cleaning data course.
A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Source:
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltr?? (08800), Spain
activityrecognition '@' smartlab.ws
##Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about this dataset.
##Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
## Requirement
Create one R script called run_analysis.R that does the following. 
*Merges the training and the test sets to create one data set.
*Extracts only the measurements on the mean and standard deviation for each measurement. 
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive variable names. 
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!



##Variables:
##1 . Merging the training and the test sets to create one data set.
### The variables to which the read data are assigned:
featuresx_test
featuresx_train
subjectx_test
subjectx_train
activityx_test
activityx_train
### merging the train with the test files
### row binding
features
activity
subject
### assigning names to new variables
featuresnames
### binding columns
first
thedataframe
##2. Extracting only the measurements on the mean and standard deviation for each measurement:
subsetfeaturesnames
interest
##3. Using descriptive activity names to name the activities in the data set:
activitylabels
##4. Appropriately labeling the data set with descriptive variable names:
##5. Creating a second,independent tidy data set and ouput it:
thedataframe2
##Clear variables
rm(list=ls())
## Creating and setting the directory
dir.create("./my_directory/")
setwd(file.path("./my_directory/"))  
##Downloading the data:
Theurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" ##This is the Url for the zip file.
##Download the file after specifying the Url
download.file(Theurl, destfile="./dataset.zip", mode = "wb")  ## I'm using Windows7, if you're using mac you have to specify the method with "curl"
##It must be unzipped for processing!
unzip(zipfile ="./dataset.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE) ##This should unzip the file and place the unzipped file in the working directory
## Now we should take a look at what we got after we unzipped the files!
list.files()
## we should see this folder listed: UCI HAR Dataset, that's the folder which contains our files, we must navigate to it and see its contents.
filepath <- file.path(".", "UCI HAR Dataset") ##This sets the file path for it to be used in the next step
Listfiles <- list.files(filepath, recursive=TRUE)
Listfiles ## This should generate a list of all the files in the folder, a total of 27 titles.
## Great! Now we're oriented and should not be confused! Let's get down to business.

## Now onto reading the data of features, subject and activity files, and assigning them to variables, they come in both training and test titles.
## Reading is gonna take a little while! Sorry T_T
featuresx_test <- read.table(file.path(filepath, "test" , "X_test.txt" ), header = FALSE, sep = "")
featuresx_train <- read.table(file.path(filepath, "train", "X_train.txt" ), header = FALSE, sep = "") 
## Those were the training and test sets of the features files.

subjectx_test <- read.table(file.path(filepath, "test" , "subject_test.txt"),header = FALSE, sep = "")
subjectx_train <- read.table(file.path(filepath, "train", "subject_train.txt"),header = FALSE, sep = "")
## Those were the training and test sets of the subject files.

activityx_test <- read.table (file.path(filepath , "test" , "Y_test.txt" ), header = FALSE, sep = "")
activityx_train <- read.table(file.path(filepath, "train", "Y_train.txt"), header = FALSE, sep = "")
## Those were the training and test sets of the activity files.

## let's look at whether or not this reading process was successful, shall we?
head (featuresx_test)
head (featuresx_train)
head (activityx_test)
head (activityx_train)
head (subjectx_test)
head (subjectx_train)

##Great, now let's start the merging!
## 1. Merge the training and the test sets to create one data set:
## Binding columns and rows is probably the simplest way for someone who hasn't had much experience in R.
## Bind the rows of the files!
features <- rbind(featuresx_test, featuresx_train)
subject <- rbind(subjectx_test, subjectx_train)
activity <- rbind(activityx_test, activityx_train)

##Let's give those new variables names!
names(subject)<- c ("subject")
names(activity) <- c("activity")
featuresnames <- read.table(file.path(filepath, "features.txt"), header = FALSE)
names(features) <- featuresnames$V2
##Yes, this is important because we'll use it to get the mean and standard deviation! It's easier to do it here before creating the big data frame.

## Finally, we're going to merge the columns to get a big data frame
first <- cbind(subject, activity) ##Binds just a couple of the 3 (Subject and activity) and assigns them to a variable.
thedataframe <- cbind(features, first) ##Binds the already bound couple to the 3rd (features) and assigns the resulting Dataframe to a variable.
##Let's have a look
head(thedataframe)

## Now onto the mean and standard deviation
## 2. Extract only the measurements on the mean and standard deviation for each measurement:
subsetfeaturesnames <- featuresnames$V2[grep("mean\\(\\)|std\\(\\)", featuresnames$V2)] 
## That should subset the features' names with mean or standard deviation

## from the big data frame, we're gonna subset data using "subject" and "activity" names.
interest <- c(as.character(subsetfeaturesnames), "subject", "activity" )
thedataframe <- subset(thedataframe, select = interest) ## The new refined dataframe!
## Let's take a peak 
str(thedataframe)

## 3. Use descriptive activity names to name the activities in the data set:
## In a file, must be read.
activitylabels <- read.table(file.path(filepath, "activity_labels.txt"),header = FALSE, sep = "")
## Let's look at them shall we?
activitylabels

##Now let's give the activities descriptive names:
thedataframe$activity <- as.character(thedataframe$activity)
thedataframe$activity[thedataframe$activity == 1] <- "Walking"
thedataframe$activity[thedataframe$activity == 2] <- "Walking Upstairs"
thedataframe$activity[thedataframe$activity == 3] <- "Walking Downstairs"
thedataframe$activity[thedataframe$activity == 4] <- "Sitting"
thedataframe$activity[thedataframe$activity == 5] <- "Standing"
thedataframe$activity[thedataframe$activity == 6] <- "Laying"
thedataframe$activity <- as.factor(thedataframe$activity)

## it should work
head (thedataframe$activity)

## 4. Appropriately label the data set with descriptive variable names:
##Activity, Subject and activity names are down! We've only got features to go!
##Let's have a look, shall we? 
names(thedataframe)
##Now let's get to replacing!
names(thedataframe) <- gsub("Acc", "Accelerometer", names(thedataframe))## should replace Acc with Accelerometer
names(thedataframe) <- gsub("BodyBody", "Body", names(thedataframe))##will replace BodyBody with Body
names(thedataframe) <- gsub("^f", "frequency", names(thedataframe))## will replace f with frequency
names(thedataframe) <- gsub("Gyro", "Gyroscope", names(thedataframe))## should replace Gyro with Gyroscope
names(thedataframe) <- gsub("Mag", "Magnitude", names(thedataframe))## should replace Mag with Magnitude
names(thedataframe) <- gsub("^t", "time", names(thedataframe)) ##Will replace t with time
## it should work
names (thedataframe)
##5. Create a second,independent tidy data set and ouput it:
library(plyr);
thedataframe2 <- aggregate(. ~subject + activity, thedataframe, mean) ##it has the average of each variable for each activity and each subject.
thedataframe2 <- thedataframe2[order(thedataframe2$subject,thedataframe2$activity),] ##Just puts stuff into a specified order.
write.table(thedataframe2, file = "tidydata.txt", row.names = FALSE, sep = ",")
## The end
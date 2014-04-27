Getting and Cleaning Human Activity Recognition Data 
====================================================

## Overview

We are processing data collected from the accelerometers and gyroscopes of 30 subjects carrying Samsung Galaxy S smartphone. The experiment was designed to predict which one of 6 actions the subject was performing when the accelerometer data was collected. These activites were: 
* Walking
* Walking up stairs
*	Walking down stairs
*	Sitting
*	Standing
*	Laying down

A total of 10299 readings were collected for the 30 subjects. Each reading consisted of 561 data elements (derived from the raw accelerometer and gyroscope data). The data set was randomly split into 70% training data (21 subjects) and 30% test data (9 subjects).

A full description is available at the site where the data was obtained: 
* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


## Data Source
The data we are using was downloaded from the course site:
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Data Provided
The downloaded file was unzipped. The resulting directory structure and contents are as follows:
* The top level directory, UCI HAR Dataset, contained the following files:
  * README.txt - A file that describes the experiment, the way the data was gathered and preprocessed, and the files provided.
  * features_info.txt - a file that briefly describes the 17 general types of date created (some times 3 for X, Y and Z directions) and the up to 18 variables estimated for each of these types. It gives a feeling for what the 561 data elements represent.
  * activity_labels.txt - The labels for the six activities detailed above
  * features.txt - the names of the 561 variables collected per record
* A subdirectory of UCI HAR Dataset, train, contained:
  * X_train.txt - 7352 rows x 561 columns from 21 subjects
  * y_train.txt - 7352 rows x 1 column identifying which of the 6 activities was being performed when the data in the corresponding row in X_train.txt was collectd
  * subject_train.txt - 7352 rows x 1 column identifying which of the 30 subjects' data was being collected in the corresponding row in X_train.txt
  * a subdirectory, Inertial Signals, which contains the raw data collected from the phones. We are NOT using this data directly. We are using the data in the parent directory, which was derived from the raw data, as described in the project's README.txt file.
* A subdirectory of UCI HAR Dataset, test, contained:
  * X_test.txt - 2947 rows x 561 columns from 9 subjects
  * y_test.txt - 2947 rows x 1 column identifying which of the 6 activities was being performed when the data in the corresponding row in X_test.txt was collectd
  * subject_test.txt - 2947 rows x 1 column identifying which of the 30 subjects' data was being collected in the corresponding row in X_test.txt
  * a subdirectory, Inertial Signals, which contains the raw data collected from the phones. We are NOT using this data directly. We are using the data in the parent directory, which was derived from the raw data, as described in the project's README.txt file.
  
## Cleaned Data Produced
The downloaded data was cleaned and reshaped as follows:
* The 3 pairs of training and test datasets were combined into 3 single datasets with 10299 rows each (561 columns of readings, 1 column of activities, 1 column of subjects)
* The 561 variable names in features.txt were used to name the columns of the reading data
* In order to extract only the measurements of the mean and standard deviation for each measurement, eliminated the columns that don't contain -mean() or -std() in their names, leaving 66 columns
* Prepend the activity column to the measurement data, making sure it is a factor variable
* Prepend the subject column to the measurement data







This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **Help** toolbar button for more details on using R Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r fig.width=7, fig.height=6}
plot(cars)
```

* We assume that files have been downloard and extracted to a local directory.
* "for the purposes of this analysis, the variables were defined as..."
*  write the table to a .txt file with check.names=FALSE
* ?write.table   #RTFM
* write.table(tidydata, file="./tidydata.txt", sep="\t", row.names=FALSE)
* github link creation: https://class.coursera.org/getdata-002/forum/thread?thread_id=409
* Replacing numbers with the activity labels: https://class.coursera.org/getdata-002/forum/thread?thread_id=385

* changing column names: colnames(gdpRanks)<-foo
* colnames(gdpRanks)[9]<-"foo"
* append two dataframes: all.rows <- rbind(dfrm1,dfrm2)


Checklist
* The explanation is as important as the script, so make sure you have the readme

* have you gotten the average of each variable for each combination of subject and activity and saved the data frame of this as a set of tidy data
* have you loaded up your current script, an up to date readme! and your tidy data

You should create one R script called run_analysis.R that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
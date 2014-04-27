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

For more information about this dataset contact: 
* activityrecognition@smartlab.ws

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
* Write out the dataset using write.table as dataset1.txt
* Create a dataset that contains the average of the 66 data columns for each combination of subject (30 values) and activity (6 values). This 180 row dataframe is created using melt() and dcast() in the reshape2 package.
* Write out the dataset using write.table as dataset2.txt

## Assumptions
While most of the assumptions made are alluded to in the above text, they are made explicitely here:
* The data is manually downloaded from the URI provided and unzipped.
* The script is run with the working directory being the top level unzipped directory, "UCI HAR Dataset"
* The data used is the preprocessed (by the study authors) data in the first level subdirectories (train and test), not in their Inertial Data subdirectories. While the original authors describe the process of going from the Inertial data to the provided data sets, the details are not provided and the physics needed to rederive these calculations is beyond my capabilities (therefore not an option).
* The subset of fields used are those that repesent the mean and standard deviation values of variables. This was interpreted as those that include "-mean()" and "-std()". This did not include those that include "-meanFreg()". This is because the former set had paired values of means and standard deviations. The latter group only included means.

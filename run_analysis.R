  # The current working directory is the UCI HAR Dataset directory,
  # which has the test and train subdirectories beneath it
  activityLabels<-read.table("activity_labels.txt")
  features<-read.table("features.txt")
  testSet<-read.table("test/x_test.txt")
  testLabels<-read.table("test/y_test.txt")
  testSubject<-read.table("test/subject_test.txt")
  trainSet<-read.table("train/x_train.txt")
  trainLabels<-read.table("train/y_train.txt")
  trainSubject<-read.table("train/subject_train.txt")
  
  # combine the test and training datasets
  combinedSet <- rbind(trainSet,testSet)
  combinedSubject <- rbind(trainSubject,testSubject)
  combinedLabels <- rbind(trainLabels,testLabels)
  
  # Give the columns names using the features
  colnames(combinedSet)<-features$V2
  nrow(combinedSet)
  ncol(combinedSet)
  
  # Eliminate the columsn that don't contain -mean() or -std() in their names
  colNames=names(combinedSet)
  desiredColumns=grep("-mean\\(\\)|-std\\(\\)",colNames)
  combinedSetSlim <- combinedSet[,desiredColumns]
  
  # Prepend a column for the activity field to the combined set
  combinedLabelsFactors=cbind(activityLabels$V2[combinedLabels$V1],combinedLabels)
  colnames(combinedLabelsFactors)[1]<-"activity"
  str(combinedLabelsFactors)
  head(combinedLabels)
  head(combinedLabelsFactors)
  head(activityLabels)
  table(combinedLabelsFactors)
  
  # Prepend the activity factor column to the measurements
  combinedSet2<-cbind(combinedLabelsFactors$activity,combinedSetSlim)
  colnames(combinedSet2)[1]<-"activity"
  str(combinedSetSlim)
  str(combinedSet2)
  head(combinedSet2)
  
  # Prepend the subject column to the measurement data
  combinedSet3<-cbind(combinedSubject$V1,combinedSet2)
  colnames(combinedSet3)[1]<-"subject"
  str(combinedSet3)
  head(combinedSet3)
  
  # Write out the dataset using write.table as dataset1.txt
  write.table(combinedSet3, "dataset1.txt")
  
  # To produce the sum of the means and standard deviations by subject / activity we
  # first melt the data with keys subject and activity and the rest of the 66 columns 
  # as variable data. Then we dcast it into 180 rows, keyed by subject/activity with
  # 66 mean and standard deviatio variables averaged for that subject/activity combination
  library(reshape2)
  puddle <- melt(combinedSet3,id=c("subject", "activity"))
  table(puddle$subject,puddle$activity)
  table(puddle$variable)
  
  avgSet <- dcast(puddle, subject + activity ~ variable, mean)
  str(avgSet)
  head(avgSet)
  
  # Write out the dataset using write.table as dataset2.txt
  write.table(avgSet, "dataset2.txt")


---
title: "Codebook for Getting and Cleaning Data Project"
author: "courserads1"
date: "Saturday, April 25, 2015"
output: html_document
---

### This is the code book describing the output file, tidy_long.txt.  

### Raw Data  
+ obtained from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  
+ description of source data collection and data:  [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  


### tidy_long.txt variables: description, source and transformation information  

#### Subject  
+ Obtained from source files subject_test.txt and subject_train.txt from each of the test and train directories  
+ Variable name of "Subject" assigned during read.table() process
+ Contains complete range of values from 1 through 30 representing a unique code assigned to the voluntee subject the data was collected from.  


#### ActivityDescription
+ Obtained from source file activity_labels.txt contaning 2 variables which were assigned ActivityCode and ActivityDescription labels.  
+ ActivityCode values from 1 through 6 and used to merge ActivityDescription with subject's measurement data.  
+ ActivityDescription contains 6 unique values describing activity as follows:  
LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS  

#### VariableName  
+ subset of the variable names from the x and y test and train data which contain mean or standard deviation measurements
+ melt() used to transform from wide to long format
+ VariableName label assigned using colnames()  
+ Measurement details of each VariableName value can be obtained in the README.txt file from the source data at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) with additional information available at [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
+ 86 unique values representing measurement descriped in value name
+ values listed using unique(tidy_long$VariableName):  
 [1] tBodyAcc-mean()-X                    tBodyAcc-mean()-Y                   
 [3] tBodyAcc-mean()-Z                    tBodyAcc-std()-X                    
 [5] tBodyAcc-std()-Y                     tBodyAcc-std()-Z                    
 [7] tGravityAcc-mean()-X                 tGravityAcc-mean()-Y                
 [9] tGravityAcc-mean()-Z                 tGravityAcc-std()-X                 
[11] tGravityAcc-std()-Y                  tGravityAcc-std()-Z                 
[13] tBodyAccJerk-mean()-X                tBodyAccJerk-mean()-Y               
[15] tBodyAccJerk-mean()-Z                tBodyAccJerk-std()-X                
[17] tBodyAccJerk-std()-Y                 tBodyAccJerk-std()-Z                
[19] tBodyGyro-mean()-X  ;                 tBodyGyro-mean()-Y                  
[21] tBodyGyro-mean()-Z                   tBodyGyro-std()-X                   
[23] tBodyGyro-std()-Y                    tBodyGyro-std()-Z                   
[25] tBodyGyroJerk-mean()-X               tBodyGyroJerk-mean()-Y              
[27] tBodyGyroJerk-mean()-Z               tBodyGyroJerk-std()-X               
[29] tBodyGyroJerk-std()-Y                tBodyGyroJerk-std()-Z               
[31] tBodyAccMag-mean()                   tBodyAccMag-std()                   
[33] tGravityAccMag-mean()                tGravityAccMag-std()                
[35] tBodyAccJerkMag-mean()               tBodyAccJerkMag-std()               
[37] tBodyGyroMag-mean()                  tBodyGyroMag-std()                  
[39] tBodyGyroJerkMag-mean()              tBodyGyroJerkMag-std()              
[41] fBodyAcc-mean()-X                    fBodyAcc-mean()-Y                   
[43] fBodyAcc-mean()-Z                    fBodyAcc-std()-X                    
[45] fBodyAcc-std()-Y                     fBodyAcc-std()-Z                    
[47] fBodyAcc-meanFreq()-X                fBodyAcc-meanFreq()-Y               
[49] fBodyAcc-meanFreq()-Z                fBodyAccJerk-mean()-X               
[51] fBodyAccJerk-mean()-Y                fBodyAccJerk-mean()-Z               
[53] fBodyAccJerk-std()-X                 fBodyAccJerk-std()-Y                
[55] fBodyAccJerk-std()-Z                 fBodyAccJerk-meanFreq()-X           
[57] fBodyAccJerk-meanFreq()-Y            fBodyAccJerk-meanFreq()-Z           
[59] fBodyGyro-mean()-X                   fBodyGyro-mean()-Y                  
[61] fBodyGyro-mean()-Z                   fBodyGyro-std()-X                   
[63] fBodyGyro-std()-Y                    fBodyGyro-std()-Z                   
[65] fBodyGyro-meanFreq()-X               fBodyGyro-meanFreq()-Y              
[67] fBodyGyro-meanFreq()-Z               fBodyAccMag-mean()                  
[69] fBodyAccMag-std()                    fBodyAccMag-meanFreq()              
[71] fBodyBodyAccJerkMag-mean()           fBodyBodyAccJerkMag-std()           
[73] fBodyBodyAccJerkMag-meanFreq()       fBodyBodyGyroMag-mean()             
[75] fBodyBodyGyroMag-std()               fBodyBodyGyroMag-meanFreq()         
[77] fBodyBodyGyroJerkMag-mean()          fBodyBodyGyroJerkMag-std()          
[79] fBodyBodyGyroJerkMag-meanFreq()      angle(tBodyAccMean,gravity)         
[81] angle(tBodyAccJerkMean),gravityMean) angle(tBodyGyroMean,gravityMean)    
[83] angle(tBodyGyroJerkMean,gravityMean) angle(X,gravityMean)                
[85] angle(Y,gravityMean)                 angle(Z,gravityMean)  

#### AverageOfVariableName  
+  Calculated variable using summarise() mean function with the data group_by ActivityDecription, Subject and VariableNames  
+  Ranges in values are normalized and bounded within [-1,1] corresponding to values in the source data

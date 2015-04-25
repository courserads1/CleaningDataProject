# Getting and Cleaning Data Course Project  



### GitHub Repository: courseads1/CleaningDataProject  



### Data for R Script
+ [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
+ Data was manually downloaded and unzipped then moved into subdirectory data. Path statements include all other subdirectory (test, train) references built from unzipped structure. 
+ Description of the data is available at [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  



### Coding Strategy  


#### Overview of run_analysis.R script (these comments also included in beginning of the script)

  + Set working directory, data in ./data.   
  Instructions did not require downloading and unzip using R although this could be done  with download.file() and unzip() from utils package

  + make any packages available 

  + using head(), tail() and dim() reivew all files to obtain data and labels

  + work with X then Y data  
  process is to investigate contents of X and Y data for both test and train  
  test and train within X and within Y could be the same structure when combining always combine in the same order (selected to rbind test then train)

  + column labels  
  for X data these are in features.txt and were added colnames()

  + once x_test combined with y_train then combine X and Y combined files  
  Y did not have a file containing labels so appropiate values were assigned

  + Subject data also had test and train versions and were read adding an descriptive column 
  name and combined in test-train order

  + Activity file read with descriptive column names assigned.  Data was then merged with the 
  combined X, Y data (test and train files have been combined within each type at this point)
  
  + Merged used to add the ActivityDescription and ActivityCode (key used to merge on) was
  later dropped.  

  + Mean and STD variables  
  there were a large number of metrics not of interest. A grep statement was used in the merge to only include vriables that contained mean and std in the names.  
  Mean and mean spellings had to be included to capture all mean variables

 +  Melt was used to go from wide to long version of the data  
 Data was first group_by(ActivityDescription, Subject, VariableName) then Summarise() used to create wide version of mean of all the metrics by Activity and Subject combination.
 
 +  tidy_long data set was created with description variable names and columns reordered then
 txt version of tidy_long created using write.table().


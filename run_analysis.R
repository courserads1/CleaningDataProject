## Overview of run_analysis.R script
##  these comments also embedded in script
##
##  Set working directory, data in ./data
##   instructions did not require downloading and unzip using R although this could
##   be done download.file() and unzip() from utils package
##
##  make any packages available 
##
##  using head(), tail() and dim() reivew all files to obtain data and labels
##
##  work with X then Y data
##   process is to investigate contents of X and Y data for both test and train
##   test and train within X and within Y could be the same structure
##   when combining always combine in the same order (selected to rbind test then train)
##
##  column labels
##   for X data these are in features.txt and were added colnames()
##
##  once ?_test combined with ?_train for X and Y then combine X and Y combined files
##  Y did not have a file containing labels so appropiate values were assigned
##
##  Subject data also had test and train versions and were read adding an descriptive column 
##  name and combined in test-train order
##
##  Activity file read with descriptive column names assigned.  Data was then merged with the 
##  combined X, Y data (test and train files have been combined within each type at this point)
##  Merged used to add the ActivityDescription and ActivityCode (key used to merge on) was
##  later dropped.  
##
##  Mean and STD variables
##   there were a large number of metrics not of interest. A grep statement was used in the 
##   merge to only include vriables that contained mean and std in the names.
##   Mean and mean had to be included to capture all mean variables
##
## Melt was used to go from wide to long version of the data yy Activity, Subject, 
##  measurement type, measurement
## Summarise() used to create wide version of mean of all the metrics by Activity and Subject
##  combination.
## 
## tidy_long data set was created with description variable names and columns reordered then
## txt version of tidy_long created.
##
##


## set working directory
setwd("E:/SigTrck/C3/CleaningDataProject")

## make packages available
library(dplyr)
# install.packages("reshape2")
library(reshape2)

## discovery on X_.... data files
##   look at test then train using dim() and head()
x_test = read.table("./data/test/X_test.txt");
dim(x_test)
# [1] 2947  561
# names(x_test) v1 thru v561
head(x_test)

x_train = read.table("./data/train/X_train.txt");
dim(x_train)
# [1] 7352  561
# names(x_train) v1 thru v561
head(x_train)


## X files have the same number of variables and same column names
## combine x_test and x_train into x_data
## combine y files in same order
x_data <- rbind(x_test, x_train )
dim(x_data)
# [1] 10299   561

## look for variable names for X file
## labels for X_.... data files
features <- read.table("./data/features.txt")
dim(features)
# [1] 561   2
head(features)
# V1                V2
# 1  1 tBodyAcc-mean()-X
# 2  2 tBodyAcc-mean()-Y
# 3  3 tBodyAcc-mean()-Z
# 4  4  tBodyAcc-std()-X
# 5  5  tBodyAcc-std()-Y
# 6  6  tBodyAcc-std()-Z

## add labels to combined x_test and x_train datasets, x_data
x_labels <- as.character(features[[2]])
colnames(x_data) <- x_labels
head(x_data, 1)
# [1] 10299   561


## Discovery on y_.... data
## similar to X but not label file, specify col.names
y_test <- read.table("./data/test/y_test.txt", col.names="ActivityCode");
dim(y_test)
# [1] 2947    1
names(y_test)
head(y_test)
table(y_test)
# y_test
#    1   2   3   4   5   6 
#  496 471 420 491 532 537 

y_train = read.table("./data/train/y_train.txt", col.names="ActivityCode");
dim(y_train)
# [1] 7352    1
head(y_train)
table(y_train)
# y_train
#    1    2    3    4    5    6 
# 1226 1073  986 1286 1374 1407  

## combine y_test and y_train into y_data
y_data <- rbind(y_test, y_train )
dim(y_data)
# [1] 10299     1


## combine y_data and x_data into data
c_data <- cbind(y_data, x_data)
dim(c_data)
# [1] 10299   562
head(c_data,1)
#   ActivityCode tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y
# 1            5         0.2571778       -0.02328523       -0.01465376        -0.938404       -0.9200908
#   tBodyAcc-std()-Z tBodyAcc-mad()-X tBodyAcc-mad()-Y tBodyAcc-mad()-Z tBodyAcc-max()-X tBodyAcc-max()-Y
# 1       -0.6676833       -0.9525011       -0.9252487       -0.6743022       -0.8940875       -0.5545772


## Discovery on subject_.... data 
subject_test = read.table("./data/test/subject_test.txt", col.names="Subject");
dim(subject_test)
# [1] 2947    1
table(subject_test)
# subject_test
#   2   4   9  10  12  13  18  20  24 
# 302 317 288 294 320 327 364 354 381 

subject_train = read.table("./data/train/subject_train.txt", col.names="Subject");
dim(subject_train)
# [1] 7352    1
table(subject_train)
# subject_train
#   1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27  28  29  30 
# 347 341 302 325 308 281 316 323 328 366 368 360 408 321 372 409 392 376 382 344 383 

## combined subject covers values 1 - 30 per documentation
## combine subject_test and subject_train into subject_data
subject_data <- rbind(subject_test, subject_train )
dim(subject_data)
# [1] 10299     1
head(subject_data)

## combine subject_data and c_data 
sc_data <- cbind(subject_data, c_data)
dim(sc_data)
# [1] 10299   563
head(sc_data,1)


##  read the activity_labels.txt file and create labels 
activity_labels <- read.table("./data/activity_labels.txt", col.names=c("ActivityCode", "ActivityDescription"))
activity_labels
#    ActivityCode ActivityDescription
# 1             1             WALKING
# 2             2    WALKING_UPSTAIRS
# 3             3  WALKING_DOWNSTAIRS
# 4             4             SITTING
# 5             5            STANDING
# 6             6              LAYING


## merge in ActivityDescription by ActivityCode
merged_data <-merge(activity_labels,sc_data,by.x="ActivityCode",by.y="ActivityCode",all=TRUE)
dim(merged_data)
# [1] 10299   564
head(select(merged_data, 1:5))
#   ActivityCode ActivityDescription Subject tBodyAcc-mean()-X tBodyAcc-mean()-Y
# 1            1             WALKING      26         0.2314146      -0.017722438
# 2            1             WALKING      29         0.3312213      -0.018502366
# 3            1             WALKING      29         0.3755700      -0.024728610
# 4            1             WALKING      29         0.2332297      -0.034451457
# 5            1             WALKING      29         0.2362494      -0.014396940
# 6            1             WALKING      29         0.2645428       0.002484389
 
table(merged_data$Subject)
#   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26 
# 347 302 341 317 302 325 308 281 288 294 316 320 327 323 328 366 368 364 360 354 408 321 372 381 409 392 
#  27  28  29  30 
# 376 382 344 383 

table(merged_data$ActivityCode)
#    1    2    3    4    5    6 
# 1722 1544 1406 1777 1906 1944


## subset on 3 id variables plus any mean or std variables
subset_data <- merged_data[c("ActivityCode", "ActivityDescription", "Subject", 
                             grep("[a-z]?[A-Z]?(Mean|mean|std)[a-z]?[A-Z]?", names(merged_data), value = TRUE))]
## drop ActivityCode, keep ActivityDescription
subset_data <- select(subset_data, -(ActivityCode))
head(select(subset_data, 1:8))
#   ActivityDescription Subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
# 1             WALKING      26         0.2314146      -0.017722438        -0.1222005       -0.4194264
# 2             WALKING      29         0.3312213      -0.018502366        -0.1697166       -0.1451590
# 3             WALKING      29         0.3755700      -0.024728610        -0.1566118       -0.1066708
# 4             WALKING      29         0.2332297      -0.034451457        -0.1048158       -0.1749531
# 5             WALKING      29         0.2362494      -0.014396940        -0.1244713       -0.2096845
# 6             WALKING      29         0.2645428       0.002484389        -0.1117034       -0.1941433
#   tBodyAcc-std()-Y tBodyAcc-std()-Z
# 1     -0.139233660      -0.38623228
# 2     -0.098248375      -0.02385757
# 3      0.066085029      -0.19732937
# 4      0.004314354      -0.31542637
# 5     -0.074924698      -0.24701239
# 6     -0.049832762      -0.19151835
 
dim(subset_data)
# [1] 10299    88
head(subset_data,1)

# go from wide to long format
long <- melt(subset_data, id.vars=c("ActivityDescription", "Subject"))
dim(long)
# [1] 885714      4

colnames(long)[3] <- "VariableName"
head(long,3)
#   ActivityDescription Subject      VariableName     value
# 1             WALKING      26 tBodyAcc-mean()-X 0.2314146
# 2             WALKING      29 tBodyAcc-mean()-X 0.3312213
# 3             WALKING      29 tBodyAcc-mean()-X 0.3755700

table(long$variable)
# tBodyAcc-mean()-X                    tBodyAcc-mean()-Y 
#             10299                                10299 
# tBodyAcc-mean()-Z                     tBodyAcc-std()-X 
#             10299                                10299 

## verify 30 subjects
table(long$Subject)

## group the data so it can be summarised then summarize
g_long <- group_by(long, ActivityDescription, Subject, VariableName)
tidy_long <- summarise(g_long, average = mean(value, na.rm = TRUE))
colnames(tidy_long)[4] <- "AverageOfVariableName"

## arrange to columns to be Subject, ActivityDescription, VariableName, AverageOfVariableName
tidy_long <- select(tidy_long, c(2, 1, 3, 4))
head(tidy_long)

write.table(tidy_long, file="./tidy_long.txt",row.names = FALSE)

# CodeBook


## Code description
There is a R script called `run_analysis.R` in this repository. It contans three functions:

* `get_dataset <- function (datadir="UCI HAR Dataset")`

	This function reads the Samsung data and return the merged tidy dataset with all of the needed measurements.
	1. Read the `activity_labels.txt` table.
	2. Read the `features.txt` table.
	3. Extract only the features that related the mean and standard deviation.
	4. For each set (train and test) read the `X_%set%.txt` file with measurements and the `y_%set%.txt` file with activity ids. Replace activity ids with activity labels. Read the `subject_%set%.txt` file with subject ids.
	5. Merge they in one data set and return it.
* `get_tidy <- function (dataset=data.frame())`
	
	This function takes the dataset from `get_dataset ` and makes a tidy dataset with the average of each variable for each activity and each subject.
	1. Split the dataset by subject.
	2. For each subject split the dataset by activity.
	3. For each subject and activity calculate average of each feature variable.
	4. Store the results in a new dataset and return it.
* `run_analysis <- function (datadir="UCI HAR Dataset")`
	
	This is agregate function with does following steps:
	1. Run `get_dataset` and store the result dataset.
	2. Run `get_tidy` and pass the stored dataset in it as an argument.
	3. Return the result of `get_tidy`.

## Usage

You can use `run_analysis` function for getting the result tidy dataset like this:

```
> source("run_analysis.R")
> tidy <- run_analysis()
``` 

Be sure that the Samsung data is in your working directory or use the `datadir=` argument.

## Structure of the result dataset

A copy of the result tidy dataset saved in the `tidy.txt` file. It contains a table with 180 observation of 50 variables.

```
 $ subj.id             : int  [1..30]
 $ activity.label      : Factor w/ 6 levels:
  								"LAYING" "SITTING" "STANDING" 
  								"WALKING" "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"
 $ tBodyAcc.mean.X     : num [-1..1]
 $ tBodyAcc.mean.Y     : num [-1..1]
 $ tBodyAcc.mean.Z     : num [-1..1]
 $ tBodyAcc.std.X      : num [-1..1]
 $ tBodyAcc.std.Y      : num [-1..1]
 $ tBodyAcc.std.Z      : num [-1..1]
 $ tGravityAcc.mean.X  : num [-1..1]
 $ tGravityAcc.mean.Y  : num [-1..1]
 $ tGravityAcc.mean.Z  : num [-1..1]
 $ tGravityAcc.std.X   : num [-1..1]
 $ tGravityAcc.std.Y   : num [-1..1]
 $ tGravityAcc.std.Z   : num [-1..1]
 $ tBodyAccJerk.mean.X : num [-1..1]
 $ tBodyAccJerk.mean.Y : num [-1..1]
 $ tBodyAccJerk.mean.Z : num [-1..1]
 $ tBodyAccJerk.std.X  : num [-1..1]
 $ tBodyAccJerk.std.Y  : num [-1..1]
 $ tBodyAccJerk.std.Z  : num [-1..1]
 $ tBodyGyro.mean.X    : num [-1..1]
 $ tBodyGyro.mean.Y    : num [-1..1]
 $ tBodyGyro.mean.Z    : num [-1..1]
 $ tBodyGyro.std.X     : num [-1..1]
 $ tBodyGyro.std.Y     : num [-1..1]
 $ tBodyGyro.std.Z     : num [-1..1]
 $ tBodyGyroJerk.mean.X: num [-1..1]
 $ tBodyGyroJerk.mean.Y: num [-1..1]
 $ tBodyGyroJerk.mean.Z: num [-1..1]
 $ tBodyGyroJerk.std.X : num [-1..1]
 $ tBodyGyroJerk.std.Y : num [-1..1]
 $ tBodyGyroJerk.std.Z : num [-1..1]
 $ fBodyAcc.mean.X     : num [-1..1]
 $ fBodyAcc.mean.Y     : num [-1..1]
 $ fBodyAcc.mean.Z     : num [-1..1]
 $ fBodyAcc.std.X      : num [-1..1]
 $ fBodyAcc.std.Y      : num [-1..1]
 $ fBodyAcc.std.Z      : num [-1..1]
 $ fBodyAccJerk.mean.X : num [-1..1]
 $ fBodyAccJerk.mean.Y : num [-1..1]
 $ fBodyAccJerk.mean.Z : num [-1..1]
 $ fBodyAccJerk.std.X  : num [-1..1]
 $ fBodyAccJerk.std.Y  : num [-1..1]
 $ fBodyAccJerk.std.Z  : num [-1..1]
 $ fBodyGyro.mean.X    : num [-1..1]
 $ fBodyGyro.mean.Y    : num [-1..1]
 $ fBodyGyro.mean.Z    : num [-1..1]
 $ fBodyGyro.std.X     : num [-1..1]
 $ fBodyGyro.std.Y     : num [-1..1]
 $ fBodyGyro.std.Z     : num [-1..1]
```

### Description

* `subj.id` The subject identificator.
* `activity.label` The label of the activity.
* All of other colums contain the average values of the features those come from the accelerometer and gyroscope 3-axial raw signals. There are mean values (`mean`) and standard deviation values (`std`).
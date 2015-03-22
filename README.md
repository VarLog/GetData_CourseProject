# GetData CourseProject
Course Project for **Getting and Cleaning Data** course on Coursera.

## Description

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


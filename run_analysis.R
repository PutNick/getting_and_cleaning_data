library(plyr)


# Step 1
# Merge the training- and test sets to create one data set


xtrain <- read.table("F:/GitHub/getting_and_cleaning_data/train/X_train.txt")
ytrain <- read.table("F:/GitHub/getting_and_cleaning_data/train/y_train.txt")
subjecttrain <- read.table("F:/GitHub/getting_and_cleaning_data/train/subject_train.txt")

xtest <- read.table("F:/GitHub/getting_and_cleaning_data/test/X_test.txt")
ytest <- read.table("F:/GitHub/getting_and_cleaning_data/test/y_test.txt")
subjecttest <- read.table("F:/GitHub/getting_and_cleaning_data/test/subject_test.txt")

x_data <- rbind(xtrain, xtest)
y_data <- rbind(ytrain, ytest)
subject_data <- rbind(subjecttest, subjecttrain)

## Step 2 
## Extracts only the measurements on the mean and standard deviation for each measurement.
## For X

features <- read.table("F:/GitHub/getting_and_cleaning_data/features.txt") ## The Name-Vectore
mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std]
names(x_data) <- features[mean_and_std, 2]

## For Y

activities <- read.table("F:/GitHub/getting_and_cleaning_data/activity_labels.txt")
y_data <- activities[y_data[, 1], 2]
names(y_data) <- "activity"

## Step 3

names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)


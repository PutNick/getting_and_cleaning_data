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

features <- read.table("F:/GitHub/getting_and_cleaning_data/features.txt") 
mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std]
names(x_data) <- features[mean_and_std, 2]

## Step 3: read in the activity.txt in order to replace numbers by the categoric variable

activities <- read.table("F:/GitHub/getting_and_cleaning_data/activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- c("activity")

## Step 4: finally label all data and merge it into one tidy data set

names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)

## Step 5: Create a seperate tidy dataset for each individual and each activity

average_data <- ddply(all_data, c("subject", "activity"), numcolwise(mean))

write.table(average_data, "tidy.txt", row.names = FALSE, quote = FALSE)


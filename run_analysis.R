
# Creating the Training dataset
training <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
training <- cbind(training,read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE))
training <- cbind(training, read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE))

# Creating the Testing dataset
testing  <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testing <- cbind(testing, read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE))
testing <- cbind(testing, read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE))

# Read the activity_labels txt file
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

#Read the features.txt file
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE, stringsAsFactors=FALSE)

# Merge training and test sets together
allData = rbind(training, testing)

# Adding colnames to the allData 
colnames(allData) <- c(features$V2, "Activity", "Subject")

# Get only the data on mean and std. dev.
colsWeWant <- grep(".*mean.*|.*std.*", features[,2])

allData <- subset(allData, select = c(colsWeWant,Activity,Subject))

#Add Descriptive Activity Names
currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
  allData$Activity <- gsub(currentActivity, currentActivityLabel, allData$Activity)
  currentActivity <- currentActivity + 1
}

allData$Activity <- as.factor(allData$Activity)
allData$Subject <- as.factor(allData$Subject)

# Create the Tidy data set
tidy = aggregate(allData, by=list(Activities = allData$Activity, Subjects=allData$Subject), mean)

# Remove the subject and activity column, since a mean of those has no use
tidy <- subset(tidy, select = -c(Activity,Subject))

write.table(tidy, "tidy.txt", sep="\t", row.name=FALSE)
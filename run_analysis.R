# GET THE DATA FOR THE PROJECT FROM THE URL

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- tempfile()

if (file.exists(fileURL) == FALSE) {
  download.file(fileURL, destfile, mode="wb")
}

# GET THE FILES FROM THE ZIP

if (file.exists(destfile) == FALSE) {
  unzip(destfile)
}

# DELETE THE ZIP FILE
unlink(destfile)

# STORE FEATURES FILE IN A TABLE
features <- read.table("./UCI HAR Dataset/features.txt")

# STORE ACTIVITY LABELS FILE IN A TABLE
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# STORE TEST LABELS IN A TABLE
testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names="activity")

# STORE TRAINING LABELS FILE IN A TABLE
trainlabels <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="activity")

# STORE TEST SUBJECT IN A TABLE
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="subject")

# STORE TRAINING SUBJECT FILE IN A TABLE
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subject")

# STORE TEST DATA IN A TABLE
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")

# STORE TRAINING DATA FILE IN A TABLE
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")

# 1. MERGING TEST AND TRAINING DATA SET TO CREATE ONE DATA SET

colnames(testdata) <- features[,2]
colnames(traindata) <- features[,2]

data <- cbind(rbind(testdata, traindata))

# 2. EXTRACTING ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT 

mean.std.data <- data[,grep("mean\\(\\)|std\\(\\)", colnames(data))]

# MERGING THE DATA SET ADDING LABEL AND SUBJECT DATA
mean.std.data <- cbind(rbind(testsubject, trainsubject), rbind(testlabels, trainlabels), mean.std.data)

# 3. USE DESCRIPTIVE ACTIVITY NAME TO NAME THE ACTIVITIES IN THE DATA SET

# REMOVE "_" AND TOLOWER ATIVITIES
activities[,2] <- tolower(gsub("_"," ",activities[,2]))

mean.std.data$activity <- activities[mean.std.data$activity,2]

# 4. APROPIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

# REMOVE () AND - FROM VARIABLE NAMES
names(mean.std.data) <- tolower(gsub("\\(|\\)|-","",names(mean.std.data)))
  
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

melted.data <- melt(mean.std.data,id.vars=c("subject","activity"))

tidy.data <- dcast(melted.data, subject + activity ~ variable, mean)                                

write.table(tidy.data, "./UCI HAR Dataset/tidy_data.txt", row.names = FALSE)


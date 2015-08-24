
##Project Assignement

setwd("~/R/Getting&Cleaning-Datas/Week3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

## Merging the train and the test sets

# getting the train sets
X_train <- read.table("./train/X_train.txt", header = FALSE)
Y_train <- read.table("./train/y_train.txt", header = FALSE)
Subject_train <- read.table("./train/subject_train.txt", header = FALSE)

# getting the test sets
X_test <- read.table("./test/X_test.txt", header = FALSE)
Y_test <- read.table("./test/y_test.txt", header = FALSE)
Subject_test <- read.table("./test/subject_test.txt", header = FALSE)

#Combining the sets

X<-rbind(X_train,X_test)
Y<-rbind(Y_train,Y_test)
Subject<-rbind(Subject_train,Subject_test)

## Extracts only the measurements on the mean and standard deviation for each measurement. 

col_names <- read.table("./features.txt")[2]
mean_sd_cols <- grep("^.*-mean.*$", as.character(col_names$V2))
X_mean_sd<-X[,mean_sd_cols]
names(X_mean_sd)<-col_names[mean_sd_cols,]

##Uses descriptive activity names to name the activities in the data set

activities <- read.table("./activity_labels.txt", col.names=c("actId", "actLabel"))

names(Y)<-"actId"

dataset_labels <- merge(Y, activities, by="actId")$actLabel

## Appropriately labels the data set with descriptive variable names
names(Subject)<-"subject"
names(dataset_labels)<-"actLabel"
dataset<-cbind(X_mean_sd,Subject,dataset_labels)

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_dataset<- aggregate(dataset[,1:length(mean_sd_cols)], list(dataset$dataset_labels,dataset$subject),mean)

# Reading the features of the dataset
directory<-"/Users/Gaia/Downloads/UCI HAR Dataset"
setwd(directory)
column_name<-read.table("features.txt")
column_name<-column_name[,2]

# Reading the tables for the test variables
directory_test<-"/Users/Gaia/Downloads/UCI HAR Dataset/test"
setwd(directory_test)
x_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")
subject_test<-read.table("subject_test.txt")

# Reading the tables for the train variables
directory_train<-"/Users/Gaia/Downloads/UCI HAR Dataset/train"
setwd(directory_train)
x_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")
subject_train<-read.table("subject_train.txt")

# 1. Creating the general table
train_data<-cbind(subject_train,y_train,x_train)
test_data<-cbind(subject_test,y_test,x_test)
data<-rbind(test_data,train_data)
column_name<-c("subject ids","activity names",column_name)
colnames(data)<-column_name

# 2. Extracting the mean() and std() variables
new_data12<-data[,1:2]
values_mean<-cbind(data$`fBodyAccMag-mean()`,data$`tBodyAccMag-mean()`, data$`tBodyGyroMag-mean()`,data$`tGravityAccMag-mean()`,
                   data$`tBodyAccJerkMag-mean()`, data$`fBodyBodyGyroMag-mean()`,data$`tBodyGyroJerkMag-mean()`,data$`fBodyBodyAccJerkMag-mean()`,
                   data$`fBodyBodyGyroJerkMag-mean()`)
values_std<-cbind(data$`fBodyAccMag-std()`,data$`tBodyAccMag-std()`,data$`tBodyGyroMag-std()`,data$`tGravityAccMag-std()`,
                  data$`tBodyAccJerkMag-std()`,data$`fBodyBodyGyroMag-std()`,data$`tBodyGyroJerkMag-std()`,data$`fBodyBodyAccJerkMag-std()`,
                  data$`fBodyBodyGyroJerkMag-std()`)
new_data_emd<-cbind(values_mean,values_std)
new_data<-cbind(new_data12,new_data_emd)

# 3. Name the activities in the dataset
n<-dim(new_data)[1]
l=1:n
i=1
for (i in l) {
  if(new_data$`activity names`[i]==1)
    new_data$`activity names`[i]="WALKING"
  if(new_data$`activity names`[i]==2)
    new_data$`activity names`[i]="WALKING UPSTAIRS"
  if(new_data$`activity names`[i]==3)
    new_data$`activity names`[i]="WALKING DOWNSTAIRS"
  if(new_data$`activity names`[i]==4)
    new_data$`activity names`[i]="SITTING"
  if(new_data$`activity names`[i]==5)
    new_data$`activity names`[i]="STANDING"
  if(new_data$`activity names`[i]==6)
    new_data$`activity names`[i]="LAYING"
i=i+1
}

# 4. Label the dataset 
colnames(new_data)<-c("subject", "activity", "freq BodyAccMag mean", "time BodyAccMag mean",
                      "time BodyGyroMag mean","time GravityAccMag mean","time BodyAccJerkMag mean","freq BodyBodyGyroMag mean",
                      "time BodyGyroJerkMag mean","freq BodyBodyAccJerkMag mean","freq BodyBodyGyroJerkMag mean","freq BodyAccMag std",
                      "time BodyAccMag std","time BodyGyroMag std","time GravityAccMag std","time BodyAccJerkMag std",
                      "freq BodyBodyGyroMag std","time BodyGyroJerkMag std","freq BodyBodyAccJerkMag std","freq BodyBodyGyroJerkMag std")

# 5. Creating the new tidy dataset with averages for each activities and subject
new_data2<-aggregate(x=new_data,by=list(new_data$`subject`,new_data$`activity`),FUN=mean)
new_data2<-new_data2[,-(3:4)]
colnames(new_data2)<-c("subject", "activity", "freq BodyAccMag mean", "time BodyAccMag mean",
                       "time BodyGyroMag mean","time GravityAccMag mean","time BodyAccJerkMag mean","freq BodyBodyGyroMag mean",
                       "time BodyGyroJerkMag mean","freq BodyBodyAccJerkMag mean","freq BodyBodyGyroJerkMag mean","freq BodyAccMag std",
                       "time BodyAccMag std","time BodyGyroMag std","time GravityAccMag std","time BodyAccJerkMag std",
                       "freq BodyBodyGyroMag std","time BodyGyroJerkMag std","freq BodyBodyAccJerkMag std","freq BodyBodyGyroJerkMag std")

# writing the file .txt
write.table(new_data2, file="tidydata.txt", row.names = FALSE)
#to import remember to put header=TRUE in read.table()


rm(list=ls())
library(dplyr)
setwd("C:/Users/Usuario 2/Dropbox/Coursera/Data Science/GettingAndCleaningData/FinalProyect/UCI HAR Dataset")

#Here we load the labels that correspond to the activities and the Features
Activities<-read.table("./activity_labels.txt")
Features<-read.table("./features.txt")

#Here we load all the corresponding data for the test data and train data
TestX<-read.table("./test/X_test.txt")
TrainX<-read.table("./train/X_train.txt")
#We rename the TestX
names(TestX)=Features$V2
names(TrainX)=Features$V2

#Combine the two data sets
Test<-rbind(TestX,TrainX)


#The number of the subject tested
SubjectTest<-read.table("./test/subject_test.txt")
SubjectTrain<-read.table("./train/subject_train.txt")
Subject<-rbind(SubjectTest,SubjectTrain)

#The Activity done by the subject j
TypeActivity1<-read.table("./test/y_test.txt")
TypeActivity2<-read.table("./train/y_train.txt")
#Now we change the number of the activity for the activity name
TypeActivity1<-factor(TypeActivity1$V1, labels = Activities$V2)
TypeActivity2<-factor(TypeActivity2$V1, labels = Activities$V2)
TypeActivity<-factor(c(TypeActivity1,TypeActivity2), labels = Activities$V2)

#We create the database including the the training and test sets
Base<-data.frame(Subject,TypeActivity,Test)
names(Base)[1]="Subject"

#Now we get only the measures corresponding to the mean and std of every variable
Base=Base[,grep("Subject|TypeActivity|mean|std",names(Base))]
Base<-arrange(Base,Subject,desc(TypeActivity))

#We group the data in relation with the Subject and the Activity
BaseGrouped<-group_by(Base,Subject,TypeActivity)

#Now we create the second tidy data that correspond to the average of each variable for each activity and each subject
Base2<-summarise(BaseGrouped,mean(tBodyAcc.mean...X),mean(tBodyAcc.mean...Y),              
mean(tBodyAcc.mean...Z),mean(tBodyAcc.std...X),mean(tBodyAcc.std...Y),mean(tBodyAcc.std...Z),               
          mean(tGravityAcc.mean...X),mean(tGravityAcc.mean...Y),           
          mean(tGravityAcc.mean...Z),mean(tGravityAcc.std...X),            
          mean(tGravityAcc.std...Y),mean(tGravityAcc.std...Z),        
          mean(tBodyAccJerk.mean...X),mean(tBodyAccJerk.mean...Y),
          mean(tBodyAccJerk.mean...Z),mean(tBodyAccJerk.std...X),           
          mean(tBodyAccJerk.std...Y),mean(tBodyAccJerk.std...Z),           
          mean(tBodyGyro.mean...X),              mean(tBodyGyro.mean...Y),             
          mean(tBodyGyro.mean...Z),              mean(tBodyGyro.std...X),              
          mean(tBodyGyro.std...Y),          mean(tBodyGyro.std...Z),              
          mean(tBodyGyroJerk.mean...X),         mean(tBodyGyroJerk.mean...Y),         
          mean(tBodyGyroJerk.mean...Z),          mean(tBodyGyroJerk.std...X),          
          mean(tBodyGyroJerk.std...Y),           mean(tBodyGyroJerk.std...Z),          
          mean(tBodyAccMag.mean..),              mean(tBodyAccMag.std..),              
          mean(tGravityAccMag.mean..),           mean(tGravityAccMag.std..),           
          mean(tBodyAccJerkMag.mean..),         mean(tBodyAccJerkMag.std..),          
          mean(tBodyGyroMag.mean..),             mean(tBodyGyroMag.std..),             
          mean(tBodyGyroJerkMag.mean..),         mean(tBodyGyroJerkMag.std..),         
          mean(fBodyAcc.mean...X),               mean(fBodyAcc.mean...Y),              
          mean(fBodyAcc.mean...Z),               mean(fBodyAcc.std...X),               
          mean(fBodyAcc.std...Y),                mean(fBodyAcc.std...Z),               
          mean(fBodyAcc.meanFreq...X),           mean(fBodyAcc.meanFreq...Y),          
          mean(fBodyAcc.meanFreq...Z),           mean(fBodyAccJerk.mean...X),          
          mean(fBodyAccJerk.mean...Y),           mean(fBodyAccJerk.mean...Z),          
          mean(fBodyAccJerk.std...X),            mean(fBodyAccJerk.std...Y),           
          mean(fBodyAccJerk.std...Z),            mean(fBodyAccJerk.meanFreq...X),      
          mean(fBodyAccJerk.meanFreq...Y),       mean(fBodyAccJerk.meanFreq...Z),      
          mean(fBodyGyro.mean...X),              mean(fBodyGyro.mean...Y),             
          mean(fBodyGyro.mean...Z),              mean(fBodyGyro.std...X),              
          mean(fBodyGyro.std...Y),               mean(fBodyGyro.std...Z),              
          mean(fBodyGyro.meanFreq...X),          mean(fBodyGyro.meanFreq...Y),         
          mean(fBodyGyro.meanFreq...Z),          mean(fBodyAccMag.mean..),             
          mean(fBodyAccMag.std..),               mean(fBodyAccMag.meanFreq..),         
          mean(fBodyBodyAccJerkMag.mean..),      mean(fBodyBodyAccJerkMag.std..),      
          mean(fBodyBodyAccJerkMag.meanFreq..),  mean(fBodyBodyGyroMag.mean..),        
          mean(fBodyBodyGyroMag.std..),          mean(fBodyBodyGyroMag.meanFreq..),    
          mean(fBodyBodyGyroJerkMag.mean..),     mean(fBodyBodyGyroJerkMag.std..),     
          mean(fBodyBodyGyroJerkMag.meanFreq..))

write.table(Base2, file ="./DataSet", row.names = FALSE)

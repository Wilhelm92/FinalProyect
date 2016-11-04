# FinalProyect
The file run_analysis correspond to the code that allowds us to achieve the results asked in the activity.
In order to do that, you shoul change your working directory where you have store the datasets that are needed.

The code first load the datasets corresponding to train and test and the labels corresponding to the name of the activities and the name of the features. Then the code put the correspondig name to the activities and features and then we only select the columns releated to the mean and the std of each feature.

We did this for the to datasets(train and test) and then we merge both to have only one dataset, then we group this dataset by subjects and by activities in order to get the mean of the features for each subject and activity.

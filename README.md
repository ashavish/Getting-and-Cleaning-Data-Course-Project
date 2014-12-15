
##Creating a tidy Dataset using Human Activity Recognition Using Smartphones Dataset

---

### File Information from UCI HAR Dataset

---
**activity\_labels.txt** - 6 obs.of 2 variables : Activities mapped to their respective codes.
features.txt - 561 obs. of 2 variables. : Contains the list of all the features

**X\_train.txt** - 7352 Obs.of 561 variables : Contain observations for each of the 561 features from features.txt for each of the 7352 window samples in training set

**Y\_train.txt** - 7352 Obs.of 1 variable with values ranging from 1 to 6 : Contains details for Activty which was done for each of 7352 window samples in training set

**subject\_train.txt** - 7352 obs.of 1 variable with values ranging from 1 to 30: Contains details of the Subject who performed the experiment for each of 7352 window samples in training set

**body\_acc\_x\_train.txt,body\_acc\_y\_train.txt,body\_acc\_z\_train.txt,total\_acc\_x\_train.txt,total\_acc\_y\_train.txt,total\_acc\_z\_train.txt,body\_gyro\_x\_train.txt,body\_gyro\_y\_train.txt, body\_gyro\_z\_train.txt**   : All these files contain  7352 obs. of 128 variables captured/derived from Smartphone Accelerator and Gyroscope in training set

**X\_test.txt** - 2947 obs. of 561 variables: Contain observations for each of the 561 features from features.txt for each of the 2947 window samples in test set

**Y\_train.txt** - 7352 Obs.of 1 variable with values ranging from 1 to 6 : Contains details for Activty which was done for each of 2947 window samples in test set

**subject\_train.txt** - 7352 obs.of 1 variable  with values ranging from 1 to 30 :Contains details of the Subject who performed the experiment for each of 2947 window samples in test set

**body\_acc\_x\_test.txt,body\_acc\_y\_test.txt,body\_acc\_z\_test.txt,total\_acc\_x\_test.txt,total\_acc\_y\_test.txt,total\_acc\_z\_test.txt,body\_gyro\_x\_test.txt,
body\_gyro\_y\_test.txt, body\_gyro\_z\_test.txt**  : All these files contain  2947 obs. of 128 variables captured/derived from Smartphone Accelerator and Gyroscope in test set

----

##Steps for creation of tidy data set

----

1. Create the train data set - The data for 7352 window samples for train data set is present X\_train.txt,subject\_train.txt and Y\_train.txt. Merge all the variables from these three files to get a data set with 7352 window samples for (561+1 Subject + 1 Activity) 563 variables

  R Script Logic -

  - Download the zip and unzip the contents in the working directory
  - Load the data sets
  - Merge Subject and Activity variables into train Dataset by appending them as new variables into the data set

2. Create the test data set - The data for 2947 window samples for train data set is present X\_test.txt,subject\_test.txt and Y\_test.txt. Merge all the variables from these three files to get a data set with 2947 window samples for (561+1+1) 563 variables

  R Script Logic -

  - Load the data sets
  - Merge Subject and Activity columns into test Dataset by appending them as new variables into the data set

3. Merge the train and test data set - In this case the observations recorded for all 563 variables from the data sets have to merged into one single data set. Merging results in 10299 obs. for 563 variables.

  R Script Logic -
  - Convert the subject and activity to numeric after unlisting
  - Merge the data using rbind

4. Naming the variables - The variables in the merged data set are named V1,V2.. and these correspond to names present in the features.txt. The names for variables are updated from the features table except the subject and the activity variables.

  R Script Logic -

  - Assign names to all required columns using colnames function from features$V2

5. Extract only required variables - The required variables are only mean and standard deviation for each of measurement. These are now searched in the variable names of the merged data set and the relevant variable names extracted. Subject and Activity column name is also appended to the variable names.

  R Script Logic -

  - Search for column names which have mean() in them and assign to a vector
  - Search for column names which have std() in them and append to the vector
  - Add Subject and Activity to the vector

6. Prune the data set for required variables - Based on the required variable names, the data set is now pruned to have only those variable names. This prunes the data set to have 10299 obs. for 68 variables.

  R Script Logic -

  - Extract data set with only the required columns based on values stored in the vector created in 5.

7. Descriptive activity names - Activity variable contains values for 1-6. The descriptive values which are present in activity\_labels are looked up and updated in the data set

  R Script Logic -

  - Merge the activity names by joining dataset and the activity_labels using the ActivityId. Drop the ActivityId column after merging and retain just the ActivityNames

8. Assign descriptive names - Use substitutions to replace abbrieviations by full names for all variable names in the data set

  R Script Logic -

  - Assign Descriptive names for all the columns by substitution using gsub

9. Summarize by Subject & Activity and create a tidy data set- For each subject (30 subjects) and Activity (6 activities) combination, take an average of the measurements. This gives us a tidy data set with 180 obs. for 68 variables.

  R Script Logic -

  - Create tidy data set using ddply from plyr package.Use the mean summarization

10. Output tidy data to a text file

  R Script Logic -

  - Write tidyData to a text file



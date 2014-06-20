# CODEBOOK 

## Data Set Information
-----------------------

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain 

## Input files in the Data set
------------------------------

* 'README.txt'

* 'features_info.txt': Shows information about the variables used on the feature vector.

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

## Variables used in the Code
-----------------------------

* A list named data.set is set with the following columns :
* features - Data frame to hold the data set in features.txt
* activity_labels - Data frame to hold the data set in activity_lables.txt
* testing - Data frame to hold the testing related data ( X_test, Y_test and subject )
* training - Data frame to hold the training related data set 
* All units are maintained from the original data set. 
* Execution of run_analysis.R results in the generation of file named tidy_data.csv in the ouput folder.
* extracted_id - It holds the relevant ids  extracted from features data set with keywords as "mean" and "std"
* Extracted_data - This data frame holds the formatted data set to be stored in the data set 1.
* calc_mean - This data frame holds the data set with mean for each subject and each activity

## Output files
---------------
* tidy_data.csv - Comma seperated file containing data set 1
* tidy_data2.csv - Comma seperated file containing data set 2 with mean calculated for each activity and each subject


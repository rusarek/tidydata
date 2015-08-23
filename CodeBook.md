#Codebook for Tidy Data Set Getting and Cleaning Data Course Project

##Original Data Source

The orignal data source is from the "Human Activity Recognition Using Smartphone Data Set".  

###Citation:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
A Public Domain Dataset for Human Activity Recognition Using Smartphones.
21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013.
Bruges, Belgium 24-26 April 2013

###The data can be retieved from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script assumes that the data has been unzipped and is in place in the wokring directory.

###Breif Summary of Original Data
The data is the recording and summary statsof Samsung phone accelometer data from 30 volunteers undertkaing six different activities:
*Laying
*Sitting
*Standing
*Walking
*Walking Downstairs
*Walking Upstairs

Further information on the data set is located with the original data set.

##Data Transformation being performed
The run_analysis script does five different tranformations on the data set:
1. Combines the training and test data from the original data set including attaching the subject id data
2. Relables the acitivty data with the text descriptions
3. Relables frequnecy and time variable names to clarify what those data points are
4. Reduces the data set down to measures dealing with the means and standard deviations
5. Calculates teh mean of all teh variables by subject and activity

This data is then label as tidy_data

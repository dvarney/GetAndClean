GetAndClean
===========


Getting And Cleaning Data JHU Project description of run_analysis.R:

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

 Here are the data for the project:

 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 You should create one R script called run_analysis.R that does the following.

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set.
 4. Appropriately labels the data set with descriptive activity names.
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
 My progaram, run_analysis.R, utilizes the **~UCI HAR Dataset/[test | train]/Inertial Signals/** files, extracting, 
 in situ, as each is read, the appropriate column according to the **features.txt** in the base Dataset folder. This
 file serves as an index into the columns of the **test/trial** data, and are used to build a pre-Tidy dataset, with
 the 'original' signal name, taken from the features.txt file, and attached as a column name. The
 resultant dataset is ordered according to subject number and writen to storage as **tidy.csv**. The description of
 the program follows:
 
    Make the **run_anaysis markdown, *.html** files
    
    initial setup 
        libraries, 
        data structures, 
        required files (Fill 'testFiles' with test/train data [xxx.txt]) 
        paths
        
    Check if exists (UCI HAR Dataset.zip)
        Zipped data file
        if found
            unpack the file
            
    Check if !exists (features.txt)
        read data file
        
    Acquire the test and train subject numbers
    Match activity # with descriptor activity names
    
    Scan features table for offsets to mean and Sd
    Place in mean and Sd [...Only] tables for test/train
    
    Read teh test/trian data file associated with a feature
    name, build the pre-tidy table, column by column
    
    Compute averages for each test/train, they are appended
    to the pre-tidy data. The averages are across all test
    subjects, and within one subject, one test. This will
    provide a better comparison than simply within one 
    subject per test. These calculations are appended to
    the columns.
    
    Order the pre-tidy data in ascending order by subject 
    number
    
    the column names from the extracted mean/sd features
    file needs adding to the pre-tidy data table
    
    Write the tidy data to a file, **tidy.csv**
    Make the **CODEBOOK**
    
    
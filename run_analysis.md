---
title: "run_analysis"
author: "dvarney"
date: "Saturday, August 23, 2014"
output: html_document
---


This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


run_analysis
============
Last updated 2014-08-24 17:21:58 using R version 3.1.1 (2014-07-10).
Instructions for project
------------------------
> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
>
> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
>
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
>
> Here are the data for the project:
>
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
>
> You should create one R script called run_analysis.R that does the following.
>
> 1. **DONE** Merges the training and the test sets to create one data set.
> 2. **DONE** Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. **DONE** Uses descriptive activity names to name the activities in the data set.
> 4. **DONE** Appropriately labels the data set with descriptive activity names.
> 5. **DONE** Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
>

Start Up
-------------
get libraries and init structures

```r
        #get required libraries
        library(data.table)
        library(knitr)
        library(markdown)
    
        #init structures and paths
        pTidy    <- NULL
        iDx      <- NULL
        tMeanSd  <- NULL
        
        pMat0    <- matrix(NA, 1, 4)
        pMat     <- matrix(NA, 1, 128)
        pMat1    <- matrix(NA, 1, 38)
        pAvg     <- matrix(NA, 1, 38)
        mAvg     <- matrix(NA, 2947, 1)
        onlyMean <- matrix(nrow=8, ncol=6)
        onlySd   <- matrix(nrow=8, ncol=6)
        tonlyMean<- matrix(nrow=8, ncol=6)
        tonlySd  <- matrix(nrow=8, ncol=6)
        tavgMean <- NULL
        tavgSd   <- NULL
        
        pathToTestDataSet   <- NULL
        pathToTestDataFile  <- NULL
        pathToTrialDataSet  <- NULL  
        pathToTrialDataFile <- NULL

        testFiles <- c("body_acc_x_test_cpy.txt",   "body_acc_y_test_cpy.txt",   "body_acc_z_test_cpy.txt",
                       "body_gyro_x_test_cpy.txt",  "body_gyro_y_test_cpy.txt",  "body_gyro_z_test_cpy.txt",
                       "total_acc_x_test_cpy.txt",  "total_acc_y_test_cpy.txt",  "total_acc_z_test_cpy.txt",
                       "body_acc_x_train_cpy.txt",  "body_acc_y_train_cpy.txt",  "body_acc_z_train_cpy.txt",
                       "body_gyro_x_train_cpy.txt", "body_gyro_y_train_cpy.txt", "body_gyro_z_train_cpy.txt",
                       "total_acc_x_train_cpy.txt", "total_acc_y_train_cpy.txt", "total_acc_z_train_cpy.txt")
        testMode <- c("subject_test", "y_test")
```
Set paths

```r
        destDir <- "K:/COURSES/JHU_DataScience/GettingAndCleaningData/UCI HAR Dataset"            
        pathToDataSet <- paste(destDir, 'features.txt', sep='/')

        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zipFile <- "getdata_projectfiles_UCI HAR Dataset.zip"             
        destDir1 <- "K:/COURSES/JHU_DataScience/GettingAndCleaningData"
        pathToUnZiped <- "K:/COURSES/JHU_DataScience/GettingAndCleaningData/UCI HAR Dataset"
```
Get the data
------------
Download the files, unzip and load features data.  

```r
        if (!file.exists(paste(pathToUnZiped, zipFile, sep='/'))) 
        {
            message("getting Zipfile")
            download.file(fileUrl, pathToUnZiped)
        }
        
        if (!file.exists(paste(pathToUnZiped, zipFile, sep='/'))) 
        {
            message("getting Zipfile")
            download.file(fileUrl, pathToUnZiped)
        }
        
        #true shows the file tree, false unzips it
        unzip(zipFile, list=FALSE)
        
        #check if already grabbed the column/descriptor file
        if (!file.exists(pathToDataSet))  
        {
            message("Check FEATURES file")
        }
        else
        {
            #print(pathToDataSet)
            message("Read column headings from FEATUES.TXT datafile (index:mean, index:sd)")
            fTable <- read.table(pathToDataSet, header=FALSE, sep=' ', as.is=TRUE)
            #print(sprintf("fTable[%d:%d]", nrow(fTable), ncol(fTable)))  
        }

        #set the test/trial paths
        pathToTestDataSet   <- paste(destDir, 'test/Inertial Signals', sep='/')
        pathToTestDataFile  <- paste(pathToTestDataSet, testFiles[1], sep='/')
        pathToTrialDataSet  <- paste(destDir, 'train/Inertial Signals', sep='/')
        pathToTrialDataFile <- paste(pathToTestDataSet, testFiles[1], sep='/')
```
Read the subject files


```r
        #Read the test/train subject's number 
        subjectTestFile <- paste(destDir, 'test/subject_test.txt', sep='/')
        subject_test <- read.csv(subjectTestFile, header=FALSE, sep='', as.is=TRUE)
        subjectTrainFile <- paste(destDir, 'train/subject_train.txt', sep='/')
        subject_train <- read.csv(subjectTrainFile, header=FALSE, sep='', as.is=TRUE)
```
Read the activity files


```r
        #Get the type of test for the subject, 1:1 match
        yTestFile <- paste(destDir, 'test/y_test.txt', sep='/')
        y_test <- read.csv(yTestFile, header=FALSE, sep='', as.is=TRUE)
        yTrainFile <- paste(destDir, 'train/y_train.txt', sep='/')
        y_train <- read.csv(yTrainFile, header=FALSE, sep='', as.is=TRUE)
```
convert the activity codes to text


```r
        for (i in 1:nrow(y_test))
        {
            activity <- y_test[i,1]
            if (activity == 1) {y_test[i,1] <- "WALKING"}
            else if (activity == 2) {y_test[i,1] <- "WALKING_UPSTAIRS"}
            else if (activity == 3) {y_test[i,1] <- "WALKING_DOWNSTAIRS"}       
            else if (activity == 4) {y_test[i,1] <- "SITTING"}       
            else if (activity == 5) {y_test[i,1] <- "STANDING"}       
            else if (activity == 6) {y_test[i,1] <- "LAYING"}                       
        }
```
cycle through the features file getting only the mean and sd, these are the keys:

[1] "offset into features.txt:"
 [1]   1   2   3  41  42  43  81  82  83 121 122 123 161 162 163 201 214 227 240 253 266 267 268 345 346 347 424 425 426
[30] 503 516 529 542

NOTE: only the X,Y,Z sets were used

```r
        xrow <- 1
        xcol <- 2
        fT_nrows <- nrow(fTable)
        xr <- grep('\\-mean\\(', fTable[1:fT_nrows,2], ignore.case=TRUE, value=FALSE)
        
        X <- 1
        Y <- 2
        Z <- 3
        #get offsets from FEATURES file for mean & sd for all X,Y,Z -- TEST
        onlyMean[,X] <- grep(('\\-mean\\(\\)\\-X'), fTable[1:fT_nrows,2], ignore.case=TRUE, value=FALSE)
```

```
## Error: replacement has length zero
```

```r
        onlySd[,X]   <- grep(('\\-std\\(.+?\\-X'), fTable[1:fT_nrows,2], ignore.case=TRUE, value=FALSE)
```

```
## Error: replacement has length zero
```

```r
        onlyMean[,Y] <- grep(('\\-mean\\(.+?\\-Y'), fTable[1:fT_nrows,2], ignore.case=TRUE, value=FALSE)
```

```
## Error: replacement has length zero
```

```r
        onlySd[,Y]   <- grep(('\\-std\\(.+?\\-Y'), fTable[1:fT_nrows,2], ignore.case=TRUE, value=FALSE)
```

```
## Error: replacement has length zero
```

```r
        onlyMean[,Z] <- grep(('\\-mean\\(.+?\\-Z'), fTable[1:fT_nrows,2], ignore.case=TRUE, value=FALSE)
```

```
## Error: replacement has length zero
```

```r
        onlySd[,Z]   <- grep(('\\-std\\(.+?\\-Z'), fTable[1:fT_nrows,2], ignore.case=TRUE, value=FALSE)
```

```
## Error: replacement has length zero
```

```r
        #-- TRIAL
        tonlyMean[6:7,] <- onlyMean[6:7,]
        tonlySd[6:7,] <- onlySd[6:7,]
        
        onlyMean[7,] <- onlyMean[7,]-(onlyMean[6,]-X:Z)
        onlyMean[6,] <- onlyMean[6,]-(onlyMean[6,]-X:Z)
        onlySd[7,]   <- onlySd[7,]-((onlySd[6,]-3)-X:Z)
        onlySd[6,]   <- onlySd[6,]-((onlySd[6,]-3)-X:Z)
```
Merge the training and test sets by appending columns in situ, re-order later


```r
        fileCon <- file("tidy.csv", "w")
        ntFiles <- length(testFiles)
        tftFiles <- 10
        
        dx <- 1
        
        for (j in 1:ntFiles)
        {
            if (j < tftFiles)
                {
                    message("reading TEST data")
                    pathToTestDataFile <- paste(pathToTestDataSet, testFiles[j], sep='/')
                    test <- read.csv(pathToTestDataFile, header=FALSE, sep=',', as.is=TRUE)
            } else
                {
                    message("reading TRIAL data")
                    pathToTrialDataFile <- paste(pathToTrialDataSet, testFiles[j], sep='/')
                    test <- read.csv(pathToTrialDataFile, header=FALSE, sep=',', as.is=TRUE)
                }
            
            #extract either the TEST or TRIAL columns, the two sets will butt against the other
            switch(j,
                   j1 = {iDx[1:4] <- 1  #reference for where to indicate MEAN or SD
                         pTidy <- cbind(subject_test, y_test, test[,onlyMean[1:4,X]])},
                   j2 = {if (nrow(test) < 2947) #pad the rows, these are uneven between test 
                            {     
                                test <- rbind(test, pMat)                                
                                pTidy <- cbind(pTidy, test[,onlyMean[1:4,Y]])
                            }
                         iDx[5:8] <- 1
                    },
                   j3 = {iDx[9:12] <- 1
                         pTidy <- cbind(pTidy, test[,onlyMean[1:4,Z]])},
                   j4 = {iDx[13:16] <- 2
                         pTidy <- cbind(pTidy, test[,onlySd[1:4,X]])},
                   j5 = {iDx[17:20] <- 2
                         pTidy <- cbind(pTidy, test[,onlySd[1:4,Y]])},
                   j6 = {iDx[21:24] <- 2
                         pTidy <- cbind(pTidy, test[,onlySd[1:4,Z]])},
                   j7 = {iDx[25:26] <- 1
                         pTidy <- cbind(pTidy, test[1:2947,onlyMean[6:7,X]])},
                   j8 = {iDx[27:28] <- 1
                         pTidy <- cbind(pTidy, test[1:2947,onlyMean[6:7,Y]])},
                   j9 = {iDx[29:30] <- 1
                         pTidy <- cbind(pTidy, test[1:2947,onlyMean[6:7,Z]])},
                   j10= {iDx[31:32] <- 2
                         pTidy <- cbind(pTidy, test[1:2947,onlySd[6:7,X]])},
                   j11= {iDx[33:34] <- 2
                         pTidy <- cbind(pTidy, test[1:2947,onlySd[6:7,Y]])},
                   j12= {iDx[35:36] <- 2
                         pTidy <- cbind(pTidy, test[1:2947,onlySd[6:7,Z]])},
                    {
                        "other"
                    }
                   )
            message("waiting ...")    
        }
```

```
## reading TEST data
```

```
## Warning: cannot open file '/body_acc_x_test_cpy.txt': No such file or
## directory
```

```
## Error: cannot open the connection
```
Extract only the mean and SD, do an average


```r
        #compute the averages for each test/trial 
        pAvg[1] <- ""
        pAvg[2] <- "pAvg"
        for (k in 1:(ncol(pTidy)-2))
        {
            if (iDx[k] == 1)
                {tavgMean[k] <- (sum(pTidy[, k+2], na.rm=TRUE))/(nrow(pTidy)); 
                 pAvg[k+2] <- tavgMean[k]; print(sprintf("%d: %f", k, tavgMean[k]))
                }
            if (iDx[k] == 2)
                {tavgSd[k] <- (sum(pTidy[, k+2], na.rm=TRUE))/(nrow(pTidy)); 
                 pAvg[k+2] <- tavgSd[k]; print(sprintf("%d: %f", k, tavgSd[k]))}
        }
```

```
## Error: argument of length 0
```

```r
        #now do within each subject
        pTrows <- nrow(pTidy)-1
        for (l in 1:pTrows)
        {
            for (n in 3:38)
                mAvg[l] <- sum(pTidy[l,n], na.rm=TRUE)/pTcol
        }
```

```
## Error: argument of length 0
```

```r
        #print(mAvg)
        pTidy <- cbind(pTidy, mAvg)
```
re-order the dataset on the subject number


```r
new_pTidy <- pTidy[order(pTidy[,1]),]
```
Label columns with feature table names


```r
        xtestMeanColNames <- c("subject", "test", fTable[onlyMean[1:4,X],2])
        ytestMeanColNames <- fTable[onlyMean[1:4,Y],2]
        ztestMeanColNames <- fTable[onlyMean[1:4,Z],2]
        xtestSdColNames   <- fTable[onlySd[1:4,X],2]
        ytestSdColNames   <- fTable[onlySd[1:4,Y],2]
        ztestSdColNames   <- fTable[onlySd[1:4,Z],2]
        
        xtrainMeanColNames <- fTable[tonlyMean[6:7,X],2]
        ytrainMeanColNames <- fTable[tonlyMean[6:7,Y],2]
        ztrainMeanColNames <- fTable[tonlyMean[6:7,Z],2]
        xtrainSdColNames   <- fTable[tonlySd[6:7,X],2]
        ytrainSdColNames   <- fTable[tonlySd[6:7,Y],2]
        ztrainSdColNames   <- fTable[tonlySd[6:7,Z],2]
        

        xyztestMeanColNames  <- c(xtestMeanColNames, ytestMeanColNames, ztestMeanColNames)   #6+4+4 \ 26
        xyztestSdColNames    <- c(xtestSdColNames, ytestSdColNames, ztestSdColNames)         #4+4+4 /
        xyztrainMeanColNames <- c(xtrainMeanColNames, ytrainMeanColNames, ztrainMeanColNames)#2+2+2 \ 12
        xyztrainSdColNames   <- c(xtrainSdColNames, ytrainSdColNames, ztrainSdColNames)      #2+2+2 /
                                                                                             #total   38
        dimnames(pTidy) = list(as.character(1:nrow(pTidy)), c(xyztestMeanColNames, xyztestSdColNames, 
                                                              xyztrainMeanColNames, xyztrainSdColNames))
```

```
## Error: length of 'dimnames' [2] not equal to array extent
```
feature.txt is no longer required
open a file connection and write the tidy data set (pTidy)


```r
        fileCon <- file("tidy.csv", "w")
        write.table(pTidy, row.names=FALSE, col.names=TRUE, sep=',', fileCon) #Tidy Dataset
        write.table(pAvg, row.names=FALSE, col.names=FALSE, sep=',', fileCon) #averages 
```
Make codebook.

```r
knit("makeCodebook.Rmd", output="codebook.md", encoding="ISO8859-1", quiet=TRUE)
```

```
## [1] "codebook.md"
```

```r
markdownToHTML("codebook.md", "codebook.html")
```

    Status
    API
    Training
    Shop
    Blog
    About

    © 2014 GitHub, Inc.
    Terms
    Privacy
    Security
    Contact





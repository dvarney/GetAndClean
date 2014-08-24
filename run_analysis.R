#
# POC: proof of concept, subset of mean/sd
#
# OWNER:
#   dvarney     08/23/2014

require(knitr)
require(markdown)
        
knit("run_analysis.Rmd", encoding="ISO8859-1")
markdownToHTML("run_analysis.md", "run_analysis.html")

run_analysis <- function()
    {
        #get required libraries
        library(data.table)
    
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
        fTable   <- matrix(nrow=561, ncol=2)
        
        tavgMean <- NULL
        tavgSd   <- NULL
        
        pathToTestDataSet   <- NULL
        pathToTestDataFile  <- NULL
        pathToTrialDataSet  <- NULL  
        pathToTrialDataFile <- NULL
        
        #these are the input files
        testFiles <- c("body_acc_x_test_cpy.txt",   "body_acc_y_test_cpy.txt",   "body_acc_z_test_cpy.txt",
                       "body_gyro_x_test_cpy.txt",  "body_gyro_y_test_cpy.txt",  "body_gyro_z_test_cpy.txt",
                       "total_acc_x_test_cpy.txt",  "total_acc_y_test_cpy.txt",  "total_acc_z_test_cpy.txt",
                       "body_acc_x_train_cpy.txt",  "body_acc_y_train_cpy.txt",  "body_acc_z_train_cpy.txt",
                       "body_gyro_x_train_cpy.txt", "body_gyro_y_train_cpy.txt", "body_gyro_z_train_cpy.txt",
                       "total_acc_x_train_cpy.txt", "total_acc_y_train_cpy.txt", "total_acc_z_train_cpy.txt")
        testMode <- c("subject_test", "y_test")
        
        #set some inital file paths, this computer
        destDir <- "K:/COURSES/JHU_DataScience/GettingAndCleaningData/UCI HAR Dataset"            
        pathToDataSet <- paste(destDir, 'features.txt', sep='/')

        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zipFile <- "getdata_projectfiles_UCI HAR Dataset.zip"             
        destDir1 <- "K:/COURSES/JHU_DataScience/GettingAndCleaningData"
        pathToUnZiped <- "K:/COURSES/JHU_DataScience/GettingAndCleaningData/UCI HAR Dataset"
        
        #check if the zip file is here
        if (!file.exists(paste(pathToUnZiped, zipFile, sep='/'))) 
        {
            message("getting Zipfile")
            download.file(fileUrl, pathToUnZiped)
        }
        
        #unpack zip, true lists the tree, false unpacks it
        unzip(zipFile, list=FALSE)
        
        #check if already grabbed the column/descriptor file
        if (!file.exists(pathToDataSet))  
        {
            message("Check FEATURES file")
        }
        else
        {
            #print(pathToDataSet)
            message("Read FEATUES.TXT datafile")
            fTable <- read.table(pathToDataSet, header=FALSE, sep=' ', as.is=TRUE) 
        }

        #set the test/train paths
        pathToTestDataSet   <- paste(destDir, 'test/Inertial Signals', sep='/')
        pathToTestDataFile  <- paste(pathToTestDataSet, testFiles[1], sep='/')
        pathToTrainDataSet  <- paste(destDir, 'train/Inertial Signals', sep='/')
        pathToTrainDataFile <- paste(pathToTestDataSet, testFiles[10], sep='/')

        #Read the test/train subject's number 
        subjectTestFile <- paste(destDir, 'test/subject_test.txt', sep='/')
        subject_test <- read.csv(subjectTestFile, header=FALSE, sep='', as.is=TRUE)
        subjectTrainFile <- paste(destDir, 'train/subject_train.txt', sep='/')
        subject_train <- read.csv(subjectTrainFile, header=FALSE, sep='', as.is=TRUE)
        
        #Get the type of test for the subject, 1:1 match
        yTestFile <- paste(destDir, 'test/y_test.txt', sep='/')
        y_test <- read.csv(yTestFile, header=FALSE, sep='', as.is=TRUE)
        yTrainFile <- paste(destDir, 'train/y_train.txt', sep='/')
        y_train <- read.csv(yTrainFile, header=FALSE, sep='', as.is=TRUE)
        
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
        
        fT_nrows <- nrow(fTable)
        xr <- grep('\\-mean\\(', fTable[,2], ignore.case=TRUE, value=FALSE)
        
        X <- 1
        Y <- 2
        Z <- 3
        #get offsets from FEATURES file for mean & sd for all X,Y,Z
        onlyMean[,X] <- grep(('\\-mean\\(\\)\\-X'), fTable[,2], ignore.case=TRUE, value=FALSE)        
        onlySd[,X]   <- grep(('\\-std\\(.+?\\-X'),  fTable[,2], ignore.case=TRUE, value=FALSE)
        onlyMean[,Y] <- grep(('\\-mean\\(.+?\\-Y'), fTable[,2], ignore.case=TRUE, value=FALSE)
        onlySd[,Y]   <- grep(('\\-std\\(.+?\\-Y'),  fTable[,2], ignore.case=TRUE, value=FALSE)
        onlyMean[,Z] <- grep(('\\-mean\\(.+?\\-Z'), fTable[,2], ignore.case=TRUE, value=FALSE)
        onlySd[,Z]   <- grep(('\\-std\\(.+?\\-Z'),  fTable[,2], ignore.case=TRUE, value=FALSE)
        
        tonlyMean[6:7,] <- onlyMean[6:7,]
        tonlySd[6:7,] <- onlySd[6:7,]
        
        onlyMean[7,] <- onlyMean[7,]-(onlyMean[6,]-X:Z)
        onlyMean[6,] <- onlyMean[6,]-(onlyMean[6,]-X:Z)
        onlySd[7,]   <- onlySd[7,]-((onlySd[6,]-3)-X:Z)
        onlySd[6,]   <- onlySd[6,]-((onlySd[6,]-3)-X:Z)
        
        ntFiles <- length(testFiles)
        tftFiles <- 10
        
        #get test/trial file, and merge with the pre-Tidy table
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
                    pathToTrainDataFile <- paste(pathToTrainDataSet, testFiles[j], sep='/')
                    test <- read.csv(pathToTrainDataFile, header=FALSE, sep=',', as.is=TRUE)
                }
            
            #do the merge, the trial data needs truncating. Another possibility is to pad
            #the test columns with 7352-2947 rows, which is a bit problematic.
            
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
            message("waiting ...",j," ", ntFiles)    
        }
        
        #compute the averages for each test/trial, first do an aggregate across all subjects
        pAvg[1] <- ""
        pAvg[2] <- "pAvg"
        pTcol <- ncol(pTidy)-2
        for (k in 1:pTcol)
        {
            if (iDx[k] == 1)
                {tavgMean[k] <- (sum(pTidy[, k+2], na.rm=TRUE))/(nrow(pTidy)); 
                 pAvg[k+2] <- tavgMean[k]; #print(sprintf("%d: %f", k, tavgMean[k]))
                }
            if (iDx[k] == 2)
                {tavgSd[k] <- (sum(pTidy[, k+2], na.rm=TRUE))/(nrow(pTidy)); 
                 pAvg[k+2] <- tavgSd[k]; #print(sprintf("%d: %f", k, tavgSd[k]))
                }
        }
        
        #now do within each subject
        pTrows <- nrow(pTidy)-1
        for (l in 1:pTrows)
        {
            for (n in 3:38)
                mAvg[l] <- sum(pTidy[l,n], na.rm=TRUE)/pTcol
        }

        pTidy <- cbind(pTidy, mAvg)
        
        #order the dataset according to the subject number
        pTidy <- pTidy[order(pTidy[,1]),]
        
        #build a names list for the XTEST array, also has subject # and the test performed
        #each section takes a reference out of the features table, fTable

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
       
        dimnames(pTidy) <- list(as.character(1:nrow(pTidy)), c(xyztestMeanColNames, xyztestSdColNames, 
                                                  xyztrainMeanColNames, xyztrainSdColNames, "mAvg"))
        
        #Make codebook
        fileCon <- file("tidy.csv", "w")
        write.table(pTidy, row.names=FALSE, col.names=TRUE, sep=',', fileCon) #Tidy Dataset
        write.table(pAvg, row.names=FALSE, col.names=FALSE, sep=',', fileCon) #averages 
        
        knit("makeCodebook.Rmd", output="codebook.md", encoding="ISO8859-1", quiet=TRUE)
        markdownToHTML("codebook.md", "codebook.html")
               
        gc(verbose=T)       #take out some garbage, see the memory use
        close(fileCon)      #close the file connection        
    }


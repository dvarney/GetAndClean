Codebook
========
Codebook was generated on 2014-08-24 17:22:25 during the same process that
generated the dataset. See `run_analysis.md` or `run_analysis.html` for details on
dataset creation.

Variable list and descriptions
--------------------------------------------------------------------
Variable name             | Description
--------------------------|-----------------------------------------
subject                   | who is the test/trial subject
test                      | which of six test modes
t/fBodyAcc-mean()-X,Y,Z   | Feature: Acceleration signal, Body
tGravityAcc-mean()-X,Y,Z  | Feature: Acceleration signal, Gravity
tBodyAccJerk-mean()-X,Y,Z | Feature: Jerk signal
tBodyGyro-mean()-X,Y,Z    | Feature: Measuring instrument, Gyroscope
t/fBodyAcc-sd()-X,Y,Z     | Feature: as above, SD
tGravityAcc-sd()-X,Y,Z    | Feature: as above, 
tBodyAccJerk-sd()-X,Y,Z   | Feature: as above
tBodyGyro-sd()-X,Y,Z      | Feature: as above
pAvg                      | average for all subjects with a feature
mAvg                      | average within one test, one subject

Dataset structure
-----------------

```r
str(pTidy)
```

```
## 'data.frame':	2947 obs. of  39 variables:
##  $ subject              : int  2 2 2 2 2 2 2 2 2 2 ...
##  $ test                 : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
##  $ tBodyAcc-mean()-X    : num  0.011653 0.00928 0.005732 0.000452 -0.004362 ...
##  $ tGravityAcc-mean()-X : num  0.01493 0.001597 -0.001438 -0.000216 -0.001721 ...
##  $ tBodyAccJerk-mean()-X: num  -0.00193 0.00213 -0.00652 -0.00652 -0.0014 ...
##  $ tBodyGyro-mean()-X   : num  0.00285 -0.00109 -0.00386 0.00225 0.00365 ...
##  $ tBodyAcc-mean()-Y    : num  0.01865 0.00733 -0.02205 -0.00867 0.00168 ...
##  $ tGravityAcc-mean()-Y : num  0.00398 -0.00491 -0.00353 -0.00536 0.0035 ...
##  $ tBodyAccJerk-mean()-Y: num  0.00475 -0.02259 -0.02301 -0.02072 0.00497 ...
##  $ tBodyGyro-mean()-Y   : num  -0.0138 -0.00623 -0.00253 0.00248 0.00307 ...
##  $ tBodyAcc-mean()-Z    : num  0.21685 -0.03664 0.00365 -0.00265 0.00407 ...
##  $ tGravityAcc-mean()-Z : num  0.00713 0.00617 -0.0051 -0.00521 -0.00172 ...
##  $ tBodyAccJerk-mean()-Z: num  0.0043 -0.00623 -0.00456 -0.0175 -0.01557 ...
##  $ tBodyGyro-mean()-Z   : num  0.005892 0.000645 -0.000619 -0.010398 -0.002874 ...
##  $ tBodyAcc-std()-X     : num  0.4794 0.0789 -0.0595 -0.0273 -0.0402 ...
##  $ tGravityAcc-std()-X  : num  0.1115 0.1467 -0.0136 -0.0256 -0.0484 ...
##  $ tBodyAccJerk-std()-X : num  0.0841 -0.0237 0.0204 -0.0513 -0.0154 ...
##  $ tBodyGyro-std()-X    : num  0.0158 -0.0102 -0.0305 -0.0209 0.0166 ...
##  $ tBodyAcc-std()-Y     : num  0.4145 -0.0929 -0.0456 -0.0392 -0.0371 ...
##  $ tGravityAcc-std()-Y  : num  0.01929 -0.10904 -0.06604 -0.02979 -0.00415 ...
##  $ tBodyAccJerk-std()-Y : num  -0.00857 -0.05327 -0.04351 -0.0057 -0.00807 ...
##  $ tBodyGyro-std()-Y    : num  -0.08566 -0.03273 -0.03673 0.00234 0.02988 ...
##  $ tBodyAcc-std()-Z     : num  -0.0271 0.054 0.0257 0.0663 0.0201 ...
##  $ tGravityAcc-std()-Z  : num  0.03634 0.06124 0.04577 0.01461 -0.00386 ...
##  $ tBodyAccJerk-std()-Z : num  0.02984 0.03182 0.02567 -0.00342 -0.00644 ...
##  $ tBodyGyro-std()-Z    : num  0.0323 0.0583 0.0203 -0.0113 -0.0252 ...
##  $ fBodyAcc-mean()-X    : num  1.041 0.999 0.998 0.995 0.988 ...
##  $ fBodyAccJerk-mean()-X: num  1.009 0.995 0.987 0.988 0.988 ...
##  $ fBodyAcc-mean()-Y    : num  -0.28 -0.253 -0.264 -0.289 -0.283 ...
##  $ fBodyAccJerk-mean()-Y: num  -0.277 -0.263 -0.295 -0.301 -0.304 ...
##  $ fBodyAcc-mean()-Z    : num  0.147 0.116 0.144 0.135 0.139 ...
##  $ fBodyAccJerk-mean()-Z: num  0.16 0.135 0.133 0.117 0.111 ...
##  $ fBodyAcc-std()-X     : num  0.005066 0.002247 -0.003738 0.000408 0.003126 ...
##  $ fBodyAccJerk-std()-X : num  -0.00124 0.00118 0.00161 -0.00135 0.00172 ...
##  $ fBodyAcc-std()-Y     : num  0.006141 -0.004191 0.000937 -0.007826 -0.007336 ...
##  $ fBodyAccJerk-std()-Y : num  -0.00043 0.00449 -0.01116 -0.00746 0.00556 ...
##  $ fBodyAcc-std()-Z     : num  0.04473 -0.02632 -0.00774 -0.00561 -0.00433 ...
##  $ fBodyAccJerk-std()-Z : num  -0.014582 0.000344 -0.012684 -0.008756 0.00157 ...
##  $ mAvg                 : num  -4.05e-04 9.55e-06 -3.52e-04 -2.43e-04 4.36e-05 ...
```
List the key variables in the data table
----------------------------------------

```r
fTable[xr,2]
```

```
##  [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
##  [3] "tBodyAcc-mean()-Z"           "tGravityAcc-mean()-X"       
##  [5] "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"       
##  [7] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
##  [9] "tBodyAccJerk-mean()-Z"       "tBodyGyro-mean()-X"         
## [11] "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"         
## [13] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
## [15] "tBodyGyroJerk-mean()-Z"      "tBodyAccMag-mean()"         
## [17] "tGravityAccMag-mean()"       "tBodyAccJerkMag-mean()"     
## [19] "tBodyGyroMag-mean()"         "tBodyGyroJerkMag-mean()"    
## [21] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
## [23] "fBodyAcc-mean()-Z"           "fBodyAccJerk-mean()-X"      
## [25] "fBodyAccJerk-mean()-Y"       "fBodyAccJerk-mean()-Z"      
## [27] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
## [29] "fBodyGyro-mean()-Z"          "fBodyAccMag-mean()"         
## [31] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyGyroMag-mean()"    
## [33] "fBodyBodyGyroJerkMag-mean()"
```
Show a few rows of the dataset
------------------------------

```r
head(pTidy)
```

```
##   subject     test tBodyAcc-mean()-X tGravityAcc-mean()-X
## 1       2 STANDING         0.0116531            0.0149295
## 2       2 STANDING         0.0092796            0.0015970
## 3       2 STANDING         0.0057319           -0.0014385
## 4       2 STANDING         0.0004519           -0.0002163
## 5       2 STANDING        -0.0043624           -0.0017210
## 6       2 STANDING        -0.0010957            0.0033478
##   tBodyAccJerk-mean()-X tBodyGyro-mean()-X tBodyAcc-mean()-Y
## 1             -0.001934           0.002848          0.018650
## 2              0.002135          -0.001095          0.007331
## 3             -0.006515          -0.003860         -0.022051
## 4             -0.006519           0.002248         -0.008671
## 5             -0.001402           0.003647          0.001677
## 6              0.001046           0.005215          0.003388
##   tGravityAcc-mean()-Y tBodyAccJerk-mean()-Y tBodyGyro-mean()-Y
## 1             0.003985              0.004747          -0.013802
## 2            -0.004908             -0.022590          -0.006233
## 3            -0.003531             -0.023007          -0.002527
## 4            -0.005361             -0.020717           0.002476
## 5             0.003497              0.004971           0.003067
## 6             0.006574              0.004652          -0.009175
##   tBodyAcc-mean()-Z tGravityAcc-mean()-Z tBodyAccJerk-mean()-Z
## 1          0.216846             0.007130              0.004296
## 2         -0.036639             0.006166             -0.006232
## 3          0.003647            -0.005096             -0.004563
## 4         -0.002649            -0.005209             -0.017503
## 5          0.004069            -0.001724             -0.015572
## 6         -0.004741            -0.006535              0.002276
##   tBodyGyro-mean()-Z tBodyAcc-std()-X tGravityAcc-std()-X
## 1          0.0058918          0.47940             0.11151
## 2          0.0006449          0.07886             0.14670
## 3         -0.0006193         -0.05946            -0.01358
## 4         -0.0103976         -0.02729            -0.02564
## 5         -0.0028740         -0.04017            -0.04842
## 6          0.0055080         -0.03376            -0.01632
##   tBodyAccJerk-std()-X tBodyGyro-std()-X tBodyAcc-std()-Y
## 1             0.084093          0.015765          0.41454
## 2            -0.023686         -0.010249         -0.09285
## 3             0.020420         -0.030483         -0.04565
## 4            -0.051316         -0.020943         -0.03924
## 5            -0.015435          0.016630         -0.03708
## 6            -0.005681          0.004187         -0.05772
##   tGravityAcc-std()-Y tBodyAccJerk-std()-Y tBodyGyro-std()-Y
## 1            0.019292            -0.008571         -0.085656
## 2           -0.109042            -0.053267         -0.032731
## 3           -0.066040            -0.043511         -0.036732
## 4           -0.029795            -0.005704          0.002337
## 5           -0.004151            -0.008074          0.029878
## 6            0.019998             0.020687          0.022767
##   tBodyAcc-std()-Z tGravityAcc-std()-Z tBodyAccJerk-std()-Z
## 1         -0.02714            0.036341             0.029842
## 2          0.05401            0.061244             0.031825
## 3          0.02567            0.045768             0.025669
## 4          0.06630            0.014606            -0.003421
## 5          0.02013           -0.003858            -0.006443
## 6          0.03903           -0.021157            -0.017655
##   tBodyGyro-std()-Z fBodyAcc-mean()-X fBodyAccJerk-mean()-X
## 1           0.03226            1.0412                1.0091
## 2           0.05831            0.9992                0.9947
## 3           0.02033            0.9976                0.9871
## 4          -0.01133            0.9946                0.9879
## 5          -0.02518            0.9882                0.9882
## 6          -0.02447            0.9897                0.9924
##   fBodyAcc-mean()-Y fBodyAccJerk-mean()-Y fBodyAcc-mean()-Z
## 1           -0.2800               -0.2766            0.1475
## 2           -0.2532               -0.2632            0.1164
## 3           -0.2638               -0.2948            0.1442
## 4           -0.2889               -0.3013            0.1353
## 5           -0.2832               -0.3041            0.1394
## 6           -0.2844               -0.2908            0.1264
##   fBodyAccJerk-mean()-Z fBodyAcc-std()-X fBodyAccJerk-std()-X
## 1                0.1601        0.0050659            -0.001236
## 2                0.1352        0.0022474             0.001180
## 3                0.1331       -0.0037377             0.001614
## 4                0.1170        0.0004081            -0.001347
## 5                0.1109        0.0031260             0.001717
## 6                0.1235        0.0012683            -0.001797
##   fBodyAcc-std()-Y fBodyAccJerk-std()-Y fBodyAcc-std()-Z
## 1        0.0061410           -0.0004303         0.044729
## 2       -0.0041909            0.0044886        -0.026321
## 3        0.0009365           -0.0111575        -0.007745
## 4       -0.0078256           -0.0074630        -0.005615
## 5       -0.0073363            0.0055647        -0.004328
## 6       -0.0018116            0.0038933         0.001851
##   fBodyAccJerk-std()-Z       mAvg
## 1           -0.0145822 -4.051e-04
## 2            0.0003437  9.547e-06
## 3           -0.0126842 -3.523e-04
## 4           -0.0087560 -2.432e-04
## 5            0.0015704  4.362e-05
## 6            0.0036034  1.001e-04
```
Summary of variables
--------------------

```r
summary(pTidy)
```

```
##     subject       test           tBodyAcc-mean()-X tGravityAcc-mean()-X
##  Min.   : 2   Length:2947        Min.   :-0.7561   Min.   :-0.7162     
##  1st Qu.: 9   Class :character   1st Qu.:-0.0552   1st Qu.:-0.0517     
##  Median :12   Mode  :character   Median :-0.0013   Median :-0.0012     
##  Mean   :13                      Mean   :-0.0060   Mean   :-0.0039     
##  3rd Qu.:18                      3rd Qu.: 0.0070   3rd Qu.: 0.0072     
##  Max.   :24                      Max.   : 1.0710   Max.   : 1.0374     
##                                                                        
##  tBodyAccJerk-mean()-X tBodyGyro-mean()-X tBodyAcc-mean()-Y
##  Min.   :-0.7979       Min.   :-0.6942    Min.   :-0.9664  
##  1st Qu.:-0.0342       1st Qu.:-0.0236    1st Qu.:-0.0129  
##  Median :-0.0008       Median :-0.0007    Median : 0.0014  
##  Mean   :-0.0015       Mean   : 0.0113    Mean   : 0.0032  
##  3rd Qu.: 0.0078       3rd Qu.: 0.0092    3rd Qu.: 0.0343  
##  Max.   : 0.9805       Max.   : 1.1292    Max.   : 0.5674  
##                                           NA's   :1        
##  tGravityAcc-mean()-Y tBodyAccJerk-mean()-Y tBodyGyro-mean()-Y
##  Min.   :-0.8770      Min.   :-0.8065       Min.   :-0.6825   
##  1st Qu.:-0.0103      1st Qu.:-0.0119       1st Qu.:-0.0125   
##  Median : 0.0016      Median : 0.0011       Median : 0.0008   
##  Mean   : 0.0032      Mean   :-0.0010       Mean   :-0.0037   
##  3rd Qu.: 0.0338      3rd Qu.: 0.0238       3rd Qu.: 0.0198   
##  Max.   : 0.5410      Max.   : 0.5584       Max.   : 0.4720   
##  NA's   :1            NA's   :1             NA's   :1         
##  tBodyAcc-mean()-Z tGravityAcc-mean()-Z tBodyAccJerk-mean()-Z
##  Min.   :-0.5708   Min.   :-0.9462      Min.   :-0.6523      
##  1st Qu.:-0.0208   1st Qu.:-0.0153      1st Qu.:-0.0152      
##  Median :-0.0002   Median : 0.0006      Median : 0.0005      
##  Mean   : 0.0000   Mean   : 0.0020      Mean   : 0.0012      
##  3rd Qu.: 0.0188   3rd Qu.: 0.0187      3rd Qu.: 0.0160      
##  Max.   : 0.6342   Max.   : 0.4574      Max.   : 0.4809      
##                                                              
##  tBodyGyro-mean()-Z tBodyAcc-std()-X  tGravityAcc-std()-X
##  Min.   :-0.6902    Min.   :-2.3229   Min.   :-2.2428    
##  1st Qu.:-0.0168    1st Qu.:-0.1021   1st Qu.:-0.0913    
##  Median : 0.0001    Median :-0.0016   Median :-0.0010    
##  Mean   :-0.0044    Mean   :-0.0254   Mean   :-0.0226    
##  3rd Qu.: 0.0152    3rd Qu.: 0.0592   3rd Qu.: 0.0479    
##  Max.   : 0.4180    Max.   : 1.8908   Max.   : 2.3667    
##                                                          
##  tBodyAccJerk-std()-X tBodyGyro-std()-X tBodyAcc-std()-Y 
##  Min.   :-1.8817      Min.   :-2.8990   Min.   :-2.3669  
##  1st Qu.:-0.0695      1st Qu.:-0.0569   1st Qu.:-0.0624  
##  Median :-0.0003      Median :-0.0004   Median :-0.0005  
##  Mean   :-0.0050      Mean   : 0.0012   Mean   : 0.0154  
##  3rd Qu.: 0.0563      3rd Qu.: 0.0539   3rd Qu.: 0.0619  
##  Max.   : 2.0553      Max.   : 2.6649   Max.   : 2.1672  
##                                                          
##  tGravityAcc-std()-Y tBodyAccJerk-std()-Y tBodyGyro-std()-Y
##  Min.   :-2.3568     Min.   :-2.0350      Min.   :-2.2101  
##  1st Qu.:-0.0743     1st Qu.:-0.0504      1st Qu.:-0.0611  
##  Median :-0.0021     Median :-0.0004      Median :-0.0012  
##  Mean   :-0.0148     Mean   : 0.0101      Mean   :-0.0076  
##  3rd Qu.: 0.0303     3rd Qu.: 0.0454      3rd Qu.: 0.0317  
##  Max.   : 2.3760     Max.   : 2.8308      Max.   : 2.5719  
##                                                            
##  tBodyAcc-std()-Z  tGravityAcc-std()-Z tBodyAccJerk-std()-Z
##  Min.   :-2.4179   Min.   :-1.7481     Min.   :-1.6947     
##  1st Qu.:-0.0363   1st Qu.:-0.0335     1st Qu.:-0.0269     
##  Median : 0.0007   Median : 0.0003     Median : 0.0006     
##  Mean   : 0.0030   Mean   : 0.0055     Mean   : 0.0024     
##  3rd Qu.: 0.0688   3rd Qu.: 0.0612     3rd Qu.: 0.0551     
##  Max.   : 1.2937   Max.   : 1.4400     Max.   : 1.3460     
##                                                            
##  tBodyGyro-std()-Z fBodyAcc-mean()-X fBodyAccJerk-mean()-X
##  Min.   :-1.4131   Min.   :-0.245    Min.   :-0.244       
##  1st Qu.:-0.0245   1st Qu.: 0.719    1st Qu.: 0.715       
##  Median : 0.0011   Median : 0.956    Median : 0.962       
##  Mean   : 0.0077   Mean   : 0.814    Mean   : 0.814       
##  3rd Qu.: 0.0475   3rd Qu.: 1.020    3rd Qu.: 1.020       
##  Max.   : 1.5581   Max.   : 1.964    Max.   : 2.025       
##                                                           
##  fBodyAcc-mean()-Y fBodyAccJerk-mean()-Y fBodyAcc-mean()-Z
##  Min.   :-1.2459   Min.   :-1.1163       Min.   :-1.0925  
##  1st Qu.:-0.2241   1st Qu.:-0.2305       1st Qu.:-0.0948  
##  Median :-0.0827   Median :-0.0868       Median : 0.0420  
##  Mean   : 0.0070   Mean   : 0.0039       Mean   : 0.0797  
##  3rd Qu.: 0.1458   3rd Qu.: 0.1350       3rd Qu.: 0.2022  
##  Max.   : 1.0831   Max.   : 1.0063       Max.   : 0.9832  
##                                                           
##  fBodyAccJerk-mean()-Z fBodyAcc-std()-X  fBodyAccJerk-std()-X
##  Min.   :-0.9856       Min.   :-0.9843   Min.   :-0.7301     
##  1st Qu.:-0.0935       1st Qu.:-0.0549   1st Qu.:-0.0601     
##  Median : 0.0474       Median :-0.0011   Median :-0.0010     
##  Mean   : 0.0823       Mean   :-0.0024   Mean   :-0.0072     
##  3rd Qu.: 0.2072       3rd Qu.: 0.0098   3rd Qu.: 0.0070     
##  Max.   : 0.9953       Max.   : 1.0229   Max.   : 0.9702     
##                                                              
##  fBodyAcc-std()-Y  fBodyAccJerk-std()-Y fBodyAcc-std()-Z 
##  Min.   :-1.0013   Min.   :-0.7929      Min.   :-0.7092  
##  1st Qu.:-0.0134   1st Qu.:-0.0132      1st Qu.:-0.0222  
##  Median : 0.0015   Median : 0.0008      Median : 0.0005  
##  Mean   : 0.0042   Mean   :-0.0018      Mean   : 0.0039  
##  3rd Qu.: 0.0489   3rd Qu.: 0.0282      3rd Qu.: 0.0280  
##  Max.   : 0.8485   Max.   : 0.5468      Max.   : 0.9551  
##                                                          
##  fBodyAccJerk-std()-Z      mAvg        
##  Min.   :-0.9651      Min.   :-0.0268  
##  1st Qu.:-0.0217      1st Qu.:-0.0006  
##  Median : 0.0000      Median : 0.0000  
##  Mean   : 0.0019      Mean   : 0.0001  
##  3rd Qu.: 0.0166      3rd Qu.: 0.0005  
##  Max.   : 0.6540      Max.   : 0.0182  
##                       NA's   :1
```
Save to file tidy.csv
------------

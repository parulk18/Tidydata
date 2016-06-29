# Tidydata
#Getting & Cleaning Data Peer Assessment 

##Description

###Downloading Data

The first thing I do in my solution is check to see if the zip file is downloaded and if not then I download it. 

###File Preparation

The second step for me was to load all the pertinent files. As the project states I have assumed that all files are in the structure they were in the zip file with the main directory being the working directory of my code. For this project I excluded the inertial signal files. I put the column names on each of the test and training set files. I then used cbind() to append the subject and activity identifiers.

Finally, I merged the two files together using rbind().

###Extract Mean & Standard Deviation Measurements

I decided to keep those variables that had the word mean or std in them and were the main function. So I kept mean() or meanfreq(), but not something like anglezgravitymean would not show up because to me that wasn't the point of mean and std calculations.

##Tidy Data Output

Output the file as a run_analysis.R with headers.


Getting-and-Cleaning-Data
=========================

The script run_analysis.R which will merge the test and training sets together. 

Prerequisites for this script:
1). the UCI HAR Dataset must be extracted

2). the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset" in the working directory.

After merging testing and training, labels are added and only columns that have mean and standard deviation are kept.

Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset will be written to a tab-delimited file called tidy.txt, which is present in this repository.

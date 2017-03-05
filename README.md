Readme
======

This script is designed to take data from the Human Activity Recognition Using Smartphones Dataset[1] and merge the data into a single tidy dataframe, and then calculate the mean of the each of the variables. A more thorough explanation of what the code does is as follows:

The names of the variables are first taken from the "features.txt" file and stored in the dataframe "dfnames". "df1" and "df2" are dataframes that were created using the data from the "X_test" and "X_train" files, from which the entirety of the data was obtained. run_analysis.R takes the names in "dfnames" and applies them to the column names in both df1 and df2.

The script then takes the subject data from the "subject_test" and "subject_train" files and attaches them as a new column to the dataframes df1 and df2, and then names that column "sub". Similarly, the script takes the activity labels from the "y_test" and "y_train" files and attaches them as a new column to df1 and df2, and then names the new column "act". The script then row binds the dataframes df1 and df2 into a new dataframe "dfmerge".

In order to make the activity labels more descriptive, the script then runs a loop to replace the numeric activity labels with the names of the activity, which are stored as correpsonding entries in the vector "actv". Duplicated column names are then removed from the dfmerge dataframe.

The data is then aggregated according to "Subject" and "Activity" and the mean of each of the variables is calculated, resulting in a 6*30 = 180 row dataframe where each entry is the mean of the data for each variable that comes from the corresponding activity the subject performed. Because the aggregate function adds two columns to the dataframe, the original "act" and "sub" columns are then removed in favor of the new "Subject" and "Activity" columns.

Finally, only the mean and standard deviation variables are desired in the final tidy dataset, so a new dataframe "tidydf" is created which selects only the columns which have "mean()" and "std()" in them (columns which contain "meanFreq()" are filtered out because they are an unwanted derived statistic which grep doesn't catch initially).


[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

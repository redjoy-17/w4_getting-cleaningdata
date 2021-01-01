## README FILE

This file is to explain how works the code in w4_course3.R .
First of all it is necessary to read the tables contained in the main folder and in the subfolder contained in it. 

In 1. it is created the general table by using the commands cbind() and rbind() and the column names are adjusted.

In 2. the variables referred to the mean() and the std() are extracted and put in another dataframe named new_data.

In 3. the new_data dataframe is modified in the column "activity names" and the numeric values are substitued by the character values which describe the activity done.

In 4. the new_data dataframe is labeled.

In 5. the new_data dataframe is aggregated according to the subject and the activity done, and at the same time the mean of the observation is calculated. Consequently the new dataframe called new_data2 contains only 180 rows.

Finally the dataframe is exported in a txt file called "tidydata.txt".

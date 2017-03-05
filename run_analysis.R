library(dplyr)

dfnames = read.table("./HAR dataset/features.txt")
df1 = read.table("./HAR dataset/test/X_test.txt")
df2 = read.table("./HAR dataset/train/X_train.txt")
names(df1) <- dfnames[, 2]
names(df2) <- dfnames[, 2]

df1subject = read.table("./HAR dataset/test/subject_test.txt")
df2subject = read.table("./HAR dataset/train/subject_train.txt")
df1 = cbind(df1subject, df1)
df2 = cbind(df2subject, df2)
colnames(df1)[1] <- "sub"
colnames(df2)[1] <- "sub"

df1activity = read.table("./HAR dataset/test/y_test.txt")
df2activity = read.table("./HAR dataset/train/y_train.txt")
df1 = cbind(df1activity, df1)
df2 = cbind(df2activity, df2)
colnames(df1)[1] <- "act"
colnames(df2)[1] <- "act"

dfmerge = rbind(df1, df2)

actv = c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
for (i in 1:6){
        dfmerge$act[dfmerge$act == i] <- actv[i]
        i <- i + 1
}

dfmerge <- dfmerge[,!duplicated(colnames(dfmerge))]

aggdf = aggregate(dfmerge, by = list(Subject = dfmerge$sub, Activity = dfmerge$act), FUN = mean, na.rm = TRUE)
aggdf <- select(aggdf, -(act:sub))
tidydf = select(aggdf, (Activity:Subject), grep("mean()", names(aggdf)), grep("std()", names(aggdf)), -(grep("meanFreq()", names(aggdf))))

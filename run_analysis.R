#!/usr/bin/env R CMD BATCH
run_analysis <- function () {
    activities <- read.table("UCI HAR Dataset/activity_labels.txt",
                             col.names = c("activity_id", "activity_label"))
    features <- read.table("UCI HAR Dataset/features.txt",
                           col.names = c("feature_id", "feature_label"))
    features.needed <- features[grep("(mean|std)\\(\\)", features$feature_label),]

    f <- data.frame();
    sapply(c("test", "train"), function(set) {
        x <- read.table(paste0("UCI HAR Dataset/", set, "/X_", set, ".txt"),
                        col.names = features$feature_label)
        x <- x[,features.needed$feature_id]

        y <- read.table(paste0("UCI HAR Dataset/", set, "/y_", set, ".txt"),
                        col.names = c("activity_id"))
        y <- data.frame(activities$activity_label[unlist(y)])
        names(y) = c("activity_label")

        subj <- read.table(paste0("UCI HAR Dataset/", set, "/subject_", set, ".txt"),
                           col.names = c("subj_id"))

        x <- cbind(y, x)
        x <- cbind(subj, x)

        f <<- rbind(f,x)
    });

    return (f)
}
#run_analysis();

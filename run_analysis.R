#!/usr/bin/env R CMD BATCH
get_dataset <- function (datadir="UCI HAR Dataset") {
    activities <- read.table(paste0(datadir, "/activity_labels.txt"),
                             col.names = c("activity_id", "activity_label"))
    features <- read.table(paste0(datadir, "/features.txt"),
                           col.names = c("feature_id", "feature_label"))
    features.needed <- features[grep("(mean|std)\\(\\)", features$feature_label),]

    res <- data.frame();
    sapply(c("test", "train"), function(set) {
        x <- read.table(paste0(datadir, "/", set, "/X_", set, ".txt"),
                        col.names = features$feature_label)
        x <- x[,features.needed$feature_id]

        y <- read.table(paste0(datadir, "/", set, "/y_", set, ".txt"),
                        col.names = c("activity_id"))
        y <- data.frame(activities$activity_label[unlist(y)])
        names(y) = c("activity_label")

        subj <- read.table(paste0(datadir, "/", set, "/subject_", set, ".txt"),
                           col.names = c("subj_id"))

        x <- cbind(subj, y, x)

        res <<- rbind(res,x)
    })

    return(res)
}

get_tidy <- function (dataset=data.frame()) {
    by.subj <- split(dataset, dataset$subj_id)
    res <- data.frame()
    sapply(by.subj, function(x) {
        by.activity <- split(x, x$activity_label)
        sapply(by.activity, function(y) {
            subj <- unique(y$subj_id)
            activity <- unique(y$activity_label)

            col <- data.frame(subj, activity)

            for(i in 3:length(names(y))) { col <- cbind(col, mean(y[,i])) }

            res <<- rbind(res, col)
        })
    })
    names(res) = names(dataset)

    return(res)
}

run_analysis <- function (datadir="UCI HAR Dataset", file="tidy.txt") {
    dataset <- get_dataset(datadir)
    tidy <- get_tidy(dataset)
    return(tidy)
}

run_analysis();

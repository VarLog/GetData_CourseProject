#!/usr/bin/env R CMD BATCH
get_dataset <- function (datadir="UCI HAR Dataset") {
    activities <- read.table(paste0(datadir, "/activity_labels.txt"),
                             col.names = c("activity.id", "activity.label"))
    features <- read.table(paste0(datadir, "/features.txt"),
                           col.names = c("feature.id", "feature.label"))
    features$feature.label <- sub("\\(\\)", "", features$feature.label)
    features.needed <- features[grep("-(mean|std)-", features$feature.label),]

    res <- data.frame();
    sapply(c("test", "train"), function(set) {
        x <- read.table(paste0(datadir, "/", set, "/X_", set, ".txt"),
                        col.names = features$feature.label)
        x <- x[,features.needed$feature.id]

        y <- read.table(paste0(datadir, "/", set, "/y_", set, ".txt"),
                        col.names = c("activity.id"))
        y <- data.frame(activities$activity.label[unlist(y)])
        names(y) = c("activity.label")

        subj <- read.table(paste0(datadir, "/", set, "/subject_", set, ".txt"),
                           col.names = c("subj.id"))

        x <- cbind(subj, y, x)

        res <<- rbind(res,x)
    })

    return(res)
}

get_tidy <- function (dataset=data.frame()) {
    by.subj <- split(dataset, dataset$subj.id)
    res <- data.frame()
    sapply(by.subj, function(x) {
        by.activity <- split(x, x$activity.label)
        sapply(by.activity, function(y) {
            subj <- unique(y$subj.id)
            activity <- unique(y$activity.label)

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


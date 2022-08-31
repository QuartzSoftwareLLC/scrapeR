#' t
#'
#' This is one of scrapeR's built in transformer steps.
#' @name t
#' @return [transformer()]
NULL

#' clean names
#'
#' Runs the janiotr clean_names function on the queue.
#' @export
#' @inherit t
t_clean_names <- function() {
    transformer(
        ~ janitor::clean_names(.x),
        name = "clean_names"
    )
}

#' save output
#'
#' Saves the current queue as a csv file in the directory of your choice.
#' The name of the csv file will match the name of the spider.
#' @export
#' @inherit t
#' @param dir the directory to save the csv to. Can be set globally with [options()]
t_save_output <- function(dir = getOption("output_dir", "output")) {
    transformer(
        ~ {
            dir.create(dir, showWarnings = F)
            write.csv(
                .x,
                paste0(dir, "/", .y$name, ".csv"),
                row.names = F
            )
            .x
        },
        name = "save to output dir"
    )
}

#' bind rows
#' @export
#' @inherit t
t_bind_rows <- function() {
    transformer(
        ~ do.call(dplyr::bind_rows, .x),
        name = "bind rows"
    )
}


#' write results to aws s3
#'
#' To use this function, make sure that you have set the following in your .Renviron:
#' * AWS_ACCESS_KEY_ID
#' * AWS_SECRET_ACCESS_KEY
#' * AWS_DEFAULT_REGION
#' @md
#' @export
#' @inherit
#' @param bucket The aws bucket to save to. Can be set globally with [options()]
#' @param dir The directory in the bucket to save to. Can be set globally with [options()]
t_save_aws <- function(bucket = getOption("aws_bucket"), dir = getOption("aws_dir", "data")) {
    transformer(
        ~ {
            filename <- paste0(.y$name, ".csv")
            write.csv(.x, file.path(tempdir(), filename))

            aws.s3::put_object(
                file = file.path(tempdir(), filename),
                object = paste0(dir, "/", filename),
                bucket = bucket
            )
        },
        name = "save to aws"
    )
}

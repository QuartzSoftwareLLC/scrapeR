#' spider
#'
#' combination of multiple steps to be applied in parellel to data
#' @export
spider <- function(name,
                   queue = list(),
                   steps = list(),
                   pipeline = NA) {
    value <- list(
        name = name,
        queue = queue,
        steps = steps,
        pipeline = pipeline
    )
    # class can be set using class() or attr() function
    attr(value, "class") <- "spider"
    value
}

#' @export
print.spider <- function(x, ...) {
    cat(paste("# A spider:", x$name, "\n"))
    cat(paste("### Queue:", length(x$queue), "item(s)\n"))
    cat(paste0("### Steps: ", length(x$steps), "\n"))
    if (length(x$steps) > 0) {
        print(do.call(rbind, x$steps))
    }


    if (class(x$pipeline) != "logical") {
        cat("\nPipeline\n-------\n")
        print(x$pipeline)
    }
}

run_steps <- function(x, .data, spider = NA) {
    for (step in x$steps) {
        if (step[[2]] == "parser") {
            f <- step[[1]]
            .data <- purrr::map(.data, f, spider)
            .data <- purrr::flatten(.data)
        } else {
            .data <- purrr::map(list(.data), step[[1]], spider)
            if (1 == length(.data)) {
                .data <- .data[[1]]
            }
        }
    }
    .data
}

#' @export
run.spider <- function(.x) {
    .data <- run_steps(.x, .x$queue, .x)
    if (class(.x$pipeline) != "logical") {
        .data <- run_steps(.x$pipeline, .data, .x)
    }
    .data
}



#' @export
add_queue <- function(.x, items) {
    for (item in as.list(items)) {
        .x$queue[length(.x$queue) + 1] <- item
    }
    .x
}

#' @export
set_pipeline.spider <- function(.x, pipeline) {
    .x$pipeline <- pipeline
    .x
}

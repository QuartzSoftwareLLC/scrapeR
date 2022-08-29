#' Spider for crawling urls
#'
#' combination of multiple steps to be applied in parellel to data
#'
#' @section Queue:
#' The queue is a list of items to be passed through each of the
#' spider's steps. It is usually a list of urls that are then scraped individually by a parser
#' @section Steps:
#' Each spider is made of a series of steps.
#'
#' @param name the name of the spider to be used for logging purposes
#' @param queue the list of urls or initial paths to be used by parsers
#' @param steps a list of parsers or transformers to be applied to the data sequencially
#' @param pipeline the default pipeline to apply to the data after all steps are applied
#' @export
spider <- function(name = "",
                   queue = list(),
                   steps = list(),
                   pipeline = NA) {
    value <- list(
        name = name,
        queue = as.list(queue),
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

#' Rename a spider
#'
#' Redefine the name of a spider
#' @export
#' @examples
#' # this is often used after creating a template spider
#'
#' template <- spider("template")
#'
#' implementation_one <- set_name(spider, "implementation_one")
#' implementation_two <- set_name(spider, "implementation_two")
#' @family helpers
set_name <- function(.x, name) {
    .x$name <- name
    .x
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


#' Add items to a spider queue
#'
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


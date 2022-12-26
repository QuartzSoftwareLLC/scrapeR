#' Spider for crawling urls
#'
#' combination of multiple steps to be applied in parellel to data
#'
#' @param name the name of the spider to be used for logging purposes
#' @param queue the [list()] of urls or initial paths to be used by [steps()]
#' @param steps a [list()] of [steps()] to be applied to the data sequencially
#' @param pipeline the default [pipeline()] to apply to the data after all steps are applied
#' @export
#' @examples
#' s_multiply <- spider('multiply', queue = 1:4, steps = list(parser( ~ .x * 2)))
#' s_multiply
#'
#' run(s_multiply)
spider <- function(name = "",
                   queue = list(),
                   steps = list(),
                   pipeline = NA) {
    value <- list(
        name = name,
        debug = F,
        queue = as.list(queue),
        steps = steps,
        debugParallel = F,
        pipeline = pipeline
    )
    # class can be set using class() or attr() function
    attr(value, "class") <- "spider"
    value
}

print_steps <- function(x) {
    cat(paste0("### Steps: ", length(x$steps), "\n"))
    if (length(x$steps) > 0) {
        for (step in seq_along(x$steps)) {
            print(x$steps[[step]], number = step)
        }
    }
}

#' @export
print.spider <- function(x, ...) {
    cat(paste("# A spider:", x$name, "\n"))
    cat(paste("### Queue:", length(x$queue), "item(s)\n"))
    print_steps(x)

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
#' implementation_one <- set_name(spider(), "implementation_one")
#' implementation_one
#'
#' implementation_two <- set_name(spider(), "implementation_two")
#' implementation_two
#' @family helpers
set_name <- function(.x, name) {
    .x$name <- name
    .x
}

run_steps <- function(x, .data, spider = NA) {
    for (step in x$steps) {
        .data <- run(step, .data, spider)
    }
    .data
}

#' @export
#' @rdname run
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
#' @family helpers
#' @examples
#' spider() %>% add_queue("first item")
#'
#' spider() %>% add_queue(c("first item", "second item"))
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


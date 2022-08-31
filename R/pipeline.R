#' Collection of generic steps to append to spider
#'
#' combination of multiple steps to be applied in parellel to data
#' @export
#' @param name name of the pipeline
#' @param steps a [list()] of [steps()] to be applied
#' @examples
#' pipeline("clean names") |>
#'     add_transformer(
#'         ~ janitor::clean_names(.x)
#'     )
pipeline <- function(name = "", steps = list()) {
    value <- list(name = name, steps = steps)
    # class can be set using class() or attr() function
    attr(value, "class") <- "pipeline"
    value
}

#' @export
print.pipeline <- function(x, ...) {
    cat(paste("# A pipeline:", x$name, "\n"))
    print_steps(x)
}

#' @export
#' @rdname run
run.pipeline <- function(.x, .data) {
    run_steps(.x, .data)
}
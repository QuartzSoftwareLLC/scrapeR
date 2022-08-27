#' pipeline
#'
#' combination of multiple steps to be applied in parellel to data
#' @export
#' @examples
#' pipeline("clean names") |>
#'     add_transformer(
#'         ~ janitor::clean_names(.x)
#'     )
pipeline <- function(name, steps = list()) {
    value <- list(name = name, steps = steps)
    # class can be set using class() or attr() function
    attr(value, "class") <- "pipeline"
    value
}

#' @export
print.pipeline <- function(x, ...) {
    cat(paste("# A pipeline:", x$name, "\n"))
    cat(paste0("### Steps: ", length(x$steps), "\n"))
    print(do.call(rbind, x$steps))
}

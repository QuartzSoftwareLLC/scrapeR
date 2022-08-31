#' runner
#'
#' Run multiple spiders at once.
#' @export
#' @param spiders a [list()] of [spider()] objects to run
#' @param pipeline a [pipeline()] to apply to anny [spider()] objects that do not have a built in [pipeline()]
runner <- function(spiders = list(),
                   pipeline = NA) {
    value <- list(
        spiders = spiders,
        pipeline = pipeline
    )
    # class can be set using class() or attr() function
    attr(value, "class") <- "runner"
    value
}

#' @export
#' @rdname run
run.runner <- function(.x) {
    for (spider in .x$spiders) {

    }
}
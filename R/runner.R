#' runner
#'
#' Run multiple spiders at once.
#' @export
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
run.spider <- function(.x) {
    for (spider in .x$spiders) {

    }
}
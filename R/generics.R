#' Run a spider or a runner
#'
#' The run function goes through each step of a spider's steps and then runs each of the steps in it's pipeline.
#' @export
#' @family helpers
run <- function(.x, ...) {
    UseMethod("run")
}

#' pipeline
#' sets the pipeline used by the given spider
#' @export
#' @family helpers
set_pipeline <- function(.x, parser) {
    UseMethod("set_pipeline")
}
#' Add steps to a pipeline or spider.
#'
#' adds a step to the given pipeline.
#' @export
#' @family helpers
add_step <- function(.x, parser) {
    UseMethod("add_step")
}

#' @export
add_step.default <- function(.x, step) {
    .x$steps <- append(.x$steps, list(step))
    .x
}

#' @export
#' @rdname add_step
add_parser <- function(.x, parser) {
    UseMethod("add_parser")
}

#' @export
add_parser.default <- function(.x, parser) {
    .x$steps <- append(.x$steps, list(list(parser, "parser")))
    .x
}

#' @export
#' @rdname add_step
add_transformer <- function(.x, parser) {
    UseMethod("add_transformer")
}

#' @export
add_transformer.default <- function(.x, transformer) {
    .x$steps <- append(
        .x$steps,
        list(list(transformer, "transformer"))
    )
    .x
}

#' Run a spider or a runner
#'
#' The run function goes through each step of a spider's steps and then runs each of the steps in it's pipeline.
#' @export
#' @family helpers
run <- function(.x) {
    UseMethod("run")
}

#' pipeline
#' sets the pipeline used by the given spider
#' @export
#' @family helpers
set_pipeline <- function(.x, parser) {
    UseMethod("set_pipeline")
}
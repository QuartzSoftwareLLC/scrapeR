#' add_parser
#'
#' adds a parser step to the given pipeline. Parsers are applied to each item of the queue separately.
#' @export
add_parser <- function(.x, parser) {
    UseMethod("add_parser")
}

#' @export
add_parser.default <- function(.x, parser) {
    .x$steps <- append(.x$steps, list(list(parser, "parser")))
    .x
}

#' add_transformer
#'
#' adds a transformer step to the given pipeline.
#' Transformers are applied across all items of the pipeline and can often be used for aggregation.
#' @export
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

#' run
#'
#' Used to run either a pipeline or a runner.
#' @export
run <- function(obj) {
    UseMethod("run")
}

#' pipeline
#' sets the pipeline used by the given spider
#' @export
set_pipeline <- function(.x, parser) {
    UseMethod("set_pipeline")
}
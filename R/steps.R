#' @name add_step
#' @family helpers
#' @examples
#' spider() %>% add_parser(~ .x * 2)
#'
#' spider() %>% add_parser(~ .x * 2, name = "multiply by 2")
#'
#' spider() %>% add_transformer(~ sum(.x))
#'
#' spider() %>% add_transformer(~ sum(.x)), name = "get the sum")
NULL

#' Add steps to a pipeline or spider.
#'
#' adds a step to the given pipeline.
#' @param .x the spider or pipeline to update
#' @param step the parser or transformer step to add
#' @param after the index after which the step should be added
#' @export
add_step <- function(.x, step, after = length(.x$steps)) {
    if (!(class(step) %in% c("transformer", "parser"))) {
        stop("The step passed must be a transformer or a parser.")
    }
    .x$steps <- append(.x$steps, list(step), after = after)
    .x
}

#' @export
#' @rdname add_step
add_parser <- function(.x, ..., after = length(.x$steps)) {
    add_step(.x, parser(...), after = after)
}

#' @export
#' @rdname add_step
add_transformer <- function(.x, ..., after = length(.x$steps)) {
    add_step(.x, transformer(...), after = after)
}

#' Steps for Spiders and Pipelines
#'
#' Steps to be added to either the pipeline steps or spider steps.
#' @name steps
#' @seealso [add_step()] [add_parser()] [add_transformer()] [pipeline()] [spider()]
#' @param .f formula to be used in the step that accepts the input .x and optional .y parameters
#' @param name The name of the object
NULL

#' @export
#' @rdname steps
#' @param flatten whether or not to flatten the result of the parser
#' @param apply a function to apply to your parser function if you don't want to use [purrr::map()]
#' @examples
#' p_mult_2 <- parser( ~ .x * 2, name = "multply by two")
#' p_mult_2
#' 
#' run(p_mult_2, 1:5)
parser <- function(.f, name = paste(.f, collapse = ""), flatten = T, apply = NA) {
    value <- list(.f, type = "parser", name = name, flatten = flatten, apply = apply)
    # class can be set using class() or attr() function
    attr(value, "class") <- "parser"
    value
}

#' @export
#' @rdname steps
#' @examples
#'
#' t_sum <- transformer(~ sum(.x), name = "get sum")
#' t_sum
#'
#' run(t_sum, 1:5)
transformer <- function(.f, name = paste(.f, collapse = "")) {
    value <- list(.f, type = "transformer", name = name)
    # class can be set using class() or attr() function
    attr(value, "class") <- "transformer"
    value
}

#' @export
print.transformer <- function(x, number = 1, ...) {
    cat(paste("(", number, ") A transformer:", x$name, "\n"))
}

#' @export
print.parser <- function(x, number = 1, ...) {
    cat(paste("(", number, ") A parser:", x$name, "\n"))
}

#' @export
#' @rdname run
run.parser <- function(.x, .data, spider = spider()) {
    if (is.function(.x$apply)) {
        .data <- .x$apply(.data, .x, spider)
    } else {
        cat("Executing parser ", .x$name, "\n")
        .data <- purrr::map(.data, .x[[1]], spider)
    }

    if (.x$flatten) {
        .data <- purrr::flatten(.data)
    }
    .data
}


#' @export
#' @rdname run
run.transformer <- function(.x, .data, spider = spider()) {
    cat("Executing transformer ", .x$name, "\n")
    .data <- purrr::map(list(.data), .x[[1]], spider)
    if (1 == length(.data)) {
        .data <- .data[[1]]
    }
    .data
}
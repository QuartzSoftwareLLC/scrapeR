#' debug
#' sets a debugger breakpoint
#' @export
d <- function(obj, head = 1, parallel = F) {
    options(error = browser())

    print(obj)
    obj$debug <- T
    obj$debugHead <- head
    obj$debugParallel <- parallel
    .d <<- run(obj)
    cat("First Item: \n")
    print(head(.data, head))
    .x <<- .d[[1]]
    browser()
    obj
}
#' debug
#' sets a debugger breakpoint
#' 
#' This will automatically start running the scraper and drop into the debugger where placed. It assigns environment variables .x as the first item in the queue and .d as the entire queue.
#' @export
d <- function(obj, head = 1, parallel = F) {
    options(error = browser)

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
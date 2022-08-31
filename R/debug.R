#' debug
#' sets a debugger breakpoint
#' @export
d <- function(obj) {
    print(obj)
    .data <<- run(obj)
    cat("First Item: \n")
    print(head(.data, 1))
    .x <<- .data[[1]]
    browser()
    obj
}
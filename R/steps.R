#' parser
#'
#' @export
parser <- function(.f) {
    value <- list(.f, "parser")
    # class can be set using class() or attr() function
    attr(value, "class") <- "parser"
    value
}
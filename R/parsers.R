#' p
#' @name p
#' @return [parser()]
NULL

#' read html
#'
#' Uses the built rvest function to read the urls
#' @inherit p
#' @export
p_read_html <- function() {
    parser(
        \(.x, ...) rvest::read_html(.x),
        name = "read html",
        flatten = F,
        apply = \(.data, .step, ...) {
            cat(paste("Executing step in parallel:", .step$name, "\n"))
            .data <- parallel::mclapply(
                .data,
                \(x) as.character(.step[[1]](x)),
                mc.cores = 16
            )

            .data <- lapply(.data, rvest::minimal_html)
            .data
        }
    )
}

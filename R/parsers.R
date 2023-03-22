#' p
#' @name p
#' @return [parser()]
NULL

#' read html
#'
#' Uses the built rvest function to read the urls in parallel
#' @inherit p
#' @export
p_read_html <- function() {
    parser(
        \(.x, ...) rvest::read_html(.x),
        name = "read html",
        flatten = F,
        apply = \(.data, .step, .spider = spider(), ...) {

            if (.spider$debug & !.spider$debugParallel) {
                cat(paste("Executing step:", .step$name, "\n"))
                f <- purrr::map
            }
            else {
                cat(paste("Executing step in parallel:", .step$name, "\n"))
                f <- purrr::partial(pbmcapply::pbmclapply, mc.cores = 16)
            }
            .data <- f(
                .data,
                \(x) as.character(.step[[1]](x))            )

            .data <- lapply(.data, rvest::minimal_html)
            .data
        }
    )
}

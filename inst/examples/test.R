devtools::load_all()
pacman::p_load(tidyverse, rvest, pbmcapply)


pipeline("clean and save to csv") |>
    add_transformer(
        ~ janitor::clean_names(.x)
    ) |>
    add_transformer(~ {
        dir.create("output", showWarnings = F)
        write.csv(
            .x,
            paste0("output/", .y$name, ".csv"),
            row.names = F
        )
        .x
    }) -> csv_pipeline

nrvss_spider <- spider("nrevss") |>
    add_queue(paste0(
        root,
        "/surveillance/nrevss/",
        c("rotavirus", "norovirus", "rsv", "adeno", "human-paraflu", "coronavirus", "hmpv"),
        "/index.html"
    )) |>
    add_step(p_read_html()) |>
    add_parser(
        ~ .x |>
            html_nodes("a.card") |>
            html_attr("href") |>
            sapply(\(x) paste0(root, x))
    ) |>
    add_step(p_read_html()) |>
    add_parser(~ {
        .x |>
            html_nodes("a") -> els

        tibble(
            text = html_text(els),
            href = html_attr(els, "href")
        ) |>
            filter(grepl("Table", text)) |>
            with(
                paste0(root, href)
            )
    }) |>
    add_step(p_read_html()) |>
    add_step(parser(~ {
        data <- .x |>
            html_table() |>
            purrr::pluck(1)
        if (!is.null(data)) {
            data |>
                select(-1) |>
                mutate(
                    virus = str_extract(.y, "nrevss/(.*?)/", 1),
                    y = .y
                )
        }
    }, flatten = F)) |>
    add_step(t_bind_rows()) |>
    set_pipeline(csv_pipeline)

nrvss_spider |>
    run()

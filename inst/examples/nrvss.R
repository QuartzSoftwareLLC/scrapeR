devtools::load_all()
library(tidyverse)
library(rvest)

root <- "https://www.cdc.gov"

pipeline("clean and save to csv") %>%
    add_transformer(
        ~ janitor::clean_names(.x)
    ) %>%
    add_transformer(~ {
        dir.create("output", showWarnings = F)
        write.csv(
            .x,
            paste0("output/", .y$name, ".csv"),
            row.names = F
        )
        .x
    }) -> csv_pipeline

spider("nrevss") %>%
    add_queue(paste0(
        root,
        "/surveillance/nrevss/rotavirus/index.html"
    )) %>%
    add_parser(
        ~ read_html(.x) %>%
            html_nodes("a.card") %>%
            html_attr("href") %>%
            sapply(\(x) paste0(root, x))
    ) %>%
    add_parser(~ {
        read_html(.x) %>%
            html_nodes("a") -> els

        tibble(
            text = html_text(els),
            href = html_attr(els, "href")
        ) %>%
            subset(grepl("Table", text)) %>%
            subset(!grepl("Nat", href)) %>%
            with(
                paste0(root, href)
            )
    }) %>%
    add_parser(~ {
        read_html(.x) %>%
            html_table()
    }) %>%
    add_transformer(
        ~ do.call(rbind, .x)
    ) %>%
    set_pipeline(csv_pipeline) %>%
    run()

nrvss_spider

run(nrvss_spider)

# runner
# spider
# pipeline
# transformer

# add_parser.spider
# add_pipeline.runner
# add_spider.runner
# add_spider.pipeline
# run.runner
# run.pipeline
# run.spider
# setPipeline.runner
# add_transformer.spider
# add_transformer.pipeline
# add_tran



# runner
# parsers
# pipeliens
test_that("p_read_html works", {
    run(p_read_html(), "https://simple.wikipedia.org/wiki/Cat") %>%
        dplyr::first() %>%
        expect_s3_class("xml_document")
})
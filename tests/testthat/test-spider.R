test_that("add_queue can add a single item to the queue", {
  spider() %>%
    add_queue("first") -> x

  expect_equal(x$queue, list("first"))
})

test_that("add_queue can add a multiple items to the queue", {
  spider(queue = "zero") %>%
    add_queue(c("first", "second")) -> x

  expect_equal(x$queue, list("zero", "first", "second"))
})

test_that("spider works with single parser", {
  spider(queue = c(0, 1)) %>%
    add_parser(~ .x + 1) %>%
    run() %>%
    expect_equal(list(1, 2))
})

test_that("spider works with single transformer", {
  spider(queue = c(0, 1)) %>%
    add_transformer(~ as.numeric(.x) %>% sum()) %>%
    run() %>%
    expect_equal(1)
})
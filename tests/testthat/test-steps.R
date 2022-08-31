test_that("steps can be run", {
  transformer(~ .x * 2) %>%
    run(1:2) %>%
    expect_equal(c(2, 4))

  parser(~ .x * 2) %>%
    run(1:2) %>%
    expect_equal(list(2, 4))
})

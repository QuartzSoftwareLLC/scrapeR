test_that("pipelines can be added", {
  multiply_pipeline <- pipeline() %>% add_transformer(~2)

  spider() %>%
    set_pipeline(multiply_pipeline) %>%
    run() %>%
    expect_equal(2)
})

test_that("pipelines can be run", {
  pipeline() %>%
    add_transformer(~ .x * 2) %>%
    run(2) %>%
    expect_equal(4)
})
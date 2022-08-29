test_that("pipelines can be added", {
  multiply_pipeline <- pipeline() %>% add_transformer(~2)

  spider() %>%
    set_pipeline(multiply_pipeline) %>%
    run() %>%
    expect_equal(2)
})

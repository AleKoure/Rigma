test_that("Text data from file styles is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  text_data <- file_key %>%
    get_file_styles() %>%
    as_design_tibble() %>%
    text_data_from_styles()
  expect_equal(
    names(text_data)[1:3],
    c("node_id", "name", "fontFamily")
  )
})

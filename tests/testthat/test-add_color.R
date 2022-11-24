test_that("Add color to style data", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  design_tibble <- get_file_styles(file_key = file_key) %>%
    as_design_tibble(message = FALSE) %>%
    add_color()
  expect_s3_class(design_tibble, "design_tibble_style")
  expect_true("color" %in% names(design_tibble))
  expect_true(is.character(design_tibble$color))

  design_tibble_rgba <- get_file_styles(file_key = file_key) %>%
    as_design_tibble(message = FALSE) %>%
    add_color(hex = FALSE)
  expect_true(is.list(design_tibble_rgba$color))
})

test_that("GET file component sets is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- get_file_component_sets(file_key = file_key)
  expect_s3_class(resp, "rigma_get_file_component_sets")
  expect_setequal(names(resp),  c("error", "status", "meta", "i18n"))
  expect_error(
    get_file_components(file_key = "foo"),
    "Not found"
  )
})

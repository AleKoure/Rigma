test_that("GET file client is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- get_file(file_key)
  expect_class(resp, "rigma_get_file_resp")
  expect_identical(
    names(resp),
    c("document", "components", "componentSets", "styles", "metadata")
  )
  expect_number(resp$metadata$schemaVersion)
  expect_class(resp$metadata$lastModified, "POSIXct")
  expect_string(resp$metadata$name)
})

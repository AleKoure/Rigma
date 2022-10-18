test_that("GET file client is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- get_file(file_key)
  expect_s3_class(resp, "rigma_get_file")
  expect_identical(
    names(resp),
    c("document", "components", "componentSets", "styles", "metadata")
  )
  expect_number(resp$metadata$schemaVersion)
  expect_s3_class(resp$metadata$lastModified, "POSIXct")
  expect_type(resp$metadata$name, "character")
})

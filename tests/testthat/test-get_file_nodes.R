test_that("GET file nodes client is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- get_file_nodes(file_key, ids = "0:0")
  expect_s3_class(resp, "rigma_get_file_nodes")
  expect_identical(
    names(resp),
    c("nodes", "metadata")
  )
  expect_s3_class(resp$metadata$lastModified, "POSIXct")
  expect_type(resp$metadata$name, "character")
  expect_type(resp$nodes, "list")
})

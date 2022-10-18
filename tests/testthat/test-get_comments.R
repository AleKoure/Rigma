test_that("GET comments client is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- get_comments(file_key)
  expect_s3_class(resp, "rigma_get_comments")
})

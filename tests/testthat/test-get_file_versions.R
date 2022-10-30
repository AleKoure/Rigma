test_that("GET file version is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- get_file_versions(file_key)
  expect_s3_class(resp, "rigma_get_file_versions")
  expect_setequal(names(resp),  c("versions", "pagination"))
})

test_that("GET image fills client is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- get_image_fills(file_key)
  expect_s3_class(resp, "rigma_get_image_fills")
  expect_false(resp$error)
  expect_equal(resp$status, 200)
  expect_type(resp$meta, "list")
  expect_null(resp$i18n)
  expect_identical(
    names(resp),
    c("error", "status", "meta", "i18n")
  )
})

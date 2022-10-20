test_that("POST comment is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- post_comment(
    file_key,
    message = "Rigma test",
    client_meta = list(x = 2, y = 2)
  )
  expect_s3_class(resp, "rigma_post_comment")
  expect_identical(
    names(resp),
    c("id", "file_key", "parent_id", "user", "created_at", "resolved_at",
      "message", "reactions", "client_meta", "order_id" )
  )
  expect_s3_class(resp$created_at, "POSIXct")
  expect_type(resp$client_meta$x, "integer")
  expect_type(resp$client_meta$x, "integer")
})

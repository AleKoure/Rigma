test_that("DELETE comment is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- post_comment(
    file_key,
    message = "Delete me",
    client_meta = list(x = 0, y = 0)
  )
  resp_delete <- delete_comment(file_key, resp$id)
  expect_s3_class(resp_delete, "rigma_delete_comment")
  expect_identical(
    names(resp_delete),
    c("error", "status", "i18n")
  )
  expect_false(resp_delete$error)
  expect_equal(resp_delete$status, 200)
})

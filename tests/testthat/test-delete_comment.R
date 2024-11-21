test_that("DELETE comment is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- post_comment(
    file_key,
    message = "Delete me",
    client_meta = list(x = 0, y = 0)
  )
  resp_delete <- rlang::try_fetch(
    delete_comment(file_key, resp$id),
    error = \(cnd) NULL
  )

  skip_if(
    is.null(resp_delete),
    "You don't have permission to access the test resources."
  )

  expect_s3_class(resp_delete, "rigma_delete_comment")
  expect_identical(
    names(resp_delete),
    c("error", "status", "i18n")
  )
  expect_false(resp_delete$error)
  expect_equal(resp_delete$status, 200)
})

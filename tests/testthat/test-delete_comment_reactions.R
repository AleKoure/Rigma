test_that("DELETE comment reactions is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- post_comment(
    file_key,
    message = "Delete me",
    client_meta = list(x = 0, y = 0)
  )

  resp_comment_reactions <- post_comment_reactions(
    file_key,
    comment_id = resp$id,
    emoji = ":eyes:"
  )

  resp_delete_reactions <- delete_comment_reactions(
    file_key,
    comment_id = resp$id,
    emoji = ":eyes:"
  )

  expect_s3_class(resp_comment_reactions, "rigma_post_comment_reactions")
  expect_identical(
    names(resp_comment_reactions),
    c("error", "status", "i18n")
  )
  expect_false(resp_comment_reactions$error)
  expect_equal(resp_comment_reactions$status, 200)
})

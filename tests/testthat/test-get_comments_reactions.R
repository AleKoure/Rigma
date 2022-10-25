test_that("GET comments reactions client is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- post_comment(
    file_key,
    message = "Delete me",
    client_meta = list(x = 0, y = 0)
  )

  resp_reactions <- get_comments_reactions(file_key, resp$id)
  expect_s3_class(resp_reactions, "rigma_get_comments_reactions")
  expect_equal(
    names(resp_reactions),
    c("reactions", "pagination")
  )
})

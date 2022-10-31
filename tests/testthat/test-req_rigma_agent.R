test_that("req_rigma_agent is OK!", {
  skip_on_cran()
  req <- request("https://api.figma.com/v1/files/") %>%
    req_rigma_agent()
  expect_true(req$headers$`X-Figma-Token` != "")
  expect_true(req$options$useragent != "")
  expect_equal(req$policies$retry_max_tries, 3)
  expect_equal(req$policies$retry_backoff(), 20)
})

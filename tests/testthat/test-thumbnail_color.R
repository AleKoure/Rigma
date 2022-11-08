test_that("Get color from thumbnail is OK!", {
  path <- system.file("extdata", "test_thumbnail.png", package = "Rigma")
  res_hex <- thumbnail_color(path)
  expect_true(grepl("^#", res))
  res_rgba <- thumbnail_color(path, hex = FALSE)
  expect_equal(names(res_rgba), c("red", "green", "blue", "alpha"))
  lapply(unlist(res_rgba), expect_lte, 1)
  lapply(unlist(res_rgba), expect_gte, 0)
})

test_that("as_design_tibble for file styles is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- get_file_styles(file_key = file_key)
  expect_message(as_design_tibble(resp), "Nesting user data")
  expect_message(as_design_tibble(resp, message = FALSE), NA)
  expect_equal(ncol(as_design_tibble(resp)), 11)
})

test_that("as_design_tibble for file styles is OK!", {
  skip_on_cran()
  resp <- get_team_styles("1168610438838663284")
  expect_message(as_design_tibble(resp), "Nesting user data")
  expect_message(as_design_tibble(resp, message = FALSE), NA)
  expect_equal(ncol(as_design_tibble(resp)), 11)
})

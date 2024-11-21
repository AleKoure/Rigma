test_that("GET team styles is OK!", {
  skip_on_cran()
  resp <- rlang::try_fetch(
    get_team_styles("1168610438838663284"),
    error = \(cnd) NULL
  )

  skip_if(
    is.null(resp),
    "You don't have permission to access the test resources."
  )

  expect_s3_class(resp, "rigma_get_team_styles")
  expect_error(
    get_team_styles(team_id = "foo"),
    "This team is unavailable."
  )
  expect_setequal(names(resp),  c("error", "status", "meta", "i18n"))
})

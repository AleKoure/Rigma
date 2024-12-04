test_that("GET team styles is OK!", {
  skip_on_cran()
  resp <- get_team_styles("1168610438838663284")

  expect_s3_class(resp, "rigma_get_team_styles")
  expect_error(
    get_team_styles(team_id = "foo"),
    "This team is unavailable."
  )
  expect_setequal(names(resp),  c("error", "status", "meta", "i18n"))
})

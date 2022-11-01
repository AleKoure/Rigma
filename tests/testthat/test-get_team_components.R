test_that("GET team components is OK!", {
  skip_on_cran()
  resp <- get_team_components("1168610438838663284")
  expect_s3_class(resp, "rigma_get_team_components")
  expect_error(
    get_team_components(team_id = "foo"),
    "This team is unavailable."
  )
  expect_setequal(names(resp),  c("error", "status", "meta", "i18n"))
})

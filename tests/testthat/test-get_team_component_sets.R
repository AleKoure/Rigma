test_that("GET team component sets is OK!", {
  skip_on_cran()
  resp <- get_team_component_sets("1168610438838663284")
  expect_s3_class(resp, "rigma_get_team_component_sets")
  expect_error(
    get_team_component_sets(team_id = "foo"),
    "This team is unavailable."
  )
  expect_setequal(names(resp),  c("error", "status", "meta", "i18n"))
})

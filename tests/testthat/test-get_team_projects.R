test_that("GET team projects is OK!", {
  skip_on_cran()
  resp <- get_team_projects("1168610438838663284")
  expect_s3_class(resp, "rigma_get_team_projects")
  expect_setequal(names(resp),  c("name", "projects"))
})

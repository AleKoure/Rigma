test_that("GET team projects is OK!", {
  skip_on_cran()
  resp <- rlang::try_fetch(
    get_team_projects("1168610438838663284"),
    error = \(cnd) NULL
  )

  skip_if(
    is.null(resp),
    "You don't have permission to access the test resources."
  )

  expect_s3_class(resp, "rigma_get_team_projects")
  expect_setequal(names(resp),  c("name", "projects"))
})

test_that("GET project files is OK!", {
  skip_on_cran()

  project_id <- "71686204"
  resp <- get_project_files(project_id)

  expect_s3_class(resp, "rigma_get_project_files")
  expect_setequal(names(resp),  c("name", "files"))
  resp <- get_project_files(project_id, branch_data = TRUE)
  expect_setequal(names(resp),  c("name", "files"))
})

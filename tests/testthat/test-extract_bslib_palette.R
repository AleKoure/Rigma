test_that("Extract bslib palette is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  bslib_vars <- file_key %>%
    get_file_styles() %>%
    as_design_tibble() %>%
    add_color() %>%
    extract_bslib_palette()
  expect_true(
    all(
      names(bslib_vars) %in% names(rlang::fn_fmls(bslib::bs_theme))
    )
  )
})

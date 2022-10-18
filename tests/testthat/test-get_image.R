test_that("GET image client is OK!", {
  skip_on_cran()
  file_key <- "sFHgQh9dL6369o5wrZHmdR"
  resp <- get_image(file_key, ids = "0:1", format = "svg")
  conn <- url(resp$images$`0:1`)
  xml_svg <- xml2::read_xml(conn)
  expect_s3_class(resp, "rigma_get_image")
  expect_s3_class(conn, "url")
  expect_s3_class(xml_svg, "xml_document")
  expect_equal(names(xml2::as_list(xml_svg)), "svg")
  expect_identical(
    names(resp),
    c("err", "images")
  )
})

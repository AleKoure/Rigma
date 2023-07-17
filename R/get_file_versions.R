#' GET file versions
#'
#' @description A list of the versions of a file.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @returns S3 object of class `rigma_get_file_versions`. Contains the parsed
#' JSON response with fields `versions`, and `pagination`.
#'
#' @importFrom checkmate assert_string assert_integer assert_logical expect_list
#'
#' @importFrom purrr chuck
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' get_file_versions(file_key)
#' }
#'
#' @export
get_file_versions <- function(file_key) {
  assert_file_key(file_key)

  resp <- request_figma() %>%
    req_figma_template(
      "versions",
      file_key = file_key,
      .perform = TRUE
    )

  structure(
    list(
      versions = resp %>% chuck("versions"),
      pagination = resp %>% chuck("pagination")
    ),
    class = "rigma_get_file_versions"
  )
}

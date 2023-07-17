#' GET comments
#'
#' @description Gets a list of comments left on the file.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @returns S3 object of class `rigma_get_comments`. Contains the parsed
#' JSON response.
#'
#' @importFrom checkmate assert_string assert_integer assert_logical expect_list
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' get_comments(file_key)
#' }
#'
#' @export
get_comments <- function(file_key) {
  assert_file_key(file_key)

  resp <- request_figma() %>%
    req_figma_template(
      "comments",
      file_key = file_key,
      .perform = TRUE
    )

  structure(resp, class = "rigma_get_comments")
}

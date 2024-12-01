#' DELETE comments
#'
#' @description Deletes a specific comment. Only the person who made the
#' comment is allowed to delete it.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @param comment_id string. The comment id.
#'
#' @returns S3 object of class `rigma_delete_comment`. Contains the parsed
#' JSON response with fields `error`, `status`, and `i18n`.
#'
#' @importFrom checkmate assert_string
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' # navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' first_comment_id <- get_comments(file_key)$comments[[1]]$id
#' delete_comment(file_key, first_comment_id)
#' }
#'
#' @export
delete_comment <- function(
    file_key,
    comment_id
) {
  assert_file_key(file_key)
  assert_string(comment_id)

  resp <- request_figma(
    method = "DELETE",
  ) %>%
    req_figma_template(
      endpoint = "comments",
      file_key = file_key,
      comment_id = comment_id
    ) %>%
    req_figma_perform()

  structure(
    list(
      error = resp %>% chuck("error"),
      status = resp %>% chuck("status"),
      i18n = resp %>% chuck("i18n")
    ),
    class = "rigma_delete_comment"
  )
}

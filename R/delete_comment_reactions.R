#' DELETE comment reactions
#'
#' @description Removes a particular comment reaction. The only person with
#' the ability to delete a comment reaction is the original poster.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @param comment_id string. Comment id of comment to delete reaction from.
#'
#' @param emoji string. The emoji type of reaction to delete as a string enum
#' :eyes:, :heart_eyes:, :heavy_plus_sign:, :+1:, :-1:, :joy: and :fire:
#'
#' @returns S3 object of class `rigma_delete_comment_reactions`. Contains the
#'   parsed JSON response with fields `error`, `status`, and `i18n`.
#'
#' @importFrom checkmate assert_string
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' # navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' first_comment_id <- get_comments(file_key)$comments[[1]]$id
#' delete_comment_reactions(file_key, first_comment_id, ":eyes:")
#' }
#'
#' @export
delete_comment_reactions <- function(
    file_key,
    comment_id,
    emoji
) {
  assert_file_key(file_key)
  assert_string(comment_id)
  assert_string(emoji)

  resp <- request_figma(
    method = "DELETE"
  ) %>%
    req_figma_template(
      endpoint = "comment reactions",
      file_key = file_key,
      comment_id = comment_id
    ) %>%
    req_figma_query(
      emoji = emoji
    )

  structure(
    list(
      error = resp %>% chuck("error"),
      status = resp %>% chuck("status"),
      i18n = resp %>% chuck("i18n")
    ),
    class = "rigma_delete_comment_reactions"
  )
}

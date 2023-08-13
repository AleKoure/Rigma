#' POST comment reactions
#'
#' @description Posts a new comment reaction on a file comment.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @param comment_id string. If there is one, the comment to respond to. You
#' cannot reply to a remark that is a reply to itself (a reply has a parent id),
#' thus this must be a root comment.
#'
#' @param emoji string. The emoji type of reaction as a string enum :eyes:,
#' :heart_eyes:, :heavy_plus_sign:, :+1:, :-1:, :joy: and :fire:
#'
#' @returns S3 object of class `rigma_post_comment_reactions`. Contains the parsed
#' JSON response with fields `error`, `status`, and `i18n`.
#'
#' @importFrom httr2 resp_body_json
#'
#' @importFrom checkmate assert_string
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' first_comment_id <- get_comments(file_key)$comments[[1]]$id
#' post_comment_reactions(file_key, first_comment_id, ":eyes:")
#' }
#'
#' @export
post_comment_reactions <- function(
    file_key,
    comment_id,
    emoji
) {
  assert_file_key(file_key)
  assert_string(comment_id)
  assert_string(emoji)

  resp <- request_figma() %>%
    req_figma_template(
      "comment reactions",
      file_key = file_key,
      comment_id = comment_id
    ) %>%
    req_body_json(
      data = list(emoji = emoji)
      ) %>%
    req_figma_perform()

  structure(
    list(
      error = resp %>% chuck("error"),
      status = resp %>% chuck("status"),
      i18n = resp %>% chuck("i18n")
    ),
    class = "rigma_post_comment_reactions"
  )
}

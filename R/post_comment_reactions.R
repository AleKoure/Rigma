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
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query req_body_form req_body_json req_method
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
  assert_string(file_key)
  assert_string(comment_id)
  assert_string(emoji)

  resp <- request("https://api.figma.com/v1/files/") %>%
    req_url_path_append(file_key) %>%
    req_url_path_append("comments") %>%
    req_url_path_append(comment_id) %>%
    req_url_path_append("reactions") %>%
    req_method("POST") %>%
    req_body_json(list(emoji = emoji)) %>%
    req_error(body = function(resp) {
      resp %>%
        resp_body_json() %>%
        chuck("message")
    }) %>%
    req_rigma_agent %>%
    req_perform() %>%
    resp_body_json()

  structure(
    list(
      error = resp %>% chuck("error"),
      status = resp %>% chuck("status"),
      i18n = resp %>% chuck("i18n")
    ),
    class = "rigma_post_comment_reactions"
  )
}

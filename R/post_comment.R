#' POST comment
#'
#' @description Posts a new comment on the file.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @param message string. The comment's textual content to post.
#'
#' @param comment_id string. If there is one, the comment to respond to. You
#' cannot reply to a remark that is a reply to itself (a reply has a parent id),
#' thus this must be a root comment.
#'
#' @param client_meta string. The position of where to place the comment.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query req_body_form req_body_json
#'
#' @importFrom checkmate assert_string assert_list
#'
#' @importFrom lubridate as_datetime
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \donttest{
#' #navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' get_comments(file_key)
#' }
#'
#' @export
post_comment <- function(
  file_key,
  message,
  comment_id = NULL,
  client_meta
) {
  assert_string(file_key)
  assert_string(message)
  assert_string(comment_id, null.ok = TRUE)
  assert_list(client_meta)

  params <- list(
    message = message,
    comment_id = comment_id,
    client_meta = client_meta
  )

  resp <- request("https://api.figma.com/v1/files/") %>%
    req_url_path_append(file_key) %>%
    req_url_path_append("comments") %>%
    req_body_json(params) %>%
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
      id = resp %>% chuck("id"),
      file_key = resp %>% chuck("file_key"),
      parent_id = resp %>% chuck("parent_id"),
      user = resp %>% chuck("user"),
      created_at = resp %>%
        chuck("created_at") %>%
        as_datetime(),
      resolved_at = resp %>% chuck("resolved_at"),
      message = resp %>% chuck("message"),
      reactions = resp %>% chuck("reactions"),
      client_meta = resp %>% chuck("client_meta"),
      order_id = resp %>% chuck("order_id")
    ),
    class = "rigma_post_comment"
  )
}

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
#' @returns S3 object of class `rigma_post_comment`. Contains the parsed
#' JSON response with fields `id`, `file_key`, `status`, `i18n`, `parent_id`,
#' `user`, `created_at`, `resolved_at`, `message`, `reactions`, `client_meta`,
#' and `order_id`.
#'
#' @importFrom httr2 req_body_json
#'
#' @importFrom checkmate assert_string assert_list
#'
#' @importFrom lubridate as_datetime
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
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
  assert_file_key(file_key)
  assert_string(message)
  assert_list(client_meta)

  data <- list(
    message = message,
    client_meta = client_meta
  )

  if (!is_null(comment_id)) {
    assert_string(comment_id)
    data <- c(data, list(comment_id = comment_id))
  }

  resp <- request_figma() %>%
    req_figma_template(
      "comments",
      file_key = file_key
    ) %>%
    req_body_json(
      data = data
    ) %>%
    req_figma_perform()

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

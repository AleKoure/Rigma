#' DELETE comments
#'
#' @description Deletes a specific comment. Only the person who made the
#' comment is allowed to delete it.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @param comment_id string. The comment id.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query req_method
#'
#' @importFrom checkmate assert_string
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \donttest{
#' #navigate to  file and get key from url
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
  assert_string(file_key)
  assert_string(comment_id)

  resp <- request("https://api.figma.com/v1/files/") %>%
    req_url_path_append(file_key) %>%
    req_url_path_append("comments") %>%
    req_url_path_append(comment_id) %>%
    req_method("DELETE") %>%
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
    class = "rigma_delete_comment"
  )
}

#' GET comments reactions
#'
#' @description Obtains a paginated list of the comments' reactions.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @param comment_id string. The comment id.
#'
#' @param cursor string obtained from the result of the previous request, a
#' cursor for pagination.
#'
#' @returns S3 object of class `rigma_get_comments_reactions`. Contains the parsed
#' JSON response with fields `reactions`, and `pagination`.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query
#'
#' @importFrom checkmate assert_string
#'
#' @importFrom purrr chuck
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \donttest{
#' #navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' resp <- get_comments(file_key)
#' resp_reactions <- get_comments_reactions(file_key, resp$comments[[1]]$id)
#' }
#'
#' @export
get_comments_reactions <- function(
  file_key,
  comment_id,
  cursor = NULL
) {
  assert_string(file_key)
  assert_string(comment_id)
  assert_string(cursor, null.ok = TRUE)

  params <- list(
    cursor = cursor
  )

  resp <- request("https://api.figma.com/v1/files/") %>%
    req_url_path_append(file_key) %>%
    req_url_path_append("comments") %>%
    req_url_path_append(comment_id) %>%
    req_url_path_append("reactions") %>%
    req_url_query(!!!params) %>%
    req_error(body = function(resp) {
      resp %>%
        resp_body_json() %>%
        chuck("err")
    }) %>%
    req_rigma_agent %>%
    req_perform() %>%
    resp_body_json()

  structure(
    list(
      reactions = resp %>% chuck("reactions"),
      pagination = resp %>% chuck("pagination")
    ),
    class = "rigma_get_comments_reactions"
  )
}

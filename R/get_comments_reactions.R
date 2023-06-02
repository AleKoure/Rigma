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
#' @importFrom checkmate assert_string
#'
#' @importFrom purrr chuck
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
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
  file_key <- set_file_key(file_key)
  assert_string(comment_id)
  assert_string(cursor, null.ok = TRUE)

  resp <- request_figma_endpoint(
    "comment reactions",
    file_key = file_key,
    comment_id = comment_id
  ) %>%
    req_figma_query(
      cursor = cursor
    )

  structure(
    list(
      reactions = resp %>% chuck("reactions"),
      pagination = resp %>% chuck("pagination")
    ),
    class = "rigma_get_comments_reactions"
  )
}

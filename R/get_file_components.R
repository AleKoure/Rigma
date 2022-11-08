#' GET file components
#'
#' @description Get a list of published components within a file library.
#' Note that published components are only available via the professional
#' plan.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @returns S3 object of class `rigma_get_file_components`. Components are
#' stored in the `meta` field.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query
#'
#' @importFrom checkmate assert_string
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to team page and get id from url
#' file_key <- "gYRjH0y8ZM0VtEfO8kf6ch"
#' get_file_components(file_key)
#' }
#'
#' @export
get_file_components <- function(file_key) {
  assert_string(file_key)

  resp <- request("https://api.figma.com/v1/files/") %>%
    req_url_path_append(file_key) %>%
    req_url_path_append("components") %>%
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
      error = resp %>% chuck("error"),
      status = resp %>% chuck("status"),
      meta = resp %>% chuck("meta"),
      i18n = resp %>% chuck("i18n")
    ),
    class = "rigma_get_file_components"
  )
}

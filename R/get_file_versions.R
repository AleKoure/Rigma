#' GET file versions
#'
#' @description A list of the versions of a file.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query
#'
#' @importFrom checkmate assert_string assert_integer assert_logical expect_list
#'
#' @importFrom purrr chuck
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \donttest{
#' #navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' get_file_versions(file_key)
#' }
#'
#' @export
get_file_versions <- function(file_key) {
  assert_string(file_key)

  resp <- request("https://api.figma.com/v1/files/") %>%
    req_url_path_append(file_key) %>%
    req_url_path_append("versions") %>%
    req_headers(`X-Figma-Token` = Sys.getenv("FIGMA_ACCESS_TOKEN")) %>%
    req_user_agent("Rigma (http://my.rigma)") %>%
    req_error(body = function(resp) {
      resp %>%
        resp_body_json() %>%
        chuck("err")
    }) %>%
    req_perform() %>%
    resp_body_json()

  structure(
    list(
      versions = resp %>% chuck("versions"),
      pagination = resp %>% chuck("pagination")
    ),
    class = "rigma_get_file_versions"
  )
}

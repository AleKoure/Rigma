#' GET component set
#'
#' @description Get metadata on a component_set by key. To publish components
#' join a Figma team and subscribe for professional account.
#'
#' @param key string. The unique identifier of the component.
#'
#' @returns S3 object of class `rigma_get_component_set`.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query
#'
#' @importFrom checkmate assert_string
#'
#' @examples
#' \dontrun{
#' component_key <- "my_key"
#' get_component_sets(component_key)
#' }
#'
#' @export
get_component_sets <- function(key) {
  assert_string(key)

  resp <- request("https://api.figma.com/v1/component_sets/") %>%
    req_url_path_append(key) %>%
    req_rigma_agent %>%
    req_perform() %>%
    resp_body_json()

  structure(
    resp,
    class = "rigma_get_component_sets"
  )
}

#' GET component
#'
#' @description Get metadata on a component by key. To publish components join
#' a Figma team and subscribe for professional account.
#'
#' @param key string. The unique identifier of the component.
#'
#' @returns S3 object of class `rigma_get_component`.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query
#'
#' @importFrom checkmate assert_string
#'
#' @examples
#' \dontrun{
#' component_key <- "my_key"
#' get_component(component_key)
#' }
#'
#' @export
get_component <- function(key) {
  assert_string(key)

  resp <- request("https://api.figma.com/v1/components/") %>%
    req_url_path_append(key) %>%
    req_rigma_agent %>%
    req_perform() %>%
    resp_body_json()

  structure(
    resp,
    class = "rigma_get_component"
  )
}

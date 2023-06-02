#' GET component set
#'
#' @description Get metadata on a component_set by key. To publish components
#' join a Figma team and subscribe for professional account.
#'
#' @param key string. The unique identifier of the component.
#'
#' @returns S3 object of class `rigma_get_component_set`.
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

  resp <- request_figma_endpoint(
    "component sets",
    key = key
    ) %>%
    figma_resp()

  structure(
    resp,
    class = "rigma_get_component_sets"
  )
}

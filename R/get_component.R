#' GET component
#'
#' @description Get metadata on a component by key. To publish components join
#' a Figma team and subscribe for professional account.
#'
#' @param key string. The unique identifier of the component.
#'
#' @returns S3 object of class `rigma_get_component`.
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

  resp <- request_figma_endpoint(
    "component",
    key = key
    ) %>%
    figma_resp()

  structure(
    resp,
    class = "rigma_get_component"
  )
}

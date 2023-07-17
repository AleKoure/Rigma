#' GET file component sets
#'
#' @description Get a list of published component_sets within a file library.
#' Note that published components are only available via the professional
#' plan.
#'
#' @param file_key string. Id of the team to list components from.
#'
#' @returns S3 object of class `rigma_get_file_component_sets`. Components are
#' stored in the `meta` field.
#'
#' @importFrom checkmate assert_string
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to team page and get id from url
#' file_key <- "gYRjH0y8ZM0VtEfO8kf6ch"
#' get_file_component_sets(file_key)
#' }
#'
#' @export
get_file_component_sets <- function(file_key) {
  assert_file_key(file_key)

  resp <- request_figma() %>%
    req_figma_template(
      "file component set",
      file_key = file_key,
      .perform = TRUE
    )

  structure(
    list(
      error = resp %>% chuck("error"),
      status = resp %>% chuck("status"),
      meta = resp %>% chuck("meta"),
      i18n = resp %>% chuck("i18n")
    ),
    class = "rigma_get_file_component_sets"
  )
}

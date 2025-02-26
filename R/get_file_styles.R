#' GET file styles
#'
#' @description Get published styles in a file library by name.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @returns S3 object of class `rigma_get_file_styles`. Styles are
#' stored in the `meta` field.
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to team page and get id from url
#' file_key <- "gYRjH0y8ZM0VtEfO8kf6ch"
#' get_file_styles(file_key)
#' }
#'
#' @export
get_file_styles <- function(file_key) {
  assert_file_key(file_key)

  resp <- request_figma() %>%
    req_figma_template(
      "file styles",
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
    class = "rigma_get_file_styles"
  )
}

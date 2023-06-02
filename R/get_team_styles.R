#' GET team styles
#'
#' @description Get a list of published styles in a team library that is
#' paginated.
#'
#' @param team_id string. The team's ID, with a list of its styles.
#'
#' @param page_size number. Number of items in a paged list of results.
#' Defaults to 30.
#'
#' @param after number. Cursor providing the id for which to begin component
#' retrieval. Exclusive with `before` parameter. The cursor value is a
#' tracked integer that is kept internally but has no Ids.
#'
#' @param before number. The id before which to begin obtaining components is
#' shown by the cursor. Exclusive with after The cursor value is a tracked
#' integer that is kept internally but has no Ids.
#'
#' @returns S3 object of class `rigma_get_team_styles`. Styles are
#' stored in the `meta` field.
#'
#' @importFrom checkmate assert_string assert_number
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to team page and get id from url
#' get_team_styles(team_id = "1168610438838663284")
#' }
#'
#' @export
get_team_styles <- function(
    team_id,
    page_size = 30,
    after = NULL,
    before = NULL
) {
  assert_string(team_id)
  assert_number(page_size)
  assert_number(after, null.ok = TRUE)
  assert_number(before, null.ok = TRUE)

  resp <- request_figma_endpoint(
    endpoint = "team styles",
    team_id = team_id
  ) %>%
    req_figma_query(
      page_size = page_size,
      after = after,
      before = before
    )

  structure(
    list(
      error = resp %>% chuck("error"),
      status = resp %>% chuck("status"),
      meta = resp %>% chuck("meta"),
      i18n = resp %>% chuck("i18n")
    ),
    class = "rigma_get_team_styles"
  )
}

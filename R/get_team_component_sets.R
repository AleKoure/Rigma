#' GET team component sets
#'
#' @description Get a paginated list of published `component_sets` within a team
#' library. Note that published components are only available via the
#' professional plan.
#'
#' @param team_id string. The team's ID, with a list of its components.
#'
#' @param page_size number Number of items in a paged list of results.
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
#' @returns S3 object of class `rigma_get_team_component_sets`. Components are
#' stored in the `meta` field.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query
#'
#' @importFrom checkmate assert_string assert_number
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \donttest{
#' #navigate to team page and get id from url
#' get_team_component_sets(team_id = "1168610438838663284")
#' }
#'
#' @export
get_team_component_sets <- function(
    team_id,
    page_size = 30,
    after = NULL,
    before = NULL
) {
  assert_string(team_id)
  assert_number(page_size)
  assert_number(after, null.ok = TRUE)
  assert_number(before, null.ok = TRUE)

  params <- list(
    page_size = page_size,
    after = after,
    before = before
  )

  resp <- request("https://api.figma.com/v1/teams/") %>%
    req_url_path_append(team_id) %>%
    req_url_path_append("component_sets") %>%
    req_url_query(!!!params) %>%
    req_error(body = function(resp) {
      resp %>%
        resp_body_json() %>%
        chuck("message")
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
    class = "rigma_get_team_component_sets"
  )
}

#' GET team projects
#'
#' @description Get a list of all the Projects inside the specified team using
#' this Endpoint. Only projects visible to the authorized user or the holder
#' of the developer token will be returned. It should be noted that a user's
#' team ID cannot yet be determined from a token. Go to the
#' team page of the team you are a part of to get your team ID. After the term
#' "team" and before your team name, the team id will appear in the URL.
#'
#' @param team_id string. Id of the team to list projects from.
#'
#' @returns S3 object of class `rigma_get_team_projects`. Contains the parsed
#' JSON response with fields `name`, and `projects`.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query
#'
#' @importFrom checkmate assert_string
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to  file and get key from url
#' team_id <- "1168610438838663284"
#' get_team_projects(team_id)
#' }
#'
#' @export
get_team_projects <- function(team_id) {
  assert_string(team_id)

  resp <- request("https://api.figma.com/v1/teams/") %>%
    req_url_path_append(team_id) %>%
    req_url_path_append("projects") %>%
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
      name = resp %>% chuck("name"),
      projects = resp %>% chuck("projects")
    ),
    class = "rigma_get_team_projects"
  )
}

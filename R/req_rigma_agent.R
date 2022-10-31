#' Add metadata to Rigma request
#'
#' @description Extra metadata attached to httr2 request object before
#' performing the request.
#'
#' @param req httr2_request object
#' @param user_agent string with user agent
#'
#' @importFrom httr2 req_headers req_user_agent req_retry
#'
#' @importFrom checkmate assert_class assert_string
#'
#' @return httr2_request object with Figma token heater, user agent and retry
#' specifications.
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \donttest{
#' #navigate to  file and get key from url
#' project_id <- "71686204"
#' get_project_files(project_id)
#' resp <- request("https://api.figma.com/v1/projects/") %>%
#'   req_url_path_append(project_id) %>%
#'   req_url_path_append("files") %>%
#'   req_rigma_agent()
#' }
#'
req_rigma_agent <- function(
    req,
    user_agent = "Rigma https://github.com/AleKoure/Rigma"
) {
  assert_class(req, "httr2_request")
  figma_token <- Sys.getenv("FIGMA_ACCESS_TOKEN")
  assert_string(figma_token, min.chars = 1)

  req %>%
    req_headers(`X-Figma-Token` = figma_token) %>%
    req_user_agent(user_agent) %>%
    req_retry(
      is_transient = ~ resp_status(.x) %in% c(429, 500),
      backoff = ~ 20,
      max_tries = 3
    )
}

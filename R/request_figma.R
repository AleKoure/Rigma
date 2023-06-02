#' Create a request for a specified Figma API Endpoint
#'
#' @rdname request_figma_endpoint
#' @inheritParams httr2::request
#' @inheritParams httr2::req_method
#' @inheritParams figma_template
#' @inheritParams req_rigma_agent
#' @inheritDotParams httr2::req_template
#' @keywords internal
#' @importFrom httr2 request req_template req_error resp_body_json req_method
#' @importFrom rlang is_null
request_figma_endpoint <- function(endpoint,
                                   base_url = "https://api.figma.com",
                                   method = NULL,
                                   token = NULL,
                                   ...) {
  req <- httr2::request(base_url) %>%
    httr2::req_template(
      template = figma_template(endpoint),
      ...
    ) %>%
    httr2::req_error(
      body = function(resp) {
        body <- httr2::resp_body_json(resp)
        body[["message"]] %||% body[["err"]]
      }
    ) %>%
    req_rigma_agent(token = token)

  if (rlang::is_null(method)) {
    return(req)
  }

  req %>% httr2::req_method(method)
}

#' Set the API URL template based on the specified endpoint
#'
#' @param endpoint Figma REST API end point to use
#' @keywords internal
#' @inheritParams rlang::args_error_context
#' @importFrom rlang caller_env arg_match
figma_template <- function(endpoint = c("file", "file nodes", "images", "image fills", "versions", "users", "comments", "comment reactions", "projects", "project files", "team components", "file components", "component", "team component sets", "file component set", "component set", "team styles", "file styles", "style"),
                           call = rlang::caller_env()) {
  endpoint <- rlang::arg_match(endpoint, error_call = call)

  switch(endpoint,
    "file" = "/v1/files/{file_key}",
    "file nodes" = "/v1/files/{file_key}/nodes",
    "images" = "/v1/images/{file_key}",
    "image fills" = "/v1/files/{file_key}/images",
    "versions" = "/v1/files/{file_key}/versions",
    "users" = "/v1/me",
    "comments" = "/v1/files/{file_key}/comments",
    "comment reactions" = "/v1/files/{file_key}/comments/{comment_id}/reactions",
    "projects" = "/v1/teams/{team_id}/projects",
    "project files" = "/v1/projects/{project_id}/files",
    "team components" = "/v1/teams/{team_id}/components",
    "file components" = "/v1/files/{file_key}/components",
    "component" = "/v1/components/{key}",
    "team component sets" = "/v1/teams/{team_id}/component_sets",
    "file component set" = "/v1/files/{file_key}/component_sets",
    "component set" = "/v1/component_sets/{key}",
    "team styles" = "/v1/teams/{team_id}/styles",
    "file styles" = "/v1/files/{file_key}/styles",
    "style" = "/v1/styles/{key}"
  )
}

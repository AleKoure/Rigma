#' Set the API URL template based on the specified endpoint
#'
#' Modify a request using a template for a specified Figma API endpoint.
#'
#' @param endpoint Figma REST API endpoint to use
#' @inheritParams httr2::req_template
#' @inheritParams rlang::args_error_context
#' @keywords internal
#' @importFrom rlang arg_match
#' @importFrom httr2 req_template
req_figma_template <- function(.req,
                               endpoint = c(
                                 "file", "file nodes", "images",
                                 "image fills", "versions", "users",
                                 "comments", "comment reactions",
                                 "projects", "project files",
                                 "team components", "file components",
                                 "component", "team component sets",
                                 "file component set", "component set",
                                 "team styles", "file styles", "style"
                               ),
                               .perform = FALSE,
                               ...,
                               call = caller_env()) {
  endpoint <- arg_match(endpoint, error_call = call)

  template <- switch(endpoint,
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

  .req <- req_template(.req, template = template, ...)

  if (.perform) {
    return(req_figma_perform(.req, call = call))
  }

  .req
}

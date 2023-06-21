#' GET project files
#'
#' @description List the files in a given project.
#'
#' @param project_id string. Id of the project to list files from.
#'
#' @param branch_data string. Returns branch metadata in the response for each
#' main file with a branch inside the project. Default: "false"
#'
#' @returns S3 object of class `rigma_get_project_files`. Contains the parsed
#' JSON response with fields `name`, and `files`.
#'
#' @importFrom httr2 req_error
#'
#' @importFrom checkmate assert_string assert_logical assert_subset
#'
#' @importFrom xml2 xml_find_all xml_text
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to  file and get key from url
#' project_id <- "71686204"
#' get_project_files(project_id)
#' }
#'
#' @export
#' @importFrom httr2 resp_body_html
#' @importFrom xml2 xml_find_all xml_text
get_project_files <- function(project_id, branch_data = FALSE) {
  if (is_figma_url(project_id)) {
    project_id <- parse_url_project_id(project_id)
  }

  assert_string(project_id)

  resp <- request_figma_endpoint(
    "project files",
    project_id = project_id
    ) %>%
    req_error(body = function(resp) {
      resp %>%
        resp_body_html() %>%
        xml_find_all("//body/pre") %>%
        xml_text()
    }) %>%
    req_figma_query(
      branch_data = branch_data
    )

  structure(
    list(
      name = resp %>% chuck("name"),
      files = resp %>% chuck("files")
    ),
    class = "rigma_get_project_files"
  )
}

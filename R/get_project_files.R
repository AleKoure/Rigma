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
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query resp_body_html
#'
#' @importFrom checkmate assert_string assert_logical assert_subset
#'
#' @importFrom xml2 xml_find_all xml_text
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \donttest{
#' #navigate to  file and get key from url
#' project_id <- "71686204"
#' get_project_files(project_id)
#' }
#'
#' @export
get_project_files <- function(project_id, branch_data = "false") {
  assert_string(project_id)
  assert_subset(branch_data, c("false", "true"))

  params <- list(
    branch_data = branch_data
  )

  resp <- request("https://api.figma.com/v1/projects/") %>%
    req_url_path_append(project_id) %>%
    req_url_path_append("files") %>%
    req_url_query(!!!params) %>%
    req_error(body = function(resp) {
      resp %>%
        resp_body_html() %>%
        xml2::xml_find_all("//body/pre") %>%
        xml2::xml_text()
    }) %>%
    req_rigma_agent %>%
    req_perform() %>%
    resp_body_json()

  structure(
    list(
      name = resp %>% chuck("name"),
      files = resp %>% chuck("files")
    ),
    class = "rigma_get_project_files"
  )
}

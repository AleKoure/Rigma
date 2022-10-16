#' @description  Returns a JSON object containing the nodes referenced by
#' `:ids`. The Figma file referred to by `:key` is where the nodes are located.
#' The node Id and file key can be parsed from any Figma node url:
#' https://www.figma.com/file/:key/:title?node-id=:id.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @param ids string. list the document's nodes that are important to you,
#' separated by commas. If supplied, only the nodes listed, their children,
#' and everything between the root node and the listed nodes will be returned
#' as part of the document.
#'
#' @param version string. A certain version ID to obtain. By omitting this,
#' you'll obtain the file's most recent version.
#'
#' @param depth integer. A positive number indicating the depth of the
#' traversal across the document tree. For instance, changing this to 2
#' returns both Pages and all top level objects on each page instead of just
#' returning Pages. All nodes are returned if this argument is not set.
#'
#' @param geometry string. To export vector data, set equal to "paths".
#'
#' @param plugin_data string. A list of plugin IDs separated by commas or the
#' word "shared." The result's 'pluginData' and'sharedPluginData' attributes
#' will contain any data existing in the document created by those plugins.
#'
#' @returns S3 object of the type `rigma_get_file_nodes`.
#'
#' The supplied file's metadata includes the `name`, `lastModified`,
#' `thumbnailUrl`, `editorType`, and `version` attributes.
#'
#' The file link share permission level is described in the `linkAccess` field.
#' A shared link may have one of five different permissions: "inherit," "view,"
#' "edit," "org view," and "org edit." The default permission for files
#' produced in a team project is "inherit," and those files will take on the
#' project's rights by default. "org view" and "org edit" only allow org users
#' to access the link.
#'
#' Each node has the ability to inherit properties from applicable styles. A
#' mapping from style IDs to style metadata is contained in the `styles` key.
#'
#' It's important to note that the nodes field is a list that can include null
#' values. This can be because the provided file does not contain a node with
#' the specified id.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query
#'
#' @importFrom checkmate assert_string assert_integer
#'
#' @importFrom lubridate as_datetime
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \donttest{
#' #navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' get_file_nodes(file_key, ids = "0:0")
#' }
#'
#' @export
get_file_nodes <- function(
    file_key,
    ids = NULL,
    version = NULL,
    depth = NULL,
    geometry = NULL,
    plugin_data = NULL
) {
  assert_string(file_key)
  assert_string(version, null.ok = TRUE)
  assert_string(ids, null.ok = TRUE)
  assert_integer(depth, null.ok = TRUE)
  assert_string(geometry, null.ok = TRUE)
  assert_string(plugin_data, null.ok = TRUE)

  params <- list(
    file_key = file_key,
    version = version,
    ids = ids,
    depth = depth,
    geometry = geometry,
    plugin_data = plugin_data
  )

  request("https://api.figma.com/v1/files") %>%
    req_url_path_append(file_key) %>%
    req_url_path_append("nodes") %>%
    req_headers(`X-Figma-Token` = Sys.getenv("FIGMA_ACCESS_TOKEN")) %>%
    req_url_query(!!!params) %>%
    req_user_agent("Rigma (http://my.rigma)") %>%
    req_error(body = function(resp) {
      resp %>%
        resp_body_json() %>%
        chuck("err")
    }) %>%
    req_perform() %>%
    resp_body_json()

  structure(
    list(
      nodes = resp %>% chuck("nodes"),
      metadata = list(
        name = resp %>% chuck("name"),
        lastModified = resp %>%
          chuck("lastModified") %>%
          as_datetime(),
        thumbnailUrl = resp %>% chuck("thumbnailUrl"),
        version = resp %>% chuck("version"),
        role = resp %>% chuck("role"),
        editorType = resp %>% chuck("editorType"),
        linkAccess = resp %>% chuck("linkAccess")
      )
    ),
    class = "rigma_get_file_nodes"
  )
}

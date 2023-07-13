#' GET file
#'
#' @description Direct access to the desired  file is made available using
#' the GET file API endpoint. It returns a JSON object representing the file
#' pointed to by:key. Any Figma file url, such as
#' https://www.figma.com/file/:key/:title, can be used to parse the file key.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @param version string. A certain version ID to obtain. By omitting this,
#' you'll obtain the file's most recent version.
#'
#' @param ids string. list the document's nodes that are important to you,
#' separated by commas. If supplied, only the nodes listed, their children,
#' and everything between the root node and the listed nodes will be returned
#' as part of the document.
#'
#' @param depth integer. A positive number indicating the depth of the
#' traversal across the document tree. For instance, changing this to 2
#' returns both Pages and all top level objects on each page instead of just
#' returning Pages. All nodes are returned if this argument is not set.
#'
#' @param geometry string. To export vector data, set equal to "paths".
#'
#' @param plugin_data string. A list of plugin IDs separated by commas or the
#' word "shared." The result's 'pluginData' and 'sharedPluginData' attributes
#' will contain any data existing in the document created by those plugins.
#'
#' @param branch_data boolean. The requested file's branch metadata is returned.
#' If the file is a branch, the returned response will also provide the key for
#' the main file. If the file has branches, the response will also contain the
#' metadata for those branches. Standard: false.
#'
#' @importFrom checkmate assert_string assert_integer assert_logical
#' expect_number
#'
#' @importFrom lubridate as_datetime
#'
#' @returns S3 object of class `figma_file_resp`. Contains the parsed content,
#' the path, and the API response compatible with `httr2` methods. The
#' retrieved file's metadata includes the `name`, `lastModified`,
#' `thumbnailUrl`, `editorType`, `linkAccess`, and `version attributes`. A Node
#' with the DOCUMENT type is present in the document attribute.
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' get_file(file_key)
#' }
#'
#' @export
get_file <- function(
    file_key,
    version = NULL,
    ids = NULL,
    depth = NULL,
    geometry = NULL,
    plugin_data = NULL,
    branch_data = NULL
) {
  file_key <- set_file_key(file_key)
  assert_string(version, null.ok = TRUE)
  assert_string(ids, null.ok = TRUE)
  assert_integer(depth, null.ok = TRUE)
  assert_string(geometry, null.ok = TRUE)
  assert_string(plugin_data, null.ok = TRUE)
  assert_logical(branch_data, null.ok = TRUE)

  resp <- request_figma() %>%
    req_figma_template(
      "file",
      file_key = file_key
    ) %>%
    req_figma_query(
      version = version,
      ids = ids,
      depth = depth,
      geometry = geometry,
      plugin_data = plugin_data,
      branch_data = branch_data
    )

  structure(
    list(
      document = resp %>% chuck("document"),
      components = resp %>% chuck("components"),
      componentSets = resp %>% chuck("componentSets"),
      styles = resp %>% chuck("styles"),
      metadata = list(
        schemaVersion = resp %>% chuck("schemaVersion"),
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
    class = "rigma_get_file"
  )
}

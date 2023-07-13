#' GET file nodes
#'
#' @description  Returns a JSON object containing the nodes referenced by
#' `:ids`. The Figma file referred to by `:key` is where the nodes are located.
#' The node Id and file key can be parsed from any Figma node url:
#' https://www.figma.com/file/:key/:title?node-id=:id.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @param ids character. Vector with the document's node ids that are important
#' to you. If supplied, only the nodes listed, their children,
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
#' word "shared." The result's 'pluginData' and 'sharedPluginData' attributes
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
#' @importFrom checkmate assert_string assert_integer assert_character
#'
#' @importFrom lubridate as_datetime
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
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

  if (is_url(file_key)) {
    parsed_key <- parse_figma_url(file_key)
    file_key <- parsed_key[["file_key"]]
    ids <- ids %||% parsed_key[["node_id"]]
  } else {
    file_key <- set_file_key(file_key)
  }

  assert_string(version, null.ok = TRUE)
  assert_character(ids, null.ok = TRUE)
  assert_integer(depth, null.ok = TRUE)
  assert_string(geometry, null.ok = TRUE)
  assert_string(plugin_data, null.ok = TRUE)

  if (!is.null(ids)) ids <- paste0(ids, collapse = ",")

  resp <- request_figma() %>%
    req_figma_template(
      "file nodes",
      file_key = file_key
    ) %>%
    req_figma_query(
      version = version,
      ids = ids,
      depth = depth,
      geometry = geometry,
      plugin_data = plugin_data
    )

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

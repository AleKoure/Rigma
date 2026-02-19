# GET file

Direct access to the desired file is made available using the GET file
API endpoint. It returns a JSON object representing the file pointed to
by:key. Any Figma file url, such as
https://www.figma.com/file/:key/:title, can be used to parse the file
key.

## Usage

``` r
get_file(
  file_key,
  version = NULL,
  ids = NULL,
  depth = NULL,
  geometry = NULL,
  plugin_data = NULL,
  branch_data = NULL
)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

- version:

  string. A certain version ID to obtain. By omitting this, you'll
  obtain the file's most recent version.

- ids:

  string. list the document's nodes that are important to you, separated
  by commas. If supplied, only the nodes listed, their children, and
  everything between the root node and the listed nodes will be returned
  as part of the document.

- depth:

  integer. A positive number indicating the depth of the traversal
  across the document tree. For instance, changing this to 2 returns
  both Pages and all top level objects on each page instead of just
  returning Pages. All nodes are returned if this argument is not set.

- geometry:

  string. To export vector data, set equal to "paths".

- plugin_data:

  string. A list of plugin IDs separated by commas or the word "shared."
  The result's 'pluginData' and 'sharedPluginData' attributes will
  contain any data existing in the document created by those plugins.

- branch_data:

  boolean. The requested file's branch metadata is returned. If the file
  is a branch, the returned response will also provide the key for the
  main file. If the file has branches, the response will also contain
  the metadata for those branches. Standard: false.

## Value

S3 object of class `figma_file_resp`. Contains the parsed content, the
path, and the API response compatible with `httr2` methods. The
retrieved file's metadata includes the `name`, `lastModified`,
`thumbnailUrl`, `editorType`, `linkAccess`, and `version attributes`. A
Node with the DOCUMENT type is present in the document attribute.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to  file and get key from url
file_key <- "sFHgQh9dL6369o5wrZHmdR"
get_file(file_key)
} # }
}
```

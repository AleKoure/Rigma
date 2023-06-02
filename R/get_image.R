#' GET image
#'
#' @description If there are no errors, "images" will be filled with a list of
#' node IDs and their corresponding URLs for the displayed images, and "status"
#' will be left empty. After 30 days, the picture assets will stop working.
#'
#' It's important to note that the picture map could include null values. This
#' suggests that the node's attempt to render has failed. The lack of a node
#' id or other factors, such as the absence of renderable components, may be
#' responsible. Whether or not the render was successful, it is assured that
#' any node that was requested for rendering will be represented in this map.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @param ids string. A comma separated list of node IDs to render
#'
#' @param scale numeric. The image scaling factor is a number between 0.01 and
#' 4
#'
#' @param format string. A string enum for the image output format, can be
#' "jpg", "png", "svg", or "pdf"
#'
#' @param svg_include_id logical. Whether or not to give each SVG element an
#' id attribute. Standard: `FALSE`
#'
#' @param svg_simplify_stroke logical. Whether to simplify inside/outside
#' strokes and use stroke attribute if possible instead of <mask>.
#' Default:  `TRUE`.
#'
#' @param use_absolute_bounds logical. Whether the node is cropped or the area
#' around it is vacant, use the node's full dimensions. To export text nodes
#' without cropping, use this method. Standard: false.
#'
#' @param version string. A specific version ID to use. Omitting this will use
#' the current version of the file
#'
#' @returns S3 object of class `rigma_get_image`. Contains the parsed
#' JSON response with fields `err`, and `images`.
#'
#' @importFrom  checkmate assert_string assert_integer assert_logical
#' assert_numeric
#'
#' @importFrom purrr chuck
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \dontrun{
#' #navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' get_image(file_key, ids = "0:1", format = "svg")
#' }
#'
#' @export
get_image <- function(
  file_key,
  ids = NULL,
  scale = NULL,
  format = NULL,
  svg_include_id = NULL,
  svg_simplify_stroke = NULL,
  use_absolute_bounds = NULL,
  version = NULL
) {
  file_key <- set_file_key(file_key)
  assert_string(ids)
  assert_numeric(scale, null.ok = TRUE)
  assert_string(format, null.ok = TRUE)
  assert_logical(svg_include_id, null.ok = TRUE)
  assert_logical(svg_simplify_stroke, null.ok = TRUE)
  assert_logical(use_absolute_bounds, null.ok = TRUE)
  assert_string(version, null.ok = TRUE)

  resp <-
    request_figma_endpoint(
      "images",
      file_key = file_key
      ) %>%
    req_figma_query(
      ids = ids,
      scale = scale,
      format = format,
      svg_include_id = svg_include_id,
      svg_simplify_stroke = svg_simplify_stroke,
      use_absolute_bounds = use_absolute_bounds,
      version = version
    )

  structure(
    list(
      err = resp %>% chuck("err"),
      images = resp %>% chuck("images")
    ),
    class = "rigma_get_image"
  )
}

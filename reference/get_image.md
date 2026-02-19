# GET image

If there are no errors, "images" will be filled with a list of node IDs
and their corresponding URLs for the displayed images, and "status" will
be left empty. After 30 days, the picture assets will stop working.

It's important to note that the picture map could include null values.
This suggests that the node's attempt to render has failed. The lack of
a node id or other factors, such as the absence of renderable
components, may be responsible. Whether or not the render was
successful, it is assured that any node that was requested for rendering
will be represented in this map.

## Usage

``` r
get_image(
  file_key,
  ids,
  scale = NULL,
  format = NULL,
  svg_include_id = NULL,
  svg_simplify_stroke = NULL,
  use_absolute_bounds = NULL,
  version = NULL
)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

- ids:

  string. A comma separated list of node IDs to render

- scale:

  numeric. The image scaling factor is a number between 0.01 and 4

- format:

  string. A string enum for the image output format, can be "jpg",
  "png", "svg", or "pdf"

- svg_include_id:

  logical. Whether or not to give each SVG element an id attribute.
  Standard: `FALSE`

- svg_simplify_stroke:

  logical. Whether to simplify inside/outside strokes and use stroke
  attribute if possible instead of mask element. Default: `TRUE`.

- use_absolute_bounds:

  logical. Whether the node is cropped or the area around it is vacant,
  use the node's full dimensions. To export text nodes without cropping,
  use this method. Standard: false.

- version:

  string. A specific version ID to use. Omitting this will use the
  current version of the file

## Value

S3 object of class `rigma_get_image`. Contains the parsed JSON response
with fields `err`, and `images`.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to  file and get key from url
file_key <- "sFHgQh9dL6369o5wrZHmdR"
get_image(file_key, ids = "0:1", format = "svg")
} # }
}
```

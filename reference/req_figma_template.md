# Set the API URL template based on the specified endpoint

Modify a request using a template for a specified Figma API endpoint.

## Usage

``` r
req_figma_template(
  .req,
  endpoint = c("file", "file nodes", "images", "image fills", "versions", "users",
    "comments", "comment reactions", "comment delete", "projects", "project files",
    "team components", "file components", "component", "team component sets",
    "file component set", "component set", "team styles", "file styles", "style"),
  .perform = FALSE,
  ...,
  call = caller_env()
)
```

## Arguments

- .req:

  A [request](https://httr2.r-lib.org/reference/request.html).

- endpoint:

  Figma REST API endpoint to use

- ...:

  Template variables.

- call:

  The execution environment of a currently running function, e.g.
  `caller_env()`. The function will be mentioned in error messages as
  the source of the error. See the `call` argument of
  [`abort()`](https://rlang.r-lib.org/reference/abort.html) for more
  information.

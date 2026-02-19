# Transform data to tabular format

Transforms data returned from a Figma API request to tabular format.

## Usage

``` r
as_design_tibble(rigma_resp, message = TRUE)
```

## Arguments

- rigma_resp:

  A response object from Figma API.

- message:

  logical. Control printing of messages.

## Value

tibble data extracted from Figma response objects. Subclasses of type
`design_tibble` are added to the resulting tibbles.

## Examples

``` r
if (FALSE) { # \dontrun{
file_key <- "sFHgQh9dL6369o5wrZHmdR"
resp <- get_file_styles(file_key = file_key)
as_design_tibble(resp)
} # }
```

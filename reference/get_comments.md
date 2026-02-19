# GET comments

Gets a list of comments left on the file.

## Usage

``` r
get_comments(file_key)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

## Value

S3 object of class `rigma_get_comments`. Contains the parsed JSON
response.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to  file and get key from url
file_key <- "sFHgQh9dL6369o5wrZHmdR"
get_comments(file_key)
} # }
}
```

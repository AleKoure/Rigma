# GET file versions

A list of the versions of a file.

## Usage

``` r
get_file_versions(file_key)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

## Value

S3 object of class `rigma_get_file_versions`. Contains the parsed JSON
response with fields `versions`, and `pagination`.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to  file and get key from url
file_key <- "sFHgQh9dL6369o5wrZHmdR"
get_file_versions(file_key)
} # }
}
```

# GET file styles

Get published styles in a file library by name.

## Usage

``` r
get_file_styles(file_key)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

## Value

S3 object of class `rigma_get_file_styles`. Styles are stored in the
`meta` field.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to team page and get id from url
file_key <- "gYRjH0y8ZM0VtEfO8kf6ch"
get_file_styles(file_key)
} # }
}
```

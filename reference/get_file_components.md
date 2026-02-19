# GET file components

Get a list of published components within a file library. Note that
published components are only available via the professional plan.

## Usage

``` r
get_file_components(file_key)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

## Value

S3 object of class `rigma_get_file_components`. Components are stored in
the `meta` field.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to team page and get id from url
file_key <- "gYRjH0y8ZM0VtEfO8kf6ch"
get_file_components(file_key)
} # }
}
```

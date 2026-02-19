# GET file component sets

Get a list of published component_sets within a file library. Note that
published components are only available via the professional plan.

## Usage

``` r
get_file_component_sets(file_key)
```

## Arguments

- file_key:

  string. Id of the team to list components from.

## Value

S3 object of class `rigma_get_file_component_sets`. Components are
stored in the `meta` field.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to team page and get id from url
file_key <- "gYRjH0y8ZM0VtEfO8kf6ch"
get_file_component_sets(file_key)
} # }
}
```

# GET comments reactions

Obtains a paginated list of the comments' reactions.

## Usage

``` r
get_comments_reactions(file_key, comment_id, cursor = NULL)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

- comment_id:

  string. The comment id.

- cursor:

  string obtained from the result of the previous request, a cursor for
  pagination.

## Value

S3 object of class `rigma_get_comments_reactions`. Contains the parsed
JSON response with fields `reactions`, and `pagination`.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to  file and get key from url
file_key <- "sFHgQh9dL6369o5wrZHmdR"
resp <- get_comments(file_key)
resp_reactions <- get_comments_reactions(file_key, resp$comments[[1]]$id)
} # }
}
```

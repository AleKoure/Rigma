# DELETE comments

Deletes a specific comment. Only the person who made the comment is
allowed to delete it.

## Usage

``` r
delete_comment(file_key, comment_id)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

- comment_id:

  string. The comment id.

## Value

S3 object of class `rigma_delete_comment`. Contains the parsed JSON
response with fields `error`, `status`, and `i18n`.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
# navigate to  file and get key from url
file_key <- "sFHgQh9dL6369o5wrZHmdR"
first_comment_id <- get_comments(file_key)$comments[[1]]$id
delete_comment(file_key, first_comment_id)
} # }
}
```

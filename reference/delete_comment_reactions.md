# DELETE comment reactions

Removes a particular comment reaction. The only person with the ability
to delete a comment reaction is the original poster.

## Usage

``` r
delete_comment_reactions(file_key, comment_id, emoji)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

- comment_id:

  string. Comment id of comment to delete reaction from.

- emoji:

  string. The emoji type of reaction to delete as a string enum :eyes:,
  :heart_eyes:, :heavy_plus_sign:, :+1:, :-1:, :joy: and :fire:

## Value

S3 object of class `rigma_delete_comment_reactions`. Contains the parsed
JSON response with fields `error`, `status`, and `i18n`.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
# navigate to  file and get key from url
file_key <- "sFHgQh9dL6369o5wrZHmdR"
first_comment_id <- get_comments(file_key)$comments[[1]]$id
delete_comment_reactions(file_key, first_comment_id, ":eyes:")
} # }
}
```

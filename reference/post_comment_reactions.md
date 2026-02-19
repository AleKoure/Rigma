# POST comment reactions

Posts a new comment reaction on a file comment.

## Usage

``` r
post_comment_reactions(file_key, comment_id, emoji)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

- comment_id:

  string. If there is one, the comment to respond to. You cannot reply
  to a remark that is a reply to itself (a reply has a parent id), thus
  this must be a root comment.

- emoji:

  string. The emoji type of reaction as a string enum :eyes:,
  :heart_eyes:, :heavy_plus_sign:, :+1:, :-1:, :joy: and :fire:

## Value

S3 object of class `rigma_post_comment_reactions`. Contains the parsed
JSON response with fields `error`, `status`, and `i18n`.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to  file and get key from url
file_key <- "sFHgQh9dL6369o5wrZHmdR"
first_comment_id <- get_comments(file_key)$comments[[1]]$id
post_comment_reactions(file_key, first_comment_id, ":eyes:")
} # }
}
```

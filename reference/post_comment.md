# POST comment

Posts a new comment on the file.

## Usage

``` r
post_comment(file_key, message, comment_id = NULL, client_meta)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

- message:

  string. The comment's textual content to post.

- comment_id:

  string. If there is one, the comment to respond to. You cannot reply
  to a remark that is a reply to itself (a reply has a parent id), thus
  this must be a root comment.

- client_meta:

  string. The position of where to place the comment.

## Value

S3 object of class `rigma_post_comment`. Contains the parsed JSON
response with fields `id`, `file_key`, `status`, `i18n`, `parent_id`,
`user`, `created_at`, `resolved_at`, `message`, `reactions`,
`client_meta`, and `order_id`.

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

# GET team styles

Get a list of published styles in a team library that is paginated.

## Usage

``` r
get_team_styles(team_id, page_size = 30, after = NULL, before = NULL)
```

## Arguments

- team_id:

  string. The team's ID, with a list of its styles.

- page_size:

  number. Number of items in a paged list of results. Defaults to 30.

- after:

  number. Cursor providing the id for which to begin component
  retrieval. Exclusive with `before` parameter. The cursor value is a
  tracked integer that is kept internally but has no Ids.

- before:

  number. The id before which to begin obtaining components is shown by
  the cursor. Exclusive with after The cursor value is a tracked integer
  that is kept internally but has no Ids.

## Value

S3 object of class `rigma_get_team_styles`. Styles are stored in the
`meta` field.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to team page and get id from url
get_team_styles(team_id = "1168610438838663284")
} # }
}
```

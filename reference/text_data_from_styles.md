# Get text data from styles

Get text data from styles

## Usage

``` r
text_data_from_styles(design_tibble)
```

## Arguments

- design_tibble:

  S3 object of class `design_tibble_style` returned by queering the
  'Figma' API for the published styles. Its design tibble should contain
  a unique `file_key` (map for each `file_key` if more than one exist.)

## Value

tibble with text metadata of exported TEXT styles

## Details

Given a design_tibble with exported styles this function retrieves all
TEXT style type metadata. It uses the GET file nodes API endpoint and
collects all style data.

## Examples

``` r
if (FALSE) { # \dontrun{
file_key <- "sFHgQh9dL6369o5wrZHmdR"
file_key %>%
 get_file_styles() %>%
 as_design_tibble() %>%
 text_data_from_styles()
} # }
```

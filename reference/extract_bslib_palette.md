# Extract bslib palette

Extract bslib palette

## Usage

``` r
extract_bslib_palette(design_tibble, version = 5)
```

## Arguments

- design_tibble:

  A design_tibble returned bu the [`add_color()`](add_color.md) function

- version:

  Bootstrap version to use for extracting color variables

## Value

List with colors used in high level variables of `bs_theme()`.

## Details

This function filters for bslib high level color variables published as
styles of a Figma file and/or team. The color should be extracted and
added as a variable to the retrieved data.

## Examples

``` r
if (FALSE) { # \dontrun{
file_key <- "sFHgQh9dL6369o5wrZHmdR"
file_key %>%
  get_file_styles() %>%
  as_design_tibble() %>%
  add_color() %>%
  extract_bslib_palette()
} # }
```

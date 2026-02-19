# Add color to design table data

Extracts color for design data collected from the Figma API. Can convert
to hex. Infered color data are added in a new column named as `color`.

## Usage

``` r
add_color(design_tibble, hex = TRUE)
```

## Arguments

- design_tibble:

  Tabular data to be augmented with color colomn.

- hex:

  logical. If `TRUE` hex data are added to `color` column else nested
  data for `RGBA` channels.

## Value

Adds color column to `design_tibble` data

## Examples

``` r
if (FALSE) { # \dontrun{
file_key <- "sFHgQh9dL6369o5wrZHmdR"
resp <- get_file_styles(file_key) %>%
  as_design_tibble() %>%
  add_color()
} # }
```

# Find thumbnail color

Find thumbnail color

## Usage

``` r
thumbnail_color(path, hex = TRUE)
```

## Arguments

- path:

  string. Path to the thumbnail PNG

- hex:

  logical. If `TRUE` then the RGBA values are converted to hex

## Value

The color of the thumbnail in hex or rgba

## Details

Given a mono-colored thumbnail this function extracts the RGBA channels
and returns a vector scaled from `[0, 1]` or a hex color code.

## Examples

``` r
path <- system.file("extdata", "test_thumbnail.png", package = "Rigma")
thumbnail_color(path)
#> [1] "#343A40FF"
```

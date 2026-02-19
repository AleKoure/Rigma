# Changelog

## Rigma 0.3.0

CRAN release: 2025-02-23

- Migrate documentation to Markdown formatting
  ([\#12](https://github.com/AleKoure/Rigma/issues/12)).

- Refactor to use internal wrapper function for
  [`httr2::req_template()`](https://httr2.r-lib.org/reference/req_template.html).

- Allow user to set name of environmental variable for token with
  `Rigma.figma_token` option.

## Rigma 0.2.1

CRAN release: 2022-11-27

### New methods

- [`add_color()`](../reference/add_color.md) that adds color column to a
  `design_tibble`

- [`as_design_tibble()`](../reference/as_design_tibble.md) Generic that
  converts Figma API responses to tabular format.

- [`extract_bslib_palette()`](../reference/extract_bslib_palette.md)
  Example function that extract bslib high level color variables.

- `text_data_from_style` Collects metadata for published text styles.

- [`thumbnail_color()`](../reference/thumbnail_color.md) Extracts color
  from a monochromatic PNG thumbnail.

### New vignette

Added example of how to stylize shiny apps using `bslib` variables and
published ‘Figma’ styles.

## Rigma 0.1.0

CRAN release: 2022-11-09

- Initial beta release!

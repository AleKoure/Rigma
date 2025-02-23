# Rigma 0.3.0

* Migrate documentation to Markdown formatting (#12).

* Refactor to use internal wrapper function for `httr2::req_template()`.

* Allow user to set name of environmental variable for token with `Rigma.figma_token` option.

# Rigma 0.2.1

## New methods

* `add_color()` that adds color column to a `design_tibble`

* `as_design_tibble()` Generic that converts Figma API responses to tabular
format.

* `extract_bslib_palette()` Example function that extract bslib high level color
variables.

* `text_data_from_style` Collects metadata for published text styles.

* `thumbnail_color()` Extracts color from a monochromatic PNG thumbnail.

## New vignette 

Added example of how to stylize shiny apps using `bslib` variables and published
'Figma' styles.

# Rigma 0.1.0

* Initial beta release!



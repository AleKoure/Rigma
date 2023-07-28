#' Add color to design table data
#'
#' @description Extracts color for design data collected from the Figma API.
#' Can convert to hex. Infered color data are added in a new column named
#' as `color`.
#'
#' @param design_tibble Tabular data to be augmented with color colomn.
#'
#' @param hex logical. If `TRUE` hex data are added to `color` column else
#' nested data for `RGBA` channels.
#'
#' @returns Adds color column to `design_tibble` data
#'
#' @importFrom checkmate assert_subset
#'
#' @importFrom withr with_tempdir
#'
#' @importFrom purrr pmap_dfr
#'
#' @importFrom glue glue
#'
#' @importFrom fs file_exists
#'
#' @importFrom dplyr group_nest left_join
#'
#' @importFrom rlang .data
#'
#' @examples
#' \dontrun{
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' resp <- get_file_styles(file_key) %>%
#'   as_design_tibble() %>%
#'   add_color()
#' }
#'
#' @export
add_color <- function(design_tibble, hex = TRUE) {
  UseMethod("add_color")
}

#'
#' @export
add_color.default <- function(design_tibble, hex = TRUE) {
  stop("Called default method. Don't know how to add color")
}

#'
#' @exportS3Method Rigma::add_color design_tibble_style
add_color.design_tibble_style <- function(design_tibble, hex = TRUE) {
  assert_subset(c("key", "thumbnail_url"), names(design_tibble))

  color_df <- with_tempdir({
    design_tibble <- design_tibble %>%
      pmap_dfr(function(key, thumbnail_url, ...) {
        png_path <- glue("{key}.png")
        safe_download(thumbnail_url, destfile = png_path)
        color <- possibly_thumbnail_color(png_path, hex)
        list(key = key, color = color)
      })
  })

  if (isFALSE(hex)) {
    color_df <- color_df %>%
      group_nest(.data$key, .key = 'color')
  }

  left_join(design_tibble, color_df, by = "key")
}

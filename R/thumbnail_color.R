#' Find thumbnail color
#'
#' @details Given a mono-colored thumbnail this function extracts the RGBA
#' channels and returns a vector scaled from [0, 1] or a hex color code.
#'
#' @param path string. Path to the thumbnail PNG
#' @param hex logical. If `TRUE` then the RGBA values are converted to hex
#'
#' @importFrom checkmate assert_file_exists assert_number
#'
#' @importFrom png readPNG
#'
#' @importFrom purrr imap set_names
#'
#' @importFrom rlang exec
#'
#' @importFrom grDevices rgb
#'
#' @return The color of the thumbnail in hex or rgba
#' @export
#'
#' @examples
#' path <- system.file("extdata", "test_thumbnail.png", package = "Rigma")
#' thumbnail_color(path)
#'
thumbnail_color <- function(path, hex = TRUE) {
  assert_file_exists(path)
  pngImage <- readPNG(path)
  result <- imap(c("r", "g", "b", "a"), ~ {
    res <- pngImage[, , .y] %>%
      as.vector() %>%
      unique()
    assert_number(
      res,
      lower = 0,
      upper = 1,
      .var.name = "monochromatic_chanel"
    )
    res
  }) %>%
    set_names("red", "green", "blue", "alpha")
  if (hex) result <- exec(rgb, !!!result)
  result
}

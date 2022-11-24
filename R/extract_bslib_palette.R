#' Extract bslib palette
#'
#' @details This function filters for bslib high level color variables published
#' as styles of a Figma file and/or team. The color should be extracted and
#' added as a variable to the retrieved data.
#'
#' @param design_tibble A design_tibble returned bu the `add_color()` function
#' @param version Bootstrap version to use for extracting color variables
#'
#' @return List with colors used in high level variables of `bs_theme()`.
#'
#' @importFrom rlang fn_fmls
#'
#' @importFrom bslib bs_theme
#'
#' @importFrom purrr imap flatten_chr pmap set_names
#'
#' @importFrom dplyr filter select
#'
#' @importFrom checkmate assert_true assert_class
#'
#' @importFrom rlang .data
#'
#' @export
#'
#' @examples
#' \dontrun{
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' file_key %>%
#'   get_file_styles() %>%
#'   as_design_tibble() %>%
#'   add_color() %>%
#'   extract_bslib_palette()
#' }
#'
extract_bslib_palette <- function(design_tibble, version = 5) {
  assert_class(design_tibble, "design_tibble_style")
  assert_true("color" %in% names(design_tibble))

  hl_bslib_colors <- fn_fmls(bs_theme) %>%
    imap(~ {
      if (.y %in% c("version", "bootswatch", "...") || grepl("font", .y))
        NULL
      else
        .y
  }) %>%
    flatten_chr()

  resp_hl_colors <- design_tibble %>%
    filter(.data$name %in% hl_bslib_colors) %>%
    select("name", "color")

  pmap(resp_hl_colors, ~ .y) %>%
    set_names(resp_hl_colors %>% pull("name")) %>%
    append(list(version = version))
}

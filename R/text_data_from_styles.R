#' Get text data from styles
#'
#' @details Given a design_tibble with exported styles this function retrieves
#' all TEXT style type metadata. It uses the GET file nodes API endpoint and
#' collects all style data.
#'
#' @param design_tibble S3 object of class `design_tibble_style` returned by
#' queering the 'Figma' API for the published styles. Its design tibble should
#' contain a unique `file_key` (map for each `file_key` if more than one
#' exist.)
#'
#' @returns tibble with text metadata of exported TEXT styles
#'
#' @importFrom checkmate assert_class assert_string
#'
#' @importFrom dplyr pull filter
#'
#' @importFrom purrr chuck imap list_rbind
#'
#' @importFrom rlang .data
#'
#' @examples
#' \dontrun{
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' file_key %>%
#'  get_file_styles() %>%
#'  as_design_tibble() %>%
#'  text_data_from_styles()
#' }
#'
#' @export
text_data_from_styles <- function(design_tibble) {
  assert_class(design_tibble, "design_tibble_style")
  file_key <- design_tibble %>%
    pull(.data$file_key) %>%
    unique()
  file_key <- set_file_key(file_key)
  design_tibble %>%
    filter(.data$style_type == "TEXT") %>%
    pull(.data$node_id) %>%
    get_file_nodes(file_key, .) %>%
    chuck("nodes") %>%
    imap(~ append(
      list(node_id = .y, name = .x$document$name),
      .x$document$style
    )) %>%
    list_rbind()
}

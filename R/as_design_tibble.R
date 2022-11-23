#' Transform data to tabular format
#'
#' @description Transforms data returned from a Figma API request to tabular
#' format.
#'
#' @param rigma_resp A response object from Figma API.
#'
#' @param message logical. Control printing of messages.
#'
#' @returns tibble data extracted from Figma response objects. Subclasses
#' of type `design_tibble` are added to the resulting tibbles.
#'
#' @importFrom dplyr as_tibble mutate
#'
#' @importFrom purrr chuck map_dfr list_modify
#'
#' @importFrom lubridate as_datetime
#'
#' @importFrom magrittr set_class
#'
#' @importFrom tibble new_tibble
#'
#' @importFrom tidyr nest
#'
#' @examples
#' \dontrun{
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' resp <- get_file_styles(file_key = file_key)
#' as_design_tibble(resp)
#' }
#'
#' @export
as_design_tibble <- function(rigma_resp, message = TRUE) {
  UseMethod("as_design_tibble")
}

#'
#' @export
as_design_tibble.default <- function(rigma_resp, message = TRUE) {
  if (isTRUE(message))
    message("Called default method. Trying to transform to tibble")
  as_tibble(rigma_resp) %>%
    new_tibble(class = "design_tibble")
}

#'
#' @exportS3Method Rigma::as_design_tibble rigma_get_file_styles
as_design_tibble.rigma_get_file_styles <- function(
  rigma_resp,
  message = TRUE
) {
  if (isTRUE(message)) message("Nesting user data")

  rigma_resp %>%
    chuck("meta", "styles") %>%
    map_dfr(~{.x %>% as_tibble()}) %>%
    nest(user_data = user) %>%
    mutate(
      created_at = as_datetime(created_at),
      updated_at = as_datetime(updated_at)
    ) %>%
    new_tibble(class = "design_tibble_style")
}

#'
#' @exportS3Method Rigma::as_design_tibble rigma_get_team_styles
as_design_tibble.rigma_get_team_styles <- as_design_tibble.rigma_get_file_styles

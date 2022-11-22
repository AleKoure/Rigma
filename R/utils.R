#' Safe download files
#'
#' @importFrom purrr safely
#'
#' @importFrom utils download.file
#'
#' @returns download function that safely handles errors
safe_download <- safely(~ download.file(.x, .y, mode = "wb", quiet = TRUE))

#' Possibly extract thumbnail color
#'
#' @importFrom purrr possibly
#'
#' @returns thumbnail_color function that handles errors
possibly_thumbnail_color <- possibly(thumbnail_color, otherwise = NA)

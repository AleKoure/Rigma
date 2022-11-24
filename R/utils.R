#' Safe download files
#'
#' @importFrom purrr safely
#'
#' @importFrom utils download.file
#'
#' @param ... Variables passed to wrapped function
#'
#' @returns download function that safely handles errors
safe_download <- safely(~ download.file(.x, .y, mode = "wb", quiet = TRUE))

#' Possibly extract thumbnail color
#'
#' @importFrom purrr possibly
#'
#' @param ... Variables passed to wrapped function
#'
#' @returns thumbnail_color function that handles errors
possibly_thumbnail_color <- possibly(thumbnail_color, otherwise = NA)

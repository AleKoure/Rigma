#' Safe download files
#'
#' @importFrom purrr safely
#'
#' @importFrom utils download.file
#'
#' @returns download function that safely handles errors
safe_download <- safely(~ download.file(.x , .y, mode = "wb", quiet = TRUE))

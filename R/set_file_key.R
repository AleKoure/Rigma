#' Is x a likely Figma file key?
#'
#' @noRd
#' @importFrom rlang is_string
is_figma_file_key <- function(x) {
  is_string(x) && grepl("^[[:alnum:]]+$", x)
}

#' Return a file key or error if not provided
#'
#' @noRd
#' @importFrom rlang check_required is_string
#' @importFrom cli cli_abort
set_file_key <- function(file_key, call = caller_env()) {
  check_required(file_key, call = call)

  if (is_figma_file_key(file_key)) {
    return(file_key)
  }

  cli_abort(
    "{.arg file_key} must be a file key string.",
    call = call
  )
}

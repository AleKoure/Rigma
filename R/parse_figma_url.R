#' Parse a Figma URL for a file key and node ID
#'
#' @noRd
#' @importFrom cli cli_abort
parse_figma_url <- function(url, call = caller_env()) {
  if (!is_figma_url(url)) {
    cli_abort(
      "{.arg url} must be a valid Figma URL.",
      call = call
    )
  }

  list(
    "file_key" = parse_url_file_key(url),
    "node_id" = parse_url_node_id(url)
  )
}

#' Parse a file key from a Figma URL
#'
#' @noRd
parse_url_file_key <- function(url, base_url = "https://www.figma.com") {
  string_extract(
    url,
    glue("(?<={base_url}/file/)[[:alnum:]]+(?=/)")
  )
}

#' Parse a node ID from a Figma URL
#'
#' @noRd
parse_url_node_id <- function(url) {
  string_extract(
    url,
    "(?<=node-id\\=)([[:digit:]]|-)+"
  )
}

#' Parse a project ID from a Figma URL
#'
#' @noRd
parse_url_project_id <- function(url, base_url = "https://www.figma.com") {
  string_extract(
    url,
    glue("(?<={base_url}/files/project/)([[:digit:]]+)+")
  )
}

#' Is x a likely Figma file key?
#'
#' @noRd
#' @importFrom rlang is_string
is_figma_file_key <- function(x) {
  is_string(x) && grepl("^[[:alnum:]]+$", x)
}

#' Is x a Figma URL?
#'
#' @noRd
is_figma_url <- function(x, base_url = "https://www.figma.com") {
  if (is_null(x)) {
    return(FALSE)
  }

  is_url(x) && grepl(paste0("^", base_url), x)
}

#' Does x match the pattern of a URL?
#'
#' @noRd
is_url <- function(x) {
  if (is_null(x)) {
    return(FALSE)
  }

  grepl(
    "http[s]?://(?:[[:alnum:]]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+",
    x
  )
}

#' Extract pattern from a length 1 string
#'
#' @param string Passed to x parameter of `regmatches()`
#' @inheritParams base::regexpr
#' @noRd
#' @importFrom rlang is_null
string_extract <- function(string, pattern, perl = TRUE) {
  if (is.na(string)) {
    return(NA_character_)
  }

  match <-
    regmatches(
      x = string,
      m = regexpr(
        pattern = pattern,
        text = string,
        perl = perl
      )
    )

  if (is_empty(match)) {
    return(NULL)
  }

  match
}

#' Return a file key (optionally parsed from a URL) or error if not provided
#'
#' @noRd
#' @importFrom rlang check_required is_string
#' @importFrom cli cli_abort
set_file_key <- function(file_key, call = caller_env()) {
  check_required(file_key, call = call)

  if (is_figma_url(file_key)) {
    file_key <- parse_url_file_key(file_key)
  }

  if (is_figma_file_key(file_key)) {
    return(file_key)
  }

  cli_abort(
    "{.arg file_key} must be a file key string or a valid Figma URL
      starting with {.url https://www.figma.com}",
    call = call
  )
}

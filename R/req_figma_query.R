#' Add a query to a request, perform the request and return the JSON body response
#'
#' @noRd
#' @importFrom httr2 req_url_query
req_figma_query <- function(.req, ..., .perform = TRUE, call = caller_env()) {
  .req <- .req %>%
    req_url_query(...)

  if (.perform) {
    return(req_figma_perform(.req, call = call))
  }

  .req
}

#' Perform a request and return the JSON body response
#'
#' @noRd
#' @importFrom httr2 req_perform resp_body_json
req_figma_perform <- function(req, call = caller_env()) {
  req %>%
    req_perform(error_call = call) %>%
    resp_body_json()
}

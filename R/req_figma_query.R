#' Add a query to a request, perform the request and return the JSON body response
#'
#' @noRd
#' @importFrom httr2 req_url_query
req_figma_query <- function(.req, ..., call = caller_env()) {
  .req %>%
    httr2::req_url_query(...) %>%
    figma_resp(call = call)
}

#' Add a query to a request, perform the request and return the JSON body response
#'
#' @noRd
#' @importFrom httr2 req_perform resp_body_json
figma_resp <- function(req, call = caller_env()) {
  req %>%
    httr2::req_perform(error_call = call) %>%
    httr2::resp_body_json()
}

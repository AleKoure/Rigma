#' Create a request for the Figma API with an optional method
#'
#' Use [httr2::request()] to create a request with error handling an optionally
#' specified method.
#'
#' @rdname request_figma
#' @param base_url Base URL for request. Defaults to `"https://api.figma.com"`
#' @inheritParams httr2::req_method
#' @inheritParams req_rigma_agent
#' @keywords internal
#' @importFrom httr2 request req_error req_method
#' @importFrom rlang is_null
request_figma <- function(base_url = "https://api.figma.com",
                          method = NULL,
                          token = NULL) {
  req <- request(base_url) %>%
    req_error(
      body = function(resp) {
        body <- resp_body_json(resp)
        body[["message"]] %||% body[["err"]]
      }
    ) %>%
    req_rigma_agent(token = token)

  if (is_null(method)) {
    return(req)
  }

  req %>% req_method(method)
}

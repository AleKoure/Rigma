#' GET image fills
#'
#' @description This API endpoint provides download URLs for all of the images
#' that are present in a document's image fills. Figma represents any
#' user-supplied images using image fills. When you drag a picture into
#' Figma, it builds a rectangle with a single fill to represent it. The user
#' can then modify the attributes of the fill and change the rectangle as they
#' see fit.
#'
#' @param file_key string. The key that a Figma file is referred by.
#'
#' @returns This API provides a mapping from image references to download URLs
#' for the images. Image URLs have a 14-day maximum lifespan. Image references
#' are located in the output of the GET files endpoint under the `imageRef`
#' attribute in a Paint.
#'
#' @importFrom httr2 request req_url_path_append req_headers req_user_agent
#' req_perform resp_body_json req_url_query
#'
#' @importFrom checkmate assert_string assert_integer assert_logical expect_list
#'
#' @examplesIf Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
#' \donttest{
#' #navigate to  file and get key from url
#' file_key <- "sFHgQh9dL6369o5wrZHmdR"
#' get_image_fills(file_key)
#' }
#'
#' @export
get_image_fills <- function(file_key) {
  assert_string(file_key)

  resp <- request("https://api.figma.com/v1/files/") %>%
    req_url_path_append(file_key) %>%
    req_url_path_append("images") %>%
    req_error(body = function(resp) {
      resp %>%
        resp_body_json() %>%
        chuck("err")
    }) %>%
    req_rigma_agent %>%
    req_perform() %>%
    resp_body_json()

  structure(
    list(
      error = resp %>% chuck("error"),
      status = resp %>% chuck("status"),
      meta = resp %>% chuck("meta"),
      i18n = resp %>% chuck("i18n")
    ),
    class = "rigma_get_image_fills"
  )
}

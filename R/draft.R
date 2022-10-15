#
#
#
# oauth_end <-  httr::oauth_endpoint(NULL,
#                                    "https://aledat.eu/r413/",
#                                    access = "https://aledat.eu/r413/",
#                                    base_url = "https://www.figma.com/oauth",
#                                    scope = "file_read",
#                                    state = "123",
#                                    response_type = "code",
#                                    client_id = "QnDmVChVvvlORpA00YJpVC")
#
#
#   "https://www.figma.com/oauth?client_id=QnDmVChVvvlORpA00YJpVC&redirect_uri=https://aledat.eu/r413/&scope=file_read&state=123&response_type=code")
#
# res <-  httr::content(resp, as = "text")
#
# grep("code", res)
# resp$headers
# jsonlite::parse_json(resp$content)
# e1PIRwA83ji4ioTQREF5TNsGrqhFkT
#
# resp <- httr::POST(
#   url = "https://www.figma.com/api/oauth/token",
#   query = list(
#     client_id = "QnDmVChVvvlORpA00YJpVC",
#     client_secret = "e1PIRwA83ji4ioTQREF5TNsGrqhFkT",
#     redirect_uri = "https://aledat.eu/r413/",
#     code = "MiaAkZo7be2CEPaKx2viHfH89",
#     grant_type = "authorization_code"
#   )
# )
# httr::content(resp)
#
# httr::http_error(resp)
#
# result <- GET("https://api.figma.com/v1/files/x7J5GyCO1OKh1uVJmGTX3N",
#               add_headers(`X-Figma-Token` = "380239-b5a9b9ea-6751-4a56-854a-0e09d54a22ad"))
#
#
# get_content <- content(result)
#
#
# # # Rigma
# # R client to Figma API
# #
# # ## Initialising figma API
# #
# # For OAUTH authentication is the recommended method https://www.figma.com/developers/api#oauth2
# #
# # added site of aledat and got the secret: e1PIRwA83ji4ioTQREF5TNsGrqhFkT
# #
# # also got this : Client ID - QnDmVChVvvlORpA00YJpVC
# #
# #
# #
# # - Register an application via your Figma account.
# # - Authenticate any users.
# # - Use the OAuth 2 Token.
# # - Refresh an OAuth 2 Token.
# #

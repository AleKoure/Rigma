# Create a request for the Figma API with an optional method

Use [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
to create a request with error handling an optionally specified method.

## Usage

``` r
request_figma(base_url = "https://api.figma.com", method = NULL, token = NULL)
```

## Arguments

- base_url:

  Base URL for request. Defaults to `"https://api.figma.com"`

- method:

  Custom HTTP method

- token:

  Figma API access token. If `NULL`, replace with environment variable
  named "FIGMA_ACCESS_TOKEN" or an alternate name set using the variable
  "Rigma.figma_token".

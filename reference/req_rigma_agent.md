# Add metadata to Rigma request

Extra metadata attached to httr2 request object before performing the
request.

## Usage

``` r
req_rigma_agent(
  req,
  token = NULL,
  user_agent = "Rigma https://github.com/AleKoure/Rigma"
)
```

## Arguments

- req:

  httr2_request object

- token:

  Figma API access token. If `NULL`, replace with environment variable
  named "FIGMA_ACCESS_TOKEN" or an alternate name set using the variable
  "Rigma.figma_token".

- user_agent:

  string with user agent. Defaults to "Rigma
  https://github.com/AleKoure/Rigma"

## Value

httr2_request object with Figma token heater, user agent and retry
specifications.

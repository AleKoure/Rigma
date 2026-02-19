# GET team projects

Get a list of all the Projects inside the specified team using this
Endpoint. Only projects visible to the authorized user or the holder of
the developer token will be returned. It should be noted that a user's
team ID cannot yet be determined from a token. Go to the team page of
the team you are a part of to get your team ID. After the term "team"
and before your team name, the team id will appear in the URL.

## Usage

``` r
get_team_projects(team_id)
```

## Arguments

- team_id:

  string. Id of the team to list projects from.

## Value

S3 object of class `rigma_get_team_projects`. Contains the parsed JSON
response with fields `name`, and `projects`.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to  file and get key from url
team_id <- "1168610438838663284"
get_team_projects(team_id)
} # }
}
```

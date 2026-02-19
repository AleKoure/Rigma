# GET project files

List the files in a given project.

## Usage

``` r
get_project_files(project_id, branch_data = FALSE)
```

## Arguments

- project_id:

  string. Id of the project to list files from.

- branch_data:

  string. Returns branch metadata in the response for each main file
  with a branch inside the project. Default: "false"

## Value

S3 object of class `rigma_get_project_files`. Contains the parsed JSON
response with fields `name`, and `files`.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to  file and get key from url
project_id <- "71686204"
get_project_files(project_id)
} # }
}
```

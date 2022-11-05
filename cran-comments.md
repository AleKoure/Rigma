## Test environments

* Ubuntu Ubuntu 20.04.4 LTS (local), R 4.2.2
* Ubuntu Ubuntu 20.04.4 LTS (on Github Actions), R 4.2.2

## R CMD check results

0 errors | 0 warnings | 0 notes

* This is a new release.

## Resubmission

This is a resubmission. In this version I have:

* Omitted the "via R" at the end of the title.

* Added single quotes for package names, software names and API names in title and description.

* Used Authors@R field.

* Added web reference for the Figma API.

* Updated the .Rd files with exported functions missing \value and explained
the functions results.

* Added toy examples were is possible. For most cases, it is not feasible to 
unwrap the examples from \donttest{}. Most of the examples are wrapped in 
\donttest{} because all functions use Figma API that requires authentication.

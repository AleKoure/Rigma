# GET image fills

This API endpoint provides download URLs for all of the images that are
present in a document's image fills. Figma represents any user-supplied
images using image fills. When you drag a picture into Figma, it builds
a rectangle with a single fill to represent it. The user can then modify
the attributes of the fill and change the rectangle as they see fit.

## Usage

``` r
get_image_fills(file_key)
```

## Arguments

- file_key:

  string. The key that a Figma file is referred by.

## Value

This API provides a mapping from image references to download URLs for
the images. Image URLs have a 14-day maximum lifespan. Image references
are located in the output of the GET files endpoint under the `imageRef`
attribute in a Paint.

## Examples

``` r
if (FALSE) { # Sys.getenv("FIGMA_ACCESS_TOKEN") != ""
if (FALSE) { # \dontrun{
#navigate to  file and get key from url
file_key <- "sFHgQh9dL6369o5wrZHmdR"
get_image_fills(file_key)
} # }
}
```

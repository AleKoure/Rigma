% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/delete_comment.R
\name{delete_comment}
\alias{delete_comment}
\title{DELETE comments}
\usage{
delete_comment(file_key, comment_id)
}
\arguments{
\item{file_key}{string. The key that a Figma file is referred by.}

\item{comment_id}{string. The comment id.}
}
\value{
S3 object of class \code{rigma_delete_comment}. Contains the parsed
JSON response with fields \code{error}, \code{status}, and \code{i18n}.
}
\description{
Deletes a specific comment. Only the person who made the
comment is allowed to delete it.
}
\examples{
\dontshow{if (Sys.getenv("FIGMA_ACCESS_TOKEN") != "") (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
\dontrun{
# navigate to  file and get key from url
file_key <- "sFHgQh9dL6369o5wrZHmdR"
first_comment_id <- get_comments(file_key)$comments[[1]]$id
delete_comment(file_key, first_comment_id)
}
\dontshow{\}) # examplesIf}
}

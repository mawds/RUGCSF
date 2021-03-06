% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/findRscript.R
\name{findRscript}
\alias{findRscript}
\title{Returns list of R installation paths.}
\usage{
findRscript(path, executable = "(Rscript$|Rscript.exe)", pattern, version)
}
\arguments{
\item{path}{Character vector of search paths. Passed to \code{\link{list.files}}. If not specified (the default) then the search path contains typical installation paths for different operating systems.}

\item{executable}{Regular expression that defines the name of the Rscript executable. Defaults to a regular expression that finds \code{Rscript} on linux machines and \code{Rscript.exe} on Windows}

\item{pattern}{regular expression.  Passed to \code{\link{list.files}}}

\item{version}{Additional regular expression, e.g. "3.2.1" to limit the results list to a specific version of R}
}
\description{
Given a vector of search paths, returns all instances of R installations.
}
\details{
This function is a wrapper around \code{list.files} setting the search pattern to \code{Rscript.exe}.
}


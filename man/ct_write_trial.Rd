% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ct_write_trial.R
\name{ct_write_trial}
\alias{ct_write_trial}
\title{Save a the XML file of a study}
\usage{
ct_write_trial(NCT, path = ".", ...)
}
\arguments{
\item{NCT}{The NCT code of the desired study as a character,
e.g. "NCT03478891".}

\item{path}{The path to the directory in which the file should be saved.}

\item{...}{Additional arguments to be passed to `xml2::write_xml`.}
}
\value{
The study record as an XML file in the designed location.
}
\description{
Saves the study record as an XML in the specified path.
}
\examples{
\dontrun{
# Get the XML of study NCT03478891
xml_document <- get_xml_document("NCT03478891")
# Save the XML
tmp <- tempfile()  # only required for this example, not in using the library
write_xml_document(xml_document, tmp)
}
}

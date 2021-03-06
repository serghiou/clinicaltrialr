% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ct_read_trial_from_xml.R
\name{ct_read_trial_from_xml}
\alias{ct_read_trial_from_xml}
\title{Read commonly used information from ClinicalTrials.gov}
\usage{
ct_read_trial_from_xml(xml_doc)
}
\arguments{
\item{xml_doc}{A trial from ClinincalTrials.gov as an xml_document.}
}
\value{
If the selected format is "csv", a dataframe with the commonly used
    fields; if a field was not found within the file, then this field will be
    empty, i.e. `character()`. If the selected format is "xml", then it
    returns the trial in xml_document format.
}
\description{
Returns the commonly used information from ClinicalTrials.gov.
}
\examples{
\dontrun{
# Get the XML of study NCT03478891
xml_document <- ct_read_trial("NCT03478891", format = "xml")
# Extract fields of interest
study <- ct_read_trial_from_xml(xml_document)
}
}

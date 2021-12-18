#' Read commonly used information from ClinicalTrials.gov
#'
#' Returns the commonly used information from ClinicalTrials.gov.
#'
#' @param NCT The NCT code of a study as a character, e.g. "NCT03478891".
#' @param export_format The format of the output as a string. Either "csv" or "xml".
#' @return If the selected format is "csv", a dataframe with the commonly used
#'     fields; if a field was not found within the file, then this field will be
#'     empty, i.e. `character()`. If the selected format is "xml", then it
#'     returns the trial in xml_document format.
#' @examples
#' \dontrun{
#' # Get the XML of study NCT03478891
#' xml_document <- ct_read_trial("NCT03478891", export_format = "xml")
#' # Extract fields of interest
#' study <- ct_read_trial("NCT03478891", export_format = "csv")
#' }
#' @export
ct_read_trial <- function(NCT, export_format = "csv") {

  # Validate the chosen export format
  if (!export_format %in% c("csv", "xml")) {
    return(message("Please use an accepted format: 'csv' or 'xml'."))
  }

  # Extract XML
  URL <- paste0("https://clinicaltrials.gov/ct2/show/", NCT, "?resultsxml=true")
  xml_doc <- xml2::read_xml(URL)

  # If export_format == xml_doc, return the xml_doc
  if (export_format == "xml") {
    return(xml_doc)
  }

  # If export_format == csv, return the csv
  ct_read_trial_from_xml(xml_doc)
}
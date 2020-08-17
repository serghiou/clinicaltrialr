#' Save a the XML file of a study
#'
#' Saves the study record as an XML in the specified path.
#'
#' @param NCT The NCT code of the desired study as a character,
#'     e.g. "NCT03478891".
#' @param path The path to the directory in which the file should be saved.
#' @param ... Additional arguments to be passed to `xml2::write_xml`.
#' @return The study record as an XML file in the designed location.
#' @examples
#' \dontrun{
#' # Get the XML of study NCT03478891
#' xml_document <- get_xml_document("NCT03478891")
#' # Save the XML
#' tmp <- tempfile()  # only required for this example, not in using the library
#' write_xml_document(xml_document, tmp)
#' }
#' @export
ct_write_trial <- function(NCT, path = ".", ...) {

  # Extract XML
  URL <- paste0("https://clinicaltrials.gov/ct2/show/", NCT, "?resultsxml=true")
  xml_doc <- xml2::read_xml(URL)

  # Save
  file <- file.path(path, NCT) %>% paste0(".xml")
  xml2::write_xml(xml_doc, file, ...)
}

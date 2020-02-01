#' Save a downloaded xml_document as an XML file
#'
#' Saves the study record as an XML in the specified path.
#'
#' @param xml_document The xml_document received from `get_xml_document`.
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
write_xml_document <- function(xml_document, path = "", ...) {

  file_name <-
    xml_document %>%
    xml2::xml_find_all("id_info/nct_id") %>%
    xml2::xml_contents() %>%
    xml2::xml_text() %>%
    paste0(".xml")

  if (!length(file_name)) {

    stop("This XML file does not contain a valid NCT number.")

  }

  file <- file.path(path, file_name)
  xml2::write_xml(xml_document, file, ...)

}
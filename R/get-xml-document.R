#' Download the whole record of a single study
#'
#' Returns the study record as an xml_document object.
#'
#' @param NCT CharacterThe NCT code of the desired study as a character,
#'     e.g. "NCT03478891".
#' @return The XML study record as an xml_document and xml_node.
#' @export
get_xml_document <- function(NCT) {

  URL <- paste0("https://clinicaltrials.gov/ct2/show/", NCT, "?displayxml=true")
  xml_doc <- xml2::read_xml(URL)

}
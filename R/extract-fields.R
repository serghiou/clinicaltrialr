#' Get commonly used information from ClinicalTrials.gov
#'
#' Returns the commonly used information from ClinicalTrials.gov.
#'
#' @param xml_document An xml_document from `get_xml_document`
#' @return A dataframe with the commonly used fields; if a field was not found,
#'     then this field will be empty, i.e. `character()`
#' @examples
#' # Get the XML of study NCT03478891
#' xml_document <- get_xml_document("NCT03478891")
#' # Extract fields of interest
#' study <- extract_fields(xml_document)
#' @export
extract_fields <- function(xml_document) {

  xpath <- c(
    "id_info/nct_id",
    "brief_title",
    "official_title",
    "brief_summary/textblock",
    "detailed_description/textblock",
    "study_type",
    "phase",
    "study_design_info/allocation",
    "study_design_info/intervention_model",
    "study_design_info/primary_purpose",
    "study_design_info/masking",
    "condition",
    "intervention/intervention_type",
    "intervention/intervention_name",
    "intervention/intervention_desc",
    "eligibility/criteria/textblock",
    "enrollment[@type='Actual']",
    "primary_outcome/measure",
    "primary_outcome/time_frame",
    "primary_outcome/description",
    "reference/citation",
    "reference/PMID"
  )

  field_names <- c(
    "nct_id",
    "brief_title",
    "official_title",
    "brief_summary",
    "detailed_description",
    "study_type",
    "phase",
    "allocation",
    "intervention_model",
    "primary_purpose",
    "masking",
    "condition",
    "intervention_type",
    "intervention_name",
    "intervention_desc",
    "eligibility_criteria",
    "enrollment_actual",
    "primary_outcome_measure",
    "primary_outcome_time_frame",
    "primary_outcome_description",
    "publications_reference",
    "publications_PMID"
  )

  field_content <- lapply(xpath, .get_text, xml_document = xml_document)
  names(field_content) <- field_names
  tibble::as_tibble(field_content)
}


#' Get the desired text from the xml_document
#'
#' Returns the text desired according to xpath.
#'
#' @param xpath The XPath as a character, e.g. "id_info/nct_id"
#' @param xml_document An xml_document from `get_xml_document`
#' @return The desired text as a character; if not found, then `character()`
.get_text <- function(xml_document, xpath) {

  xml_document %>%
    xml2::xml_find_all(xpath) %>%
    xml2::xml_contents() %>%
    xml2::xml_text() %>%
    paste(collapse = "; ")

}
#' Read commonly used information from ClinicalTrials.gov
#'
#' Returns the commonly used information from ClinicalTrials.gov.
#'
#' @param xml_document An xml_document from `get_xml_document`
#' @return A dataframe with the commonly used fields; if a field was not found,
#'     then this field will be empty, i.e. `character()`
#' @examples
#' \dontrun{
#' # Get the XML of study NCT03478891
#' xml_document <- ct_read_trial_xml("NCT03478891")
#' # Extract fields of interest
#' study <- extract_fields(xml_document)
#' }
#' @export
ct_read_trial_csv <- function(xml_document) {

  xpath <- c(
    "id_info/nct_id",
    "study_first_submitted",
    "study_first_posted[@type='Actual']",
    "last_update_posted[@type='Actual']",
    "start_date[@type='Actual']",
    "start_date[@type='Anticipated']",
    "completion_date[@type='Actual']",
    "completion_date[@type='Anticipated']",
    "overall_status",
    "brief_title",
    "official_title",
    "brief_summary/textblock",
    "detailed_description/textblock",
    "study_type",
    "phase",
    "study_design_info/allocation",
    "study_design_info/intervention_model",
    "study_design_info/intervention_model_description",
    "study_design_info/primary_purpose",
    "study_design_info/masking",
    "condition",
    "intervention/intervention_type",
    "intervention/intervention_name",
    "intervention/intervention_desc",
    "eligibility/criteria/textblock",
    "eligibility/gender",
    "eligibility/minimum_age",
    "eligibility/maximum_age",
    "eligibility/healthy_volunteers",
    "enrollment[@type='Anticipated']",
    "enrollment[@type='Actual']",
    "primary_outcome/measure",
    "primary_outcome/time_frame",
    "primary_outcome/description",
    "secondary_outcome/measure",
    "secondary_outcome/time_frame",
    "secondary_outcome/description",
    "arm_group/arm_group_label",
    "arm_group/arm_group_type",
    "arm_group/description",
    "location/facility/name",
    "location/facility/address/city",
    "location/facility/address/country",
    "patient_data",
    "patient_data/sharing_ipd",
    "sponsors//agency",
    "sponsors//agency_class",
    "reference/citation",
    "reference/PMID",
    "overall_contact/last_name",
    "overall_contact/email",
    "overall_contact_backup/last_name",
    "overall_contact_backup/email"
  )

  field_names <- c(
    "nct_id",
    "date_study_first_submitted",
    "date_study_first_posted",
    "date_last_update_posted",
    "date_started_actual",
    "date_started_anticipated",
    "date_completed_actual",
    "date_completed_anticipated",
    "status",
    "brief_title",
    "official_title",
    "brief_summary",
    "detailed_description",
    "study_type",
    "phase",
    "allocation",
    "intervention_model",
    "intervention_model_description",
    "primary_purpose",
    "masking",
    "condition",
    "intervention_type",
    "intervention_name",
    "intervention_desc",
    "eligibility_criteria",
    "gender",
    "minimum_age",
    "maximum_age",
    "healthy_volunteers",
    "enrollment_target",
    "enrollment_actual",
    "primary_outcome_measure",
    "primary_outcome_time_frame",
    "primary_outcome_description",
    "secondary_outcome_measure",
    "secondary_outcome_time_frame",
    "secondary_outcome_description",
    "arm_group_arm_group_label",
    "arm_group_arm_group_type",
    "arm_group_description",
    "location_name",
    "location_city",
    "location_country",
    "patient_data_all",
    "patient_data_sharing_ipd",
    "sponsors_agency",
    "sponsors_agency_class",
    "publications_reference",
    "publications_PMID",
    "overall_contact_last_name",
    "overall_contact_email",
    "overall_contact_backup_last_name",
    "overall_contact_backup_email"
  )

  field_content <- lapply(xpath, .get_text, xml_document = xml_document)
  names(field_content) <- field_names
  tibble::as_tibble(field_content) %>% dplyr::mutate_all(stringr::str_squish)
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
    # TODO: remove the \n because it is messing up the csv file
    paste(collapse = "; ")

}
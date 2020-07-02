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
    nct_id = "id_info/nct_id",
    date_study_first_submitted = "study_first_submitted",
    date_study_first_posted = "study_first_posted[@type='Actual']",
    date_last_update_posted = "last_update_posted[@type='Actual']",
    date_started_actual = "start_date[@type='Actual']",
    date_started_anticipated = "start_date[@type='Anticipated']",
    date_completed_actual = "completion_date[@type='Actual']",
    date_completed_anticipated = "completion_date[@type='Anticipated']",
    status = "overall_status",
    brief_title = "brief_title",
    official_title = "official_title",
    brief_summary = "brief_summary/textblock",
    detailed_description = "detailed_description/textblock",
    study_type = "study_type",
    phase = "phase",
    allocation = "study_design_info/allocation",
    intervention_model = "study_design_info/intervention_model",
    intervention_model_description = "study_design_info/intervention_model_description",
    primary_purpose = "study_design_info/primary_purpose",
    masking = "study_design_info/masking",
    condition = "condition",
    intervention_type = "intervention/intervention_type",
    intervention_name = "intervention/intervention_name",
    intervention_desc = "intervention/intervention_desc",
    eligibility_criteria = "eligibility/criteria/textblock",
    gender = "eligibility/gender",
    minimum_age = "eligibility/minimum_age",
    maximum_age = "eligibility/maximum_age",
    healthy_volunteers = "eligibility/healthy_volunteers",
    enrollment_target = "enrollment[@type='Anticipated']",
    enrollment_actual = "enrollment[@type='Actual']",
    primary_outcome_measure = "primary_outcome/measure",
    primary_outcome_time_frame = "primary_outcome/time_frame",
    primary_outcome_description = "primary_outcome/description",
    secondary_outcome_measure = "secondary_outcome/measure",
    secondary_outcome_time_frame = "secondary_outcome/time_frame",
    secondary_outcome_description = "secondary_outcome/description",
    arm_group_arm_group_label = "arm_group/arm_group_label",
    arm_group_arm_group_type = "arm_group/arm_group_type",
    arm_group_description = "arm_group/description",
    location_name = "location/facility/name",
    location_city = "location/facility/address/city",
    location_country = "location/facility/address/country",
    patient_data_all = "patient_data",
    patient_data_sharing_ipd = "patient_data/sharing_ipd",
    responsible_party = "responsible_party",
    study_sponsor = "sponsors/lead_sponsor/agency",
    study_sponsor_class = "sponsors/lead_sponsor/agency_class",
    collaborators = "sponsors/collaborator/agency",
    collaborators_class = "sponsors/collaborator/agency_class",
    publications_reference = "reference/citation",
    publications_PMID = "reference/PMID",
    overall_contact_last_name = "overall_contact/last_name",
    overall_contact_email = "overall_contact/email",
    overall_contact_backup_last_name = "overall_contact_backup/last_name",
    overall_contact_backup_email = "overall_contact_backup/email"
  )

  xpath %>%
    lapply(.get_text, xml_document = xml_document) %>%
    tibble::as_tibble() %>%
    dplyr::mutate_all(stringr::str_squish)
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

#' Read commonly used information from ClinicalTrials.gov
#'
#' Returns the commonly used information from ClinicalTrials.gov.
#'
#' @param xml_doc A trial from ClinincalTrials.gov as an xml_document.
#' @return If the selected format is "csv", a dataframe with the commonly used
#'     fields; if a field was not found within the file, then this field will be
#'     empty, i.e. `character()`. If the selected format is "xml", then it
#'     returns the trial in xml_document format.
#' @examples
#' \dontrun{
#' # Get the XML of study NCT03478891
#' xml_document <- ct_read_trial("NCT03478891", format = "xml")
#' # Extract fields of interest
#' study <- ct_read_trial_from_xml(xml_document)
#' }
#' @export
ct_read_trial_from_xml <- function(xml_doc) {

  # Define path to fields of interest
  xpath <- c(
    nct_id = "id_info/nct_id",
    nct_id_alias = "id_info/nct_alias",
    org_id = "id_info/org_study_id",
    secondary_id = "id_info/secondary_id",

    first_submitted_date = "study_first_submitted",
    first_posted_date = "study_first_posted[@type='Actual']",
    results_first_posted_date = "results_first_submitted",
    last_update_posted_date = "last_update_posted[@type='Actual']",
    actual_study_start_date = "start_date[@type='Actual']",
    anticipated_study_start_date = "start_date[@type='Anticipated']",
    actual_primary_completion_date = "completion_date[@type='Actual']",
    anticipated_primary_completion_date = "completion_date[@type='Anticipated']",
    status = "overall_status",
    brief_title = "brief_title",
    official_title = "official_title",
    brief_summary = "brief_summary/textblock",
    detailed_description = "detailed_description/textblock",
    study_type = "study_type",
    phase = "phase",

    allocation = "study_design_info/allocation",
    observational_model = "study_design_info/observational_model",
    time_perspective = "study_design_info/time_perspective",
    intervention_model = "study_design_info/intervention_model",
    intervention_model_description =
      "study_design_info/intervention_model_description",
    primary_purpose = "study_design_info/primary_purpose",
    masking = "study_design_info/masking",

    target_duration = "target_duration",

    condition = "condition",

    intervention_type = "intervention/intervention_type",
    intervention_name = "intervention/intervention_name",
    intervention_desc = "intervention/intervention_desc",
    intervention_arm_group_label = "intervention/arm_group_label",
    intervention_other_name = "intervention/other_name",

    study_population = "eligibility/study_pop/textblock",
    sampling_method = "eligibility/sampling_method",
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

    other_outcome_measure = "other_outcome/measure",
    other_outcome_time_frame = "other_outcome/time_frame",
    other_outcome_description = "other_outcome/description",

    arm_group_arm_group_label = "arm_group/arm_group_label",
    arm_group_arm_group_type = "arm_group/arm_group_type",
    arm_group_description = "arm_group/description",

    keywords = "keyword",

    location_name = "location/facility/name",
    location_city = "location/facility/address/city",
    location_country = "location/facility/address/country",

    patient_data_all = "patient_data",
    patient_data_sharing_ipd = "patient_data/sharing_ipd",
    patient_data_ipd_description = "patient_data/ipd_description",
    patient_data_ipd_info_type = "patient_data/ipd_info_type",
    patient_data_ipd_type_frame = "patient_data/ipd_time_frame",
    patient_data_ipd_access_criteria = "patient_data/ipd_access_criteria",
    patient_data_ipd_url = "patient_data/ipd_url",

    responsible_party = "responsible_party",

    study_sponsor = "sponsors/lead_sponsor/agency",
    study_sponsor_class = "sponsors/lead_sponsor/agency_class",
    collaborators = "sponsors/collaborator/agency",
    collaborators_class = "sponsors/collaborator/agency_class",

    investigators_name = "overall_official/last_name",
    investigators_role = "overall_official/role",
    investigators_affiliation = "overall_official/affiliation",

    publications_reference = "reference/citation",
    publications_PMID = "reference/PMID",

    overall_contact_last_name = "overall_contact/last_name",
    overall_contact_email = "overall_contact/email",
    overall_contact_backup_last_name = "overall_contact_backup/last_name",
    overall_contact_backup_email = "overall_contact_backup/email",

    large_doc_type = "provided_document_section//document_type",
    large_doc_has_sap = "provided_document_section//document_has_sap",
    large_doc_date = "provided_document_section//document_date",
    large_doc_url = "provided_document_section//document_url",

    study_doc_id = "study_docs/study_doc/doc_id",
    study_doc_type = "study_docs/study_doc/doc_type",
    study_doc_url = "study_docs/study_doc/doc_url",
    study_doc_comment = "study_docs/study_doc/doc_comment",

    p_value = "clinical_results/outcome_list/outcome/analysis_list//p_value",
    p_value_method = "clinical_results/outcome_list/outcome/analysis_list//method"
  )

  # Extract text of interest
  xpath %>%
    lapply(.get_text, xml_doc = xml_doc) %>%
    tibble::as_tibble() %>%
    dplyr::mutate(extraction_date = date()) %>%
    dplyr::mutate_all(stringr::str_squish)
}
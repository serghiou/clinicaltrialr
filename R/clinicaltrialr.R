#' clinicaltrialr: Import study records from ClinicalTrials.gov
#'
#' It downloads the full study records of the desired study from
#' ClinicalTrials.gov and yields a dataset of the most commonly used fields.
#'
#' @importFrom magrittr %>%
"_PACKAGE"

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1") utils::globalVariables(c("."))
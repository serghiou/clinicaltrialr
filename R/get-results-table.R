#' Download the whole record of a single study
#'
#' Returns the study record as an xml_document object.
#'
#' @param URL The URL given after searching on ClinicalTrials.gov.
#' @return A dataframe of the ClinicalTrials.gov results table.
#' @examples
#' \dontrun{
#' # Copy-paste the URL from the ClinicalTrials.gov website
#' URL <- "http://www.clinicaltrials.gov/ct2/results?cond=Heart+Failure"
#' # Download results table
#' results_table <- get_results_table(URL)
#' }
#' @export
get_results_table <- function(URL) {

  # Get last portion
  query <- gsub("^.*\\?(.+$)", "\\1", URL)

  # URI
  uri_1 <- "https://www.clinicaltrials.gov/ct2/download_fields?"
  uri_2 <- "&down_count=10000&down_fmt=csv&down_flds=all&down_chunk="

  i <- 1
  n <- 10000
  table_list <- list()

  while (n == 10000 & i < 20) {

    table_list[[i]] <-
      paste0(uri_1, query, uri_2, i) %>%
      readr::read_csv()

    n <- nrow(table_list[[i]])
    i <- i + 1
  }

  dplyr::bind_rows(table_list)

}
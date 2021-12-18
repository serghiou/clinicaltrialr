<div align="justify">

# clinicaltrialr 0.6.7

* `ct_read_trial` now uses `ct_read_trial_from_xml` internally.
* `ct_read_trial` argument `format` has been updated to `export_format`.
* `README.md` examples are now updated to reflect changes in the package.


# clinicaltrialr 0.6.5

* `ct_read_trial` now also extracts p-values and hypothesis test method.
* `ct_read_trial_from_xml` can now take an XML file and read fields of interest.


# clinicaltrialr 0.6

* `ct_read_trial` now extracts an xml or a csv.
* `ct_read_trial` gains a new argument `format` to indicate "csv" or "xml".
* `ct_read_trial` replaces both of `ct_read_trial_csv` and `ct_read_trial_xml`


# clinicaltrialr 0.5

* `ct_read_trial_csv` now extracts a lot more fields.


# clinicaltrialr 0.4

* `ct_read_trial_csv` now also extracts Responsible Party, Study Sponsor and Collaborators.
* Add extraction_date to `ct_read_trial_csv` to mark date of data extraction.
* Update names of date columns to match those seen on CT.gov.


# clinicaltrialr 0.3

* `ct_read_results` downloads the results table of a query into a dataframe.
* `ct_read_trial_xml` downloads the full record of a study as an xml_document.
* `ct_write_trial_xml` saves the downloaded xml_document as an XML file.
* `ct_read_trial_csv` extracts popular fields from the full study record and creates a dataframe.


</div>

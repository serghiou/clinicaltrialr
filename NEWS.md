# clinicaltrialr 0.6

<div align="justify">

* `ct_read_trial` now extracts an xml or a csv.
* `ct_read_trial` gains a new argument `format` to indicate "csv" or "xml".
* `ct_read_trial` replaces both of `ct_read_trial_csv` and `ct_read_trial_xml`


# clinicaltrialr 0.5

<div align="justify">

* `ct_read_trial_csv` now extracts a lot more fields.


# clinicaltrialr 0.4

<div align="justify">

* `ct_read_trial_csv` now also extracts Responsible Party, Study Sponsor and Collaborators.

* Add extraction_date to `ct_read_trial_csv` to mark date of data extraction.

* Update names of date columns to match those seen on CT.gov.


# clinicaltrialr 0.3

<div align="justify">

* `ct_read_results` downloads the results table of a query into a dataframe.

* `ct_read_trial_xml` downloads the full record of a study as an xml_document.

* `ct_write_trial_xml` saves the downloaded xml_document as an XML file.

* `ct_read_trial_csv` extracts popular fields from the full study record and creates a dataframe.


</div>

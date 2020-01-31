# clinicaltrialr

<div align="justify">

## Overview

[ClinicalTrials.gov](https://www.clinicaltrials.gov/) provides a fantastic resource of data on all registered clinical trials. However, even though it also provides [API access](https://www.clinicaltrials.gov/ct2/resources/download), it is not possible to easily create a readily analysable database with all study fields of interest. This package aims to make using data from ClinicalTrials.gov as easy as it could be, by providing the functions required to extract all data for all studies of interest.


## Usage




## Alternatives

* ClinicalTrials.gov has its own [API interface](https://clinicaltrials.gov/api/gui). This can be used to create an XML file of [all records about studies of interest](https://clinicaltrials.gov/api/gui/demo/simple_full_study), a CSV file with [specific fields from all studies of interest](https://clinicaltrials.gov/api/gui/demo/simple_study_fields) or a CSV file with [just one field of interest for all studies of interest](https://clinicaltrials.gov/api/gui/demo/simple_field_values). These allow the retrieval of at most 100, 1000 or all records, but using the fields `min_rnk` and `max_rnk` it is possible to, in chunks, download all records of interest.

* 


## Acknowledgements

* This package was built using information provided by ClinicalTrials.gov [here](https://www.clinicaltrials.gov/ct2/resources/download).

* This package would not have been possible without the [xml2 package](https://github.com/r-lib/xml2).

* All I know about building packages I owe to Hadley Wickham and Jennifer Bryan's [book](https://r-pkgs.org/)!


## TODO

This release only contains the basic functions to download and extract popular fields of studies on ClinicalTrials.gov. The following functions would also be great to have and contributions by anyone with the time and interest to enhance this package are more than welcome!

1. Migrate the current functions to the [new](https://clinicaltrials.gov/api/gui/home) API, rather than the [old](https://www.clinicaltrials.gov/ct2/resources/download) one.
1. A function to query ClinicalTrials.gov right from R.
2. A function to download all records of interest in bulk and process that XML file, rather than downloading one at a time.
3. A function to download all of ClinicalTrials.gov.
4. A function to extract even more fields from each study record.
5. Functions to build new fields (e.g. is this a cluster trial, shold this have already been published, etc.)

</div>

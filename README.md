# clinicaltrialr

<div align="justify">

## Overview

[ClinicalTrials.gov](https://www.clinicaltrials.gov/) provides a fantastic resource of data on all registered clinical trials. However, even though it also provides [API access](https://www.clinicaltrials.gov/ct2/resources/download), it is not possible to easily create a readily analysable database with all study fields of interest. This package aims to make using data from ClinicalTrials.gov as easy as it could be, by providing the functions required to extract all data for all studies of interest.


## Usage

1. Use [Advanced Search](https://www.clinicaltrials.gov/ct2/search/advanced?cond=&term=&cntry=&state=&city=&dist=) to find records of interest and copy the URL, e.g. https://www.clinicaltrials.gov/ct2/results?type=Intr&age=0.

2. Download the results. The website only allows downloading the top 10,000. The above query led to 45,000 results, for which reason I downloaded them in chunks in a folder I called "Data": [Chunk 1](https://www.clinicaltrials.gov/ct2/download_fields?type=Intr&age=0&down_count=10000&down_fmt=csv&down_flds=all&down_chunk=1), [Chunk 2](https://www.clinicaltrials.gov/ct2/download_fields?type=Intr&age=0&down_count=10000&down_fmt=csv&down_flds=all&down_chunk=2), [Chunk 3](https://www.clinicaltrials.gov/ct2/download_fields?type=Intr&age=0&down_count=10000&down_fmt=csv&down_flds=all&down_chunk=3), [Chunk 4](https://www.clinicaltrials.gov/ct2/download_fields?type=Intr&age=0&down_count=10000&down_fmt=csv&down_flds=all&down_chunk=4), [Chunk 5](https://www.clinicaltrials.gov/ct2/download_fields?type=Intr&age=0&down_count=10000&down_fmt=csv&down_flds=all&down_chunk=5).
    
3. Import into R.

```{r}
library(tidyverse)
file_names <- list.files("../Data/", pattern = "[0-9].csv", full.names = T)
paed <- map_df(file_names, read_csv)
```

4. Build a function using this package to get all trials of interest.

```{r}
library(clinicaltrialr)

get_trials <- function(NCT) {
  
  NCT %>% 
    clinicaltrialr::get_xml_document() %>% 
    clinicaltrialr::extract_fields()
  
}
```

5. Download all records and construct a dataframe.

```{r}
library(pbapply)
trials_list <- pblapply(paed$`NCT Number`, get_trials, cl = 7)
trials <- do.call(dplyr::bind_rows, trials_list)
```

6. Re-extract values for which the algorithm was not allowed acccess to the website.

```{r}
missing_index <- grep("Error in open", trials_list)
missing_nct <- paed$`NCT Number`[missing_index]
missing_doc <- pblapply(missing_nct, get_trials, cl = 7)
trials_list[missing_index] <- missing_doc
trials <- do.call(dplyr::bind_rows, trials)
```

7. Save as CSV in a folder called "Output".

```{r}
write_csv(trials, "../Output/pediatric-trial-records.csv")
```


## Alternatives

* ClinicalTrials.gov has its own [API interface](https://clinicaltrials.gov/api/gui) to their new API (this package at the moment uses the old API). This can be used to create an XML file of [all records about studies of interest](https://clinicaltrials.gov/api/gui/demo/simple_full_study), a CSV file with [specific fields from all studies of interest](https://clinicaltrials.gov/api/gui/demo/simple_study_fields) or a CSV file with [just one field of interest for all studies of interest](https://clinicaltrials.gov/api/gui/demo/simple_field_values). These allow the retrieval of at most 100, 1000 or all records, but using the fields `min_rnk` and `max_rnk` it is possible to, in chunks, download all records of interest.

* There is an [rclinicaltrials](https://github.com/sachsmc/rclinicaltrials) package. However, (a) it does not allow for the complicated kind of queries that I would like to use and for which I needed to use the Advanced Search function of the website and (b) it creates dataframes that are not easy to analyze and share with others possibly using other platforms.


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

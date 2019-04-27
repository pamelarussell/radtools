## Test environments
* local OS X install, R 3.5.3.
* win-builder

## R CMD check results
There were no ERRORs, WARNINGs, or NOTEs.

## Downstream dependencies
There are no downstream dependencies.

## Some tests require local data
For the tests, we have included two small datasets and we import additional data on the fly so that most tests can be run on CRAN servers. Tests that require data from The Cancer Imaging Archive are skipped on CRAN, as that database requires an API key for live downloads.

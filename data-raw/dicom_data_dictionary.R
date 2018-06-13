library(rvest)
library(hashmap)
library(stringr)

rm(list=ls())

# The DICOM standard
web_dicom_standard <- "http://dicom.nema.org/medical/dicom/current/output/html/part06.html"
webpage <- read_html(web_dicom_standard)
version_dicom_standard <- str_match(html_text(webpage), "DICOM (PS[0-9]+.[0-9]+ 2[0-9]{3}[a-z]*) - Data Dictionary")[1,2]
timestamp_dicom_standard <- Sys.time()

# Identify tables on the webpage
tables <- html_nodes(webpage, "table")

# Parse the first table
data_dict_dicom <- rbind(html_table(tables[[1]], fill = T),
                         html_table(tables[[2]], fill = T),
                         html_table(tables[[3]], fill = T))
colnames(data_dict_dicom)[[6]] <- "Notes"

# Remove zero-length white spaces from keywords
data_dict_dicom$Keyword <- sapply(data_dict_dicom$Keyword, function(x) gsub("\\s", "", x))

# Create mappings of DICOM tag to attribute name/keyword
dicom_tag_to_keyword <- hashmap(data_dict_dicom$Tag, data_dict_dicom$Keyword)
dicom_tag_to_name <- hashmap(data_dict_dicom$Tag, data_dict_dicom$Name)
dicom_keyword_to_tag <- hashmap(data_dict_dicom$Keyword, data_dict_dicom$Tag)
dicom_name_to_tag <- hashmap(data_dict_dicom$Name, data_dict_dicom$Tag)

# Create lists of keywords and names
all_dicom_header_names <- sort(dicom_name_to_tag$keys())
all_dicom_header_keywords <- sort(dicom_keyword_to_tag$keys())
all_dicom_header_tags <- sort(dicom_tag_to_keyword$keys())

# Include as internal data in package
devtools::use_data(web_dicom_standard,
                   version_dicom_standard,
                   timestamp_dicom_standard,
                   dicom_tag_to_keyword,
                   dicom_tag_to_name,
                   dicom_keyword_to_tag,
                   dicom_name_to_tag,
                   data_dict_dicom,
                   all_dicom_header_names,
                   all_dicom_header_keywords,
                   all_dicom_header_tags,
                   internal = TRUE,
                   overwrite = TRUE)

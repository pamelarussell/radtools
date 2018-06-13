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
data_dict <- rbind(html_table(tables[[1]], fill = T),
                         html_table(tables[[2]], fill = T),
                         html_table(tables[[3]], fill = T))
colnames(data_dict)[[6]] <- "Notes"

# Remove zero-length white spaces from keywords
data_dict$Keyword <- sapply(data_dict$Keyword, function(x) gsub("\\s", "", x))

# Create mappings of DICOM tag to attribute name/keyword
tag_to_keyword <- hashmap(data_dict$Tag, data_dict$Keyword)
tag_to_name <- hashmap(data_dict$Tag, data_dict$Name)
keyword_to_tag <- hashmap(data_dict$Keyword, data_dict$Tag)
name_to_tag <- hashmap(data_dict$Name, data_dict$Tag)

# Create lists of keywords and names
all_header_names <- sort(name_to_tag$keys())
all_header_keywords <- sort(keyword_to_tag$keys())
all_header_tags <- sort(tag_to_keyword$keys())

# Include as internal data in package
devtools::use_data(web_dicom_standard,
                   version_dicom_standard,
                   timestamp_dicom_standard,
                   tag_to_keyword,
                   tag_to_name,
                   keyword_to_tag,
                   name_to_tag,
                   data_dict,
                   all_header_names,
                   all_header_keywords,
                   all_header_tags,
                   internal = TRUE,
                   overwrite = TRUE)

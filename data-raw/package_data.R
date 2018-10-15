
# The DICOM standard
web_dicom_standard <- "http://dicom.nema.org/medical/dicom/current/output/html/part06.html"
webpage <- xml2::read_html(web_dicom_standard)
version_dicom_standard <- stringr::str_match(rvest::html_text(webpage), "DICOM (PS[0-9]+.[0-9]+ 2[0-9]{3}[a-z]*) - Data Dictionary")[1,2]
timestamp_dicom_standard <- Sys.time()

# Identify tables on the webpage
tables <- rvest::html_nodes(webpage, "table")

# Parse the first table
data_dict <- rbind(rvest::html_table(tables[[1]], fill = T),
                   rvest::html_table(tables[[2]], fill = T),
                   rvest::html_table(tables[[3]], fill = T))
colnames(data_dict)[[6]] <- "Notes"

# Remove zero-length white spaces from keywords
data_dict$Keyword <- sapply(data_dict$Keyword, function(x) gsub("\\s", "", x))

# Create mappings of DICOM tag to attribute name/keyword
tag_to_keyword <- hashmap::hashmap(data_dict$Tag, data_dict$Keyword)
tag_to_name <- hashmap::hashmap(data_dict$Tag, data_dict$Name)
keyword_to_tag <- hashmap::hashmap(data_dict$Keyword, data_dict$Tag)
name_to_tag <- hashmap::hashmap(data_dict$Name, data_dict$Tag)

# Create lists of keywords and names
all_header_names <- sort(name_to_tag$keys())
all_header_keywords <- sort(keyword_to_tag$keys())
all_header_tags <- sort(tag_to_keyword$keys())

# Included datasets for tests and examples
dir_988_dicom <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/98890234_20030505_MR/98890234/20030505/MR/"
dir_nifti1 <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/nifti-1/"
minimal_base <- paste(dir_nifti1, "minimal", sep = "/")
minimal_nii <- paste(minimal_base, ".nii.gz", sep = "")
sample_dicom_img <- read_dicom(paste(dir_988_dicom, "MR1", sep = "/"))
sample_nifti_img <- read_nifti1(minimal_nii)

# Include as data in package
devtools::use_data(web_dicom_standard,
                   version_dicom_standard,
                   timestamp_dicom_standard,
                   data_dict,
                   all_header_names,
                   all_header_keywords,
                   all_header_tags,
                   internal = TRUE,
                   overwrite = TRUE)

devtools::use_data(sample_dicom_img,
                   sample_nifti_img,
                   internal = FALSE,
                   overwrite = TRUE)


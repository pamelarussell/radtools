
#' Get the website used to load the DICOM standard for this package
#' @return Web URL for DICOM standard
#' @export
dicom_standard_web <- function() {web_dicom_standard}

#' Get the version of the DICOM standard assumed by validation functions
#' @return DICOM standard version
#' @export
dicom_standard_version <- function() {version_dicom_standard}

#' Get the time at which the DICOM standard was loaded from the web for this package
#' @return Timestamp
#' @export
dicom_standard_timestamp <- function() {timestamp_dicom_standard}

# Get header field names that are unique in the header for the given slice
singleton_header_fields <- function(dicom_data, slice_idx) {
  fields <- dicom_data$hdr[[1]]$name
  fields[sapply(fields, function(x) sum(fields == x) == 1)]
}

#' Get the number of image slices in a DICOM series
#' @param dicom_data DICOM data returned by \code{\link{read_dicom}}
#' @return Number of slices
#' @export
num_slices <- function(dicom_data) {
  length(dicom_data$img)
}

#' Get the names of DICOM header fields for an image series.
#' If field names are repeated within a single header, these duplicate
#' fields are omitted from the return value. If slices have different
#' header fields, this function returns the union across slices of
#' all field names.
#' @param dicom_data DICOM data returned by \code{\link{read_dicom}}
#' @return Vector of header field names
#' @export
header_fields <- function(dicom_data) {
  fields <- singleton_header_fields(dicom_data, 1)
  for(i in 2:length(dicom_data$hdr)) {
    fields <- union(fields, singleton_header_fields(dicom_data, i))
  }
  sort(fields)
}

#' Check that a field exists in DICOM header
#' @param dicom_data DICOM data
#' @param field Field name
validate_has_field <- function(dicom_data, field) {
  if(!field %in% header_fields(dicom_data)) {
    stop(paste("Field does not exist in DICOM header or is duplicated within individual slices:", field))
  }
}

#' Validate a header keyword against the DICOM standard
#' @param keyword Keyword
#' @param stop If true, raise error when validation fails. If false, raise warning.
validate_keyword <- function(keyword, stop = TRUE) {
  if(!keyword %in% all_valid_header_keywords()) {
    msg <- paste("Header keyword does not conform to DICOM standard ", dicom_standard_version(),": ", keyword, sep = "")
    if(stop) stop(msg) else warning(msg, immediate. = T)
  }
}

#' Validate a header tag against the DICOM standard
#' @param tag Tag
#' @param stop If true, raise error when validation fails. If false, raise warning.
validate_tag <- function(tag, stop = TRUE) {
  if(!tag %in% all_valid_header_tags()) {
    msg <- paste("Header tag does not conform to DICOM standard ", dicom_standard_version(),": ", tag, sep = "")
    if(stop) stop(msg) else warning(msg, immediate. = T)
  }
}

#' Validate a header group and element against the DICOM standard
#' @param group Group
#' @param element Element
#' @param stop If true, raise error when validation fails. If false, raise warning.
validate_group_element <- function(group, element, stop = TRUE) {
  if(!header_tag(group, element) %in% all_valid_header_tags()) {
    msg <- paste("Header group and element do not conform to DICOM standard ",
                 dicom_standard_version(), ": (", group, ",", element, ")", sep = "")
    if(stop) stop(msg) else warning(msg, immediate. = T)
  }
}

#' Validate all header elements (group, element, name) for all slices
#' @param dicom_data DICOM data returned by \code{\link{read_dicom}}
#' @param stop If true, raise error when validation fails. If false, raise warnings for each failed element.
#' @import dplyr
validate_header_elements <- function(dicom_data, stop = TRUE) {
  elts <- data.frame(group = character(), element = character(), name = character())
  for(i in num_slices(dicom_data)) {
    elts <- rbind(elts, header_as_matrix(dicom_data, i) %>% select(group, element, name))
  }
  elts <- elts %>% unique()
  for(i in 1:nrow(elts)) {
    group <- elts[i, "group"]
    element <- elts[i, "element"]
    name <- elts[i, "name"]
    tryCatch({
      validate_group_element(group, element)
      validate_keyword(name)
    }, error = function(e) {
      msg <- paste("Header field does not conform to DICOM standard ", dicom_standard_version(),
                   ": (", group, ",", element, "): ", name, sep = "")
      warning(msg)
      if(stop) stop(msg) else warning(msg, immediate. = T, noBreaks. = T)
    })
  }
}

#' Get vector of header values for each DICOM slice for a particular header field
#' @param dicom_data DICOM data returned by \code{\link{read_dicom}}
#' @param field Header field keyword e.g. "PatientName"
#' @param numeric Convert values to numbers
#' @return Vector of header values
#' @export
header_values <- function(dicom_data, field, numeric = TRUE) {
  validate_has_field(dicom_data, field)
  oro.dicom::extractHeader(dicom_data$hdr, field, numeric = numeric)
}

#' Get the header information as a matrix
#' @param dicom_data DICOM data returned by \code{\link{read_dicom}}
#' @param slice_idx 1-based slice index. If NA, all slices will be included.
#' @return Data frame containing one record for each header attribute. Note that
#' if all slices are included, fields that appear more than once (including tag and name)
#' in a given slice header will be excluded from the values reported for that slice.
#' Each column contains all header attributes for one slice, therefore, values are
#' represented as strings due to the heterogeneity even if they are conceptually numeric.
#' @import dplyr
#' @export
header_as_matrix <- function(dicom_data, slice_idx = NA) {
  if(!is.na(slice_idx)) dicom_data$hdr[[slice_idx]] %>% unique()
  else {

    process_slice <- function(slice) {
      col_nm <- paste("slice_", slice, sep = "")
      mat <- header_as_matrix(dicom_data, slice_idx = slice)
      # Only keep fields that appear once
      unique_fields <-
        mat %>%
        dplyr::group_by(group, element, name) %>%
        dplyr::summarize(count = n()) %>%
        dplyr::filter(count == 1)
      mat %>%
        dplyr::select(group, element, name, code, value) %>%
        dplyr::rename_at(vars(value), funs(paste0(col_nm))) %>%
        dplyr::filter(name %in% unique_fields$name)
    }

    rtrn <- process_slice(1)
    ns <- num_slices(dicom_data)
    if(ns > 1) {
      for(i in 2:num_slices(dicom_data)) {
        rtrn <- rtrn %>% full_join(process_slice(i), by = c("group", "element", "name", "code"))
      }
    }

    rtrn

  }
}

#' Get the values of header attributes that are constant across slices
#' @param dicom_data DICOM data returned by \code{\link{read_dicom}}
#' @return List of field values that are constant across all slices. List identifiers
#' are field names and values are the common attribute values. Fields that are included
#' more than once in the header are excluded from the return list.
#' @param numeric Convert number values to numeric instead of strings
#' @import dplyr
#' @import Hmisc
#' @export
constant_header_values <- function(dicom_data, numeric = TRUE) {
  # Function to get unique slice values for a row
  unique_vals <- function(row) {
    unique(unlist(row[sapply(names(row), function(x) grepl("^slice_", x))]))
  }
  mat <- header_as_matrix(dicom_data, slice_idx = NA)
  # Remove repeat field names
  mat <- mat[
    which(mat$name %in%
            (mat %>%
               dplyr::group_by(name) %>%
               dplyr::summarize(n_name = n()) %>%
               dplyr::filter(n_name == 1))$name),]
  # List to return
  rtrn <- list()
  # Process each row
  for(i in 1:nrow(mat)) {
    uvals <- unique_vals(mat[i,])
    if(length(uvals) == 1) {
      nm <- mat[i,"name"]
      val <- uvals[1]
      if(numeric && Hmisc::all.is.numeric(val)) val <- as.numeric(val)
      rtrn[[nm]] <- val
    }
  }
  # Return the list
  rtrn
}

#' Get all valid DICOM header keywords
#' @return Vector of all possible header keywords (e.g. "PatientName") from the DICOM standard
#' @export
all_valid_header_keywords <- function() {
  all_header_keywords
}

#' Get all valid DICOM header names
#' @return Vector of all possible header keywords (e.g. "Patient's Name") from the DICOM standard
#' @export
all_valid_header_names <- function() {
  all_header_names
}

#' Get all valid DICOM header tags
#' @return Vector of all possible header tags (e.g. "(0008,0020)") from the DICOM standard
#' @export
all_valid_header_tags <- function() {
  all_header_tags
}

# Check that a string is a 4-digit hex representation
validate_hex <- function(str) {
  if(!grepl("[0-9A-Fa-f]{4}", str)) {
    stop(paste("Not a valid 4-digit hex number:", str))
  }
}

#' Get DICOM header tag string corresponding to a group and element
#' @param group Group e.g. "0008"
#' @param element Element e.g. "0020"
#' @return The tag e.g. "(0008,0020)"
#' @export
header_tag <- function(group, element) {
  validate_hex(group)
  validate_hex(element)
  paste("(", group, ",", element, ")", sep = "")
}

case_insensitive_search <- function(vec, pat) {
  vec[sapply(vec, function(x) grepl(pat, x, ignore.case = T))]
}

#' Search header keywords in the DICOM standard for matches to a string
#' @param str String to search for (case insensitive)
#' @return Vector of header keywords (e.g. "PatientName") matching the string
#' @export
search_header_keywords <- function(str) {
  case_insensitive_search(all_valid_header_keywords(), str)
}

#' Search header names in the DICOM standard for matches to a string
#' @param str String to search for (case insensitive)
#' @return Vector of header names (e.g. "Patient's Name") matching the string
#' @export
search_header_names <- function(str) {
  case_insensitive_search(all_valid_header_names(), str)
}




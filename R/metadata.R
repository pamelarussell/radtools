
#' Get the number of image slices in an image series
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti1}}
#' @return Number of slices
#' @examples
#' \dontrun{num_slices(dicom_data)}
#' \dontrun{num_slices(nifti1_data)}
#' @export
num_slices <- function(img_data) {
  UseMethod("num_slices", img_data)
}

#' Get the dimensions of an image
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti1}}
#' @return Image dimensions
#' @examples
#' \dontrun{img_dimensions(dicom_data)}
#' \dontrun{img_dimensions(nifti1_data)}
#' @export
img_dimensions <- function(img_data) {
  UseMethod("img_dimensions", img_data)
}

#' Get the names of metadata fields from an image dataset's header(s)
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti1}}
#' @return Vector of header field names
#' @examples
#' \dontrun{header_fields(dicom_data)}
#' \dontrun{header_fields(nifti1_data)}
#' @export
header_fields <- function(img_data) {
  UseMethod("header_fields", img_data)
}

#' Get metadata contained in a header field
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti1}}
#' @param field Field name
#' @return Metadata for the field in an appropriate format for the data type
#' @examples
#' \dontrun{header_value(dicom_data, "SliceLocation")}
#' \dontrun{header_value(nifti1_data, "dim_")}
#' @export
header_value <- function(img_data, field) {
  UseMethod("header_value", img_data)
}

#' Validate the metadata associated with an image dataset
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti1}}
#' @param stop If true, raise error when validation fails. If false, raise warnings for each failed element.
#' @keywords internal
validate_metadata <- function(img_data, stop = TRUE) {
  UseMethod("validate_metadata", img_data)
}




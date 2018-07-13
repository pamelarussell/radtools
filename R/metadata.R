
#' Get the number of image slices in an image series
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti}}
#' @return Number of slices
#' @export
num_slices <- function(img_data) {
  UseMethod("num_slices", img_data)
}

#' Validate the metadata associated with an image dataset
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti}}
#' @param stop If true, raise error when validation fails. If false, raise warnings for each failed element.
validate_metadata <- function(img_data, stop = TRUE) {
  UseMethod("validate_metadata", img_data)
}




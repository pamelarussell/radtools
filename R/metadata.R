
#' Get the number of image slices in an image series
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti}}
#' @return Number of slices
#' @export
num_slices <- function(img_data) {
  UseMethod("num_slices", img_data)
}


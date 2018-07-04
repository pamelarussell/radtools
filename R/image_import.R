
#' Read a series of DICOM images from a directory
#' @param dir Directory containing DICOM images
#' @return List with elements \code{hdr} and \code{img}, each with an element for each slice
#' @export
read_dicom <- function(dir) {
  # Wrap oro.dicom::readDICOM, translate error message, validate header
  expr <- expression(oro.dicom::readDICOM(dir))
  tryCatch(rtrn <- eval(expr),
           error = function(e) {
             message("Error raised by oro.dicom::readDICOM")
             message(paste("Message from oro.dicom:", e$message))
             message(paste("On expression:", expr))
             message(paste("With dir = \"", dir, "\"", sep = ""))
             stop("See message for info")
           })
  # Set class attribute of return value
  class(rtrn) <- "dicomdata"
  # Print warnings if any header elements do not match DICOM standard
  dicom_validate_header_elements(rtrn, stop = FALSE)
  rtrn
}

#' Convert image data to 3D matrix of intensities
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti}}
#' @return 3D array of intensities
#' @export
img_data_to_mat <- function(img_data) {
  UseMethod("img_data_to_mat", img_data)
}

img_data_to_mat.dicomdata <- function(dicom_data) {
  oro.dicom::create3D(dicom_data)
}


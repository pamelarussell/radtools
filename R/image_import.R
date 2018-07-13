
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

#' Read a NIfTI-1 image
#' @param file .nii file, gzipped or not
#' @return Object of class \code{\link[oro.nifti]{nifti}}
#' @export
read_nifti1 <- function(file) {
  rtrn <- oro.nifti::readNIfTI(file, warn = 0)
  class(rtrn) <- "nifti1data"
  rtrn
}

#' Convert image data to 3D matrix of intensities
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti}}
#' @return 3D array of intensities where third dimension is slice
#' @export
img_data_to_mat <- function(img_data) {
  UseMethod("img_data_to_mat", img_data)
}

img_data_to_mat.dicomdata <- function(dicom_data) {
  # Wrap oro.dicom::create3D, translate error message
  expr <- expression(oro.dicom::create3D(dicom_data))
  tryCatch(rtrn <- eval(expr),
           error = function(e) {
             message("Error raised by oro.dicom::create3D")
             message(paste("Message from oro.dicom:", e$message))
             message(paste("On expression:", expr))
             if(nrow(dicom_header_as_matrix(dicom_data) %>% dplyr::filter(name == "ImagePositionPatient")) == 0) {
               message("Note: DICOM data does not include header field ImagePositionPatient that is probably required")
             }
             if(nrow(dicom_header_as_matrix(dicom_data) %>% dplyr::filter(name == "ImageOrientationPatient")) == 0) {
               message("Note: DICOM data does not include required header field ImageOrientationPatient")
             }
             stop("See message for info")
           })
  rtrn
}


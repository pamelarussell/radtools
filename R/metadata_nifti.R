
#' @method num_slices nifti1data
#' @export
num_slices.nifti1data <- function(img_data) {
  dim(img_data$data)[3]
}

#' @method img_dimensions nifti1data
#' @export
img_dimensions.nifti1data <- function(img_data) {
  dim8 <- img_data$data@dim_
  ndim <- dim8[1]
  dim8[2:(1+ndim)]
}

#' @method validate_metadata nifti1data
validate_metadata.nifti1data <- function(img_data, stop = TRUE) {
  # Rules as in https://nifti.nimh.nih.gov/nifti-1/documentation/faq#Q4
  fail <- function(msg) {
    if(stop) stop(msg) else warning(msg)
  }
  # Make sure size of header is 348
  if(slot(img_data$data, "sizeof_hdr") != 348) fail("Size of NIfTI-1 header must be 348")
  # Magic must be "ni1" or "n+1"
  magic <- slot(img_data$data, "magic")
  if(!magic %in% c("n+1", "ni1")) fail("Invalid magic attribute")
  # Vox offset required for an "n+1" header
  if(magic == "n+1" && slot(img_data$data, "vox_offset") < 1) fail("Vox offset is required for an n+1 header")
}

#' Returns the number of dimensions in a NIfTI-1 image
#' @param nifti1_data NIfTI-1 data returned by \code{\link{read_nifti1}}
#' @export
nifti1_num_dim <- function(nifti1_data) {
  nifti1_data$data@dim_[1]
}



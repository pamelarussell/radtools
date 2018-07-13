
# Number of image slices
num_slices.nifti1data <- function(nifti_data) {
  dim(nifti_data$data)[3]
}

# As in https://nifti.nimh.nih.gov/nifti-1/documentation/faq#Q4
validate_metadata.nifti1data <- function(nifti_data, stop = TRUE) {
  fail <- function(msg) {
    if(stop) stop(msg) else warning(msg)
  }
  # Make sure size of header is 348
  if(slot(nifti_data$data, "sizeof_hdr") != 348) fail("Size of NIfTI-1 header must be 348")
  # Magic must be "ni1" or "n+1"
  magic <- slot(nifti_data$data, "magic")
  if(!magic %in% c("n+1", "ni1")) fail("Invalid magic attribute")
  # Vox offset required for an "n+1" header
  if(magic == "n+1" && slot(nifti_data$data, "vox_offset") < 1) fail("Vox offset is required for an n+1 header")
}

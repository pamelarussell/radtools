
# Number of image slices
num_slices.nifti1data <- function(nifti_data) {
  dim(nifti_data$data)[3]
}

# As in https://nifti.nimh.nih.gov/nifti-1/documentation/faq#Q4
validate_metadata.nifti1data <- function(dicom_data, stop = TRUE) {
  # Make sure size of header is 348
  error("not implemented")
  # Make sure datatype is set
  error("not implemented")
  # Make sure bitpix corresponds correctly to datatype
  error("not implemented")
  # With the exception of pixdim[0] (which is required when qform_code != 0), pixdim[n] is required when dim[n] is required
  error("not implemented")
  # Vox offset required for an "n+1" header
  error("not implemented")
  # Magic must be "ni1\0" or "n+1\0"
  error("not implemented")
  # Fields that must be set or 0
  # intent_code, scl_slope, xyzt_units, cal_max, cal_min, toffset, slice_code, dim_info, qform_code, sform_code
  error("not implemented")
  # intent_name[0] must be set or '\0'
  error("not implemented")
}

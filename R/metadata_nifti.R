
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

#' @importFrom methods slot
#' @method validate_metadata nifti1data
validate_metadata.nifti1data <- function(img_data, stop = TRUE) {
  # Rules as in https://nifti.nimh.nih.gov/nifti-1/documentation/faq#Q4
  fail <- function(msg) {
    if(stop) stop(msg) else warning(msg)
  }
  # Make sure size of header is 348
  if(methods::slot(img_data$data, "sizeof_hdr") != 348) fail("Size of NIfTI-1 header must be 348")
  # Magic must be "ni1" or "n+1"
  magic <- methods::slot(img_data$data, "magic")
  if(!magic %in% c("n+1", "ni1")) fail("Invalid magic attribute")
  # Vox offset required for an "n+1" header
  if(magic == "n+1" && methods::slot(img_data$data, "vox_offset") < 1) fail("Vox offset is required for an n+1 header")
}

#' Get the number of dimensions in a NIfTI-1 image
#' @param nifti1_data NIfTI-1 data returned by \code{\link{read_nifti1}}
#' @examples
#' \dontrun{nifti1_num_dim(nifti1_data)}
#' @export
nifti1_num_dim <- function(nifti1_data) {
  nifti1_data$data@dim_[1]
}

#' Get the fields in a NIfTI-1 header.
#'
#' See the \href{https://nifti.nimh.nih.gov/pub/dist/src/niftilib/nifti1.h}{official definition of the NIfTI-1 header}.
#' @param img_data NIfTI-1 data returned by \code{\link{read_nifti1}}
#' @return Vector of header field names
#' @method header_fields nifti1data
#' @importFrom methods slotNames
#' @export
header_fields.nifti1data <- function(img_data) {
  methods::slotNames(img_data[["data"]])
}

#' Get header value for a field in a NIfTI-1 header
#' @param img_data NIfTI-1 data returned by \code{\link{read_nifti1}}
#' @param field Header field name e.g. "sizeof_hdr". Get header field names with \code{\link{header_fields}}.
#' @return Metadata field value
#' @export
#' @importFrom methods slot
#' @method header_value nifti1data
header_value.nifti1data <- function(img_data, field) {
  methods::slot(img_data$data, field)
}

#' Get named list of header attributes for a NIfTI-1 file
#' @param img_data NIfTI-1 data returned by \code{\link{read_nifti1}}
#' @return List of header attribute values
#' @examples
#' \dontrun{nifti1_header_values(nifti1_data)}
#' @export
nifti1_header_values <- function(img_data) {
  sapply(header_fields(img_data), function(x) header_value(img_data, x))
}





# Check if all DICOM files have nonzero values in 128-byte preamble
all_nonzero_preamble <- function(path) {
  if(utils::file_test("-f", path)) {
    files <- c(path)
  } else {
    if(utils::file_test("-d", path)) {
      files <- list.files(path, full.names = TRUE)
    } else {
      stop(paste("Invalid path:", path))
    }
  }
  rtrn <- TRUE
  for(file in files) {
    preamble <- readBin(file, "raw", n = 128)
    if(!any(preamble)) {
      rtrn <- FALSE
    }
  }
  rtrn
}

# Check if the 4-byte DICOM prefix contains the string "DICM"
# http://dicom.nema.org/MEDICAL/dicom/2016a/output/chtml/part10/chapter_7.html
has_dicom_prefix <- function(file) {
  grepl("DICM", paste(readBin(file, "character", 132)[129:132], collapse = ""))
}

# Check if all DICOM files have "DICM" in the 4-byte prefix
# http://dicom.nema.org/MEDICAL/dicom/2016a/output/chtml/part10/chapter_7.html
all_have_dicom_prefix <- function(path) {
  if(utils::file_test("-f", path)) {
    files <- c(path)
  } else {
    if(utils::file_test("-d", path)) {
      files <- list.files(path, full.names = TRUE)
    } else {
      stop(paste("Invalid path:", path))
    }
  }
  rtrn <- TRUE
  for(file in files) {
    if(!has_dicom_prefix(file)) {
      rtrn <- FALSE
    }
  }
  rtrn
}

#' Read a DICOM image or series of images
#' @param path Directory containing DICOM images, or single image file
#' @param ... Additional arguments to \code{\link[oro.dicom]{readDICOM}}
#' @return List with elements \code{hdr} and \code{img}, each with an element for each slice
#' @examples
#' \dontrun{read_dicom(dicom_directory)}
#' \dontrun{read_dicom(dicom_file.dcm)}
#' @importFrom oro.dicom readDICOM
#' @export
read_dicom <- function(path, ...) {
  # Check for 4-byte DICOM prefix
  if(!all_have_dicom_prefix(path)) {
    stop(paste("All DICOM files must have 4-byte prefix containing string \"DICM\":\n", path))
  }
  # Wrap oro.dicom::readDICOM, translate error message, validate header
  expr <- expression(oro.dicom::readDICOM(path, ...))
  tryCatch(rtrn <- eval(expr),
           error = function(e) {
             mess <- e$message
               message("Error raised by oro.dicom::readDICOM")
               message(paste("Message from oro.dicom:", mess))
               message(paste("On expression:", expr))
               message(paste("With path = \"", path, "\"", sep = ""))
               stop("See message for info")
           })
  # Set class attribute of return value
  class(rtrn) <- "dicomdata"
  # Print warnings if any header elements do not match DICOM standard
  validate_metadata(rtrn, stop = FALSE)
  rtrn
}

#' Read a NIfTI-1 image
#' @param file .nii file, gzipped or not, or base of .hdr and .img files without extension
#' @param ... Additional arguments to \code{\link[oro.nifti]{readNIfTI}}
#' @return List containing object of class \code{\link[oro.nifti]{nifti}}
#' @examples
#' \dontrun{read_nifti1(nifti_file.nii)}
#' \dontrun{read_nifti1(nifti_file_basename)}
#' @importFrom oro.nifti readNIfTI
#' @export
read_nifti1 <- function(file, ...) {
  # Wrap oro.nifti::readNIFTI, translate error message, validate header
  expr <- expression(oro.nifti::readNIfTI(file, ...))
  rtrn <- NULL
  tryCatch(rtrn$data <- eval(expr),
           error = function(e) {
             mess <- e$message
             message("Error raised by oro.nifti::readNIfTI")
             message(paste("Message from oro.nifti:", mess))
             message(paste("On expression:", expr))
             message(paste("With file(s) = \"", file, "\"", sep = ""))
             if(grepl("reorient", mess, ignore.case = TRUE)) {
               message("Consider using reorient = FALSE.")
             }
             stop("See message for info")
           })
  # Set class attribute of return value
  class(rtrn) <- "nifti1data"
  # Validate metadata
  validate_metadata(rtrn, stop = T)
  rtrn
}

#' Convert image data to 3D matrix of intensities
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti1}}
#' @param coord_extra_dim Coordinates in extra dimensions (beyond 3) that define the
#' particular 3D image of interest. Not applicable for DICOM; pass NULL in that case.
#' @return 3D array of intensities where third dimension is slice
#' @examples
#' data(sample_nifti_img)
#' img_data_to_3D_mat(sample_nifti_img)
#' \dontrun{img_data_to_3D_mat(nifti_data_4D, coord_extra_dim = 10)}
#' @export
img_data_to_3D_mat <- function(img_data, coord_extra_dim) {
  UseMethod("img_data_to_3D_mat", img_data)
}

#' Convert image data to matrix of intensities
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti1}}
#' @return Multidimensional array of intensities where third dimension is slice
#' @examples
#' data(sample_dicom_img)
#' img_data_to_mat(sample_dicom_img)
#' @export
img_data_to_mat <- function(img_data) {
  UseMethod("img_data_to_mat", img_data)
}

#' @method img_data_to_mat dicomdata
#' @export
img_data_to_mat.dicomdata <- function(img_data) {img_data_to_3D_mat(img_data, coord_extra_dim = NULL)}

#' @method img_data_to_3D_mat dicomdata
#' @importFrom oro.dicom create3D
#' @importFrom dplyr filter
#' @importFrom magrittr %>%
#' @export
img_data_to_3D_mat.dicomdata <- function(img_data, coord_extra_dim = NULL) {
  if(!is.null(coord_extra_dim)) stop("Do not provide coordinates in dimensions beyond 3 for DICOM")
  # Wrap oro.dicom::create3D, translate error message
  expr <- expression(oro.dicom::create3D(img_data))
  tryCatch(rtrn <- eval(expr),
           error = function(e) {
             message("Error raised by oro.dicom::create3D")
             message(paste("Message from oro.dicom:", e$message))
             message(paste("On expression:", expr))
             if(nrow(dicom_header_as_matrix(img_data) %>% dplyr::filter(name == "ImagePositionPatient")) == 0) {
               message("Note: DICOM data does not include header field ImagePositionPatient that is probably required")
             }
             if(nrow(dicom_header_as_matrix(img_data) %>% dplyr::filter(name == "ImageOrientationPatient")) == 0) {
               message("Note: DICOM data does not include required header field ImageOrientationPatient")
             }
             stop("See message for info")
           })
  tryCatch({
    rows <- header_value(img_data, "Rows")
    cols <- header_value(img_data, "Columns")
    urows <- unique(rows)
    ucols <- unique(cols)
    if(length(urows) > 1 || length(cols) > 1) {
      stop("Must have constant row and column dimensions")
    }
    dim <- dim(rtrn)
    if (urows != dim[1] || ucols != dim[2]) {
      warning(paste("Returning 3D matrix whose dimensions do not match Rows and Columns attributes in DICOM metadata.",
                    "The discrepancy may be related to the \"transpose\" option in oro.dicom::create3D."))
    }
  }, error = function(e) {
    warning("Couldn't validate 3D matrix: could not get Rows and Columns attributes from DICOM metadata,
            or invalid attributes")
  })
  rtrn
}

# From https://stackoverflow.com/questions/14500707/select-along-one-of-n-dimensions-in-array
index_array <- function(x, dim, value, drop = FALSE) {
  # Create list representing arguments supplied to [
  # bquote() creates an object corresponding to a missing argument
  indices <- rep(list(bquote()), length(dim(x)))
  indices[[dim]] <- value

  # Generate the call to [
  call <- as.call(c(
    list(as.name("["), quote(x)),
    indices,
    list(drop = drop)))
  # Finally, evaluate it
  eval(call)
}

#' Take a slice of a multidimensional array by fixing the coordinates in the last dimension(s)
#' @param mat Multidimensional array
#' @param coords_last_dims One or more coordinates in the last one or more dimensions of the matrix
#' @return The reduced matrix with last dimension(s) collapsed
#' @keywords internal
mat_reduce_dim <- function(mat, coords_last_dims) {

  if(!is.array(mat) && !is.vector(mat)) stop("Must pass an array or vector")

  ncoord <- length(coords_last_dims)

  if(is.array(mat) && ncoord > length(dim(mat))) {
    stop("Provide fewer than the number of dimensions in the matrix")
  }

  if(is.vector(mat) && ncoord > 1) {
    stop("Provide fewer than the number of dimensions")
  }

  if(ncoord == 0) {
    mat
  } else {
    if(is.array(mat)) dim <- length(dim(mat)) else if(is.vector(mat)) dim <- 1
    val <- coords_last_dims[ncoord]
    red <- index_array(mat, dim, val, drop = TRUE)
    if(ncoord == 1) {
      red
    } else {
      mat_reduce_dim(red, coords_last_dims[1:(ncoord - 1)])
    }
  }

}

#' @method img_data_to_mat nifti1data
#' @importFrom methods slot
#' @export
img_data_to_mat.nifti1data <- function(img_data) {
  methods::slot(img_data$data, ".Data")
}

#' @method img_data_to_3D_mat nifti1data
#' @export
img_data_to_3D_mat.nifti1data <- function(img_data, coord_extra_dim = NULL) {
  d <- nifti1_num_dim(img_data)
  if(d > 3) {
    n_extra_dim <- d - 3
    if(length(coord_extra_dim) != n_extra_dim) {
      stop(paste("Provide coordinates in", n_extra_dim, "extra dimensions"))
    }
    full_mat <- img_data_to_mat(img_data)
    mat_reduce_dim(full_mat, coord_extra_dim)
  } else {
    if(!is.null(coord_extra_dim)) stop("Do not provide coordinates in extra dimensions for 3D image")
    img_data_to_mat(img_data)
  }
}



#' Display a visual of one slice of an image
#' @param img_data Image data returned by e.g. \code{\link{read_dicom}} or \code{\link{read_nifti1}}
#' @param slice Slice number, or NULL if image is already 2D
#' @param col Color scheme
#' @export
view_slice <- function(img_data, slice = NULL, col = grey(0:64/64), ...) {
  mat <- img_data_to_mat(img_data)
  ndim <- length(dim(mat))
  if (ndim == 2) {
    view_slice_mat(mat, slice, col, ...)
  } else if (ndim == 3) {
    view_slice_mat(mat, slice, col, ...)
  } else if (ndim > 3) {
    stop(paste("Can't view slice of a ", ndim, "D matrix. Try reducing to 3D and calling view_slice_mat.", sep = ""))
  } else {
    stop(paste("Can't view slice of a ", ndim, "D matrix.", sep = ""))
  }
}

#' Display a visual of one slice of an image matrix
#' @param img_data 2D or 3D intensity matrix, e.g. the return value from \code{\link{img_data_to_mat}} or \code{\link{img_data_to_3D_mat}}
#' @param slice Slice number, or NULL if matrix is 2D
#' @param col Color scheme
#' @export
view_slice_mat <- function(mat, slice = NULL, col = grey(0:64/64), ...) {
  ndim <- length(dim(mat))
  if (ndim == 2) {
    if (!is.null(slice)) {
      stop("Don't provide a slice number for 2D matrix")
    }
    m <- mat
  } else if (ndim == 3) {
    if(dim(mat)[3] == 1) {
      slice <- 1
    }
    if(is.null(slice)) {
      stop("Provide a slice number for 3D matrix")
    }
    if (slice < 1 || slice > dim(mat)[3]) {
      stop(paste("Invalid slice number for matrix with dimensions", dim(mat)))
    }
    m <- mat[,,slice]
  } else {
    stop("Matrix must be 2 or 3 dimensional")
  }
  image(x = 1:nrow(m), y = 1:ncol(m), z = m, col = col, ann = FALSE, ...)
}

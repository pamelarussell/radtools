
# Try to download a file; catch error if there is one
# If error is caught, delete the destfile
dl_try <- function(url, destfile) {
  tryCatch({
    download.file(url, destfile, mode="wb")
  },
  error = function(e) {
    message(paste("Could not download file from url", url))
  })
}


# Try to load DICOM object; catch error if there is one
# and fail with message
read_dicom_try <- function(path) {
  tryCatch({
    read_dicom(path)
  }, error = function(e) {
    message(paste("Could not read DICOM object from path", path))
  })
}

# Try to load nifti object; catch error if there is one
# and fail with message
read_nifti1_try <- function(path, ...) {
  tryCatch({
    read_nifti1(path, ...)
  }, error = function(e) {
    message(paste("Could not read NIfTI-1 object from path", path))
  })
}


# Evaluate an expression only if an input object is defined
expression_try <- function(input, expression) {
  input_name <- deparse(substitute(input))
  if(exists(input_name)) {
    expression
  } else {
    message(paste("Skipping test: object", input_name, "does not exist."))
  }
}


have_tcia_key = function() {
  nzchar(Sys.getenv("TCIA_API_KEY", ""))
}

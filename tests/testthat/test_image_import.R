
test_that("Invalid DICOM files", {
  expect_error(read_dicom(paste(dir_d_clunie_dicom_deflate, "image_dfl", sep = "/")))
})

test_that("DICOM image data to 3D matrix", {
  expect_equal(dim(img_data_to_3D_mat(dicom_data_chest)), c(512, 512, 128))
  expect_equal(dim(img_data_to_3D_mat(dicom_data_prostate_mr)), c(384, 384, 19))
  expect_equal(dim(img_data_to_3D_mat(dicom_data_prostate_pt)), c(144, 144, 234))
  expect_error(img_data_to_3D_mat(dicom_data_chest, coord_extra_dim = 1))
  expect_error(img_data_to_3D_mat(dicom_data_bladder)) # Data is missing required header fields for oro.dicom::create3D()
})

test_that("DICOM image data to matrix", {
  expect_equal(dim(img_data_to_mat(dicom_data_chest)), c(512, 512, 128))
  expect_equal(dim(img_data_to_mat(dicom_data_prostate_mr)), c(384, 384, 19))
  expect_equal(dim(img_data_to_mat(dicom_data_prostate_pt)), c(144, 144, 234))
  expect_error(img_data_to_mat(dicom_data_bladder)) # Data is missing required header fields for oro.dicom::create3D()
})

test_that("Matrix reduce dimensions", {

  expect_error(mat_reduce_dim(1:5))

  mat0 <- NULL
  expect_error(mat_reduce_dim(mat0, 5))

  mat1 <- array(1:5)
  expect_equal(mat_reduce_dim(mat1, NULL), mat1)
  expect_equal(mat_reduce_dim(mat1, 5), 5)
  expect_error(mat_reduce_dim(mat1, c(1,2)))

  mat2 <- array(dim = c(5,5))
  mat2[2,3] <- 3
  mat2[5,2] <- 5
  expect_equal(mat_reduce_dim(mat2, 3), c(NA, 3, NA, NA, NA))
  expect_equal(mat_reduce_dim(mat2, 2), c(NA, NA, NA, NA, 5))
  expect_equal(mat_reduce_dim(mat2, c(2,3)), 3)
  expect_true(is.na(mat_reduce_dim(mat2, c(2,4))))

  mat3 <- array(dim = c(5,5,5))
  mat3[1,2,3] <- 4
  expect_error(mat_reduce_dim(mat3, c(1,2,3,4)))
  expect_equal(mat_reduce_dim(mat3, 3)[1,2], 4)
  expect_equal(dim(mat_reduce_dim(mat3, 3)), c(5,5))
  expect_equal(length(mat_reduce_dim(mat3, c(2,2))), 5)
  expect_equal(length(mat_reduce_dim(mat3, c(2,2,2))), 1)

})

test_that("NIfTI image data to 3D matrix", {
  expect_error(img_data_to_3D_mat(nifti_data_filtered_func, coord_extra_dim = 181))
  expect_equal(dim(img_data_to_3D_mat(nifti_data_filtered_func, coord_extra_dim = 180)), c(64, 64, 21))
  expect_error(img_data_to_3D_mat(nifti_data_filtered_func, coord_extra_dim = NULL))
  expect_equal(dim(img_data_to_3D_mat(nifti_data_filtered_func, coord_extra_dim = c(180))), c(64, 64, 21))
  expect_error(img_data_to_3D_mat(nifti_data_filtered_func, coord_extra_dim = c(1,1)))
  expect_error(img_data_to_3D_mat(nifti_data_filtered_func))
  expect_error(img_data_to_3D_mat(nifti_data_avg152T1_LR, coord_extra_dim = 5))
  expect_error(img_data_to_3D_mat(nifti_data_avg152T1_LR, coord_extra_dim = c(1,1)))
  expect_equal(dim(img_data_to_3D_mat(nifti_data_avg152T1_LR)), c(91, 109, 91))
})

test_that("NIfTI image data to matrix", {
  expect_equal(dim(img_data_to_mat(nifti_data_filtered_func)), c(64, 64, 21, 180))
  expect_equal(dim(img_data_to_mat(nifti_data_avg152T1_LR)), c(91, 109, 91))
})



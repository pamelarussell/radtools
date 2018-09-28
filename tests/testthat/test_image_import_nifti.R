
test_that("NIfTI image data to 3D matrix", {
  skip_on_cran()
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
  skip_on_cran()
  expect_equal(dim(img_data_to_mat(nifti_data_filtered_func)), c(64, 64, 21, 180))
  expect_equal(dim(img_data_to_mat(nifti_data_avg152T1_LR)), c(91, 109, 91))
})

test_that("nifti_data_1103_3", {
  skip_on_cran()
  expect_equal(dim(img_data_to_mat(nifti_data_1103_3)), c(256,256,332))
  expect_equal(dim(img_data_to_3D_mat(nifti_data_1103_3)), c(256,256,332))
})

test_that("nifti_data_113_01_MPRAGE_mask", {
  skip_on_cran()
  expect_equal(dim(img_data_to_3D_mat(nifti_data_113_01_MPRAGE_mask)), c(170,256,256))
  expect_equal(dim(img_data_to_mat(nifti_data_113_01_MPRAGE_mask)), c(170,256,256))
})

test_that("nifti_data_avg152T1_LR_hi", {
  skip_on_cran()
  expect_equal(dim(img_data_to_mat(nifti_data_avg152T1_LR_hi)), c(91,109,91))
})

test_that("nifti_data_filtered_func", {
  skip_on_cran()
  expect_equal(dim(img_data_to_3D_mat(nifti_data_filtered_func,5)), c(64,64,21))
  expect_equal(dim(img_data_to_mat(nifti_data_filtered_func)), c(64,64,21,180))
})

test_that("nifti_data_flair", {
  skip_on_cran()
  expect_equal(dim(img_data_to_3D_mat(nifti_data_flair)), c(288,288,22))
  expect_equal(dim(img_data_to_mat(nifti_data_flair)), c(288,288,22))
})

test_that("nifti_data_JHU_MNI_SS_T1_mask", {
  skip_on_cran()
  expect_equal(dim(img_data_to_3D_mat(nifti_data_JHU_MNI_SS_T1_mask)), c(181,217,181))
  expect_equal(dim(img_data_to_mat(nifti_data_JHU_MNI_SS_T1_mask)), c(181,217,181))
})

test_that("nifti_data_minimal", {
  skip_on_cran()
  expect_equal(dim(img_data_to_mat(nifti_data_minimal)), c(64,64,10))
})

test_that("nifti_data_MNI152_T1_1mm_brain", {
  skip_on_cran()
  expect_equal(dim(img_data_to_3D_mat(nifti_data_MNI152_T1_1mm_brain)), c(182,218,182))
})

test_that("nifti_data_roi_regToT1_SyNtoMNI", {
  skip_on_cran()
  expect_equal(dim(img_data_to_mat(nifti_data_roi_regToT1_SyNtoMNI)), c(182,218,182))
})

test_that("nifti_data_sirp", {
  skip_on_cran()
  expect_equal(dim(img_data_to_3D_mat(nifti_data_sirp,5)), c(64,64,35))
  expect_equal(dim(img_data_to_mat(nifti_data_sirp)), c(64,64,35,147))
})

test_that("nifti_data_t1", {
  skip_on_cran()
  expect_equal(dim(img_data_to_mat(nifti_data_t1)), c(512,512,22))
})

test_that("nifti_data_t1_SyNtoMNI", {
  skip_on_cran()
  expect_equal(dim(img_data_to_3D_mat(nifti_data_t1_SyNtoMNI)), c(182,218,182))
})

test_that("nifti_data_zstat1", {
  skip_on_cran()
  expect_equal(dim(img_data_to_mat(nifti_data_zstat1)), c(64,64,21))
})



test_that("View a slice of a 2D image with view_slice", {
  view_slice(dicom_data_sbarre_brain)
})

test_that("View a slice of a 3D image with view_slice", {
  view_slice(nifti_data_avg152T1_LR, 5)
  view_slice(dicom_data_prostate_mr, 5)
})

test_that("View a slice of a 2D image with view_slice_mat", {
  view_slice_mat(img_data_to_mat(dicom_data_sbarre_brain))
})

test_that("View a slice of a 3D image with view_slice_mat", {
  view_slice_mat(img_data_to_mat(nifti_data_avg152T1_LR), 10)
  view_slice_mat(img_data_to_mat(dicom_data_prostate_mr), 10)
})

test_that("View a slice of a 4D image with view_slice_mat", {
  view_slice_mat(img_data_to_3D_mat(nifti_data_filtered_func, 10), 5)
})

test_that("view_slice throws error for 4D image", {
  expect_error(view_slice(nifti_data_filtered_func, 5))
})

test_that("view_slice throws error for 3D image if no slice number is provided", {
  expect_error(view_slice(nifti_data_avg152T1_LR))
})

test_that("view_slice_mat throws error for 4D image", {
  expect_error(view_slice_mat(img_data_to_mat(nifti_data_filtered_func)))
})

test_that("view_slice_mat throws error for 4D image if no slice number is provided", {
  expect_error(view_slice_mat(img_data_to_3D_mat(nifti_data_filtered_func)))
})

test_that("view_slice_mat throws error for scalar or 1D matrix", {
  expect_error(view_slice_mat(0))
  expect_error(view_slice_mat(1:5))
})

test_that("view_slice throws error if slice number is out of bounds", {
  expect_error(view_slice(dicom_data_prostate_mr, 1000))
  expect_error(view_slice(dicom_data_prostate_mr, 0))
})

test_that("view_slice_mat throws error if slice number is out of bounds", {
  expect_error(view_slice(img_data_to_3D_mat(dicom_data_prostate_mr, 1000)))
  expect_error(view_slice(img_data_to_3D_mat(dicom_data_prostate_mr, 0)))
})



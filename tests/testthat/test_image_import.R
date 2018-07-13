
test_that("DICOM image data to matrix", {
  expect_equal(dim(img_data_to_mat(dicom_data_chest)), c(512, 512, 128))
  expect_equal(dim(img_data_to_mat(dicom_data_prostate_mr)), c(384, 384, 19))
  expect_equal(dim(img_data_to_mat(dicom_data_prostate_pt)), c(144, 144, 234))
  expect_error(img_data_to_mat(dicom_data_bladder)) # Data is missing required header fields for oro.dicom::create3D()
})



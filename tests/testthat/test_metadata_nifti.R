
test_that("Number of slices", {
  expect_equal(num_slices(nifti_data_avg152T1_LR), 91)
  expect_equal(num_slices(nifti_data_avg152T1_RL), 91)
  expect_equal(num_slices(nifti_data_filtered_func), 21)
  expect_equal(num_slices(nifti_data_minimal), 10)
  expect_equal(num_slices(nifti_data_zstat1), 21)
})

test_that("Number of dimensions", {
  expect_equal(nifti1_num_dim(nifti_data_filtered_func), 4)
  expect_equal(nifti1_num_dim(nifti_data_avg152T1_LR), 3)
})

test_that("Image dimensions", {
  expect_equal(img_dimensions(nifti_data_filtered_func), c(64, 64, 21, 180))
  expect_equal(img_dimensions(nifti_data_avg152T1_LR), c(91, 109, 91))
})

test_that("Header fields", {
  expect_equal(header_fields(nifti_data_avg152T1_LR), header_fields(nifti_data_minimal))
  expect_equal(length(header_fields(nifti_data_zstat1)), 46)
  expect_true("slice_code" %in% header_fields(nifti_data_filtered_func))
})

test_that("Header values", {
  expect_equal(header_value(nifti_data_filtered_func, "sizeof_hdr"), 348)
  expect_equal(header_value(nifti_data_filtered_func, "extender"), c(0,0,0,0))
  expect_equal(header_value(nifti_data_avg152T1_LR, "qoffset_x"), 0)
  expect_equal(header_value(nifti_data_avg152T1_LR, "descrip"), "FSL3.2beta")
  expect_equal(header_value(nifti_data_avg152T1_LR, "data_type"), "")
})




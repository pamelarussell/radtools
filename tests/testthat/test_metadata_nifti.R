
test_that("Number of slices", {
  expect_equal(num_slices(nifti_data_avg152T1_LR), 91)
  expect_equal(num_slices(nifti_data_avg152T1_RL), 91)
  expect_equal(num_slices(nifti_data_filtered_func), 21)
  expect_equal(num_slices(nifti_data_minimal), 10)
  expect_equal(num_slices(nifti_data_zstat1), 21)
})


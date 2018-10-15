
test_that("Number of slices", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_avg152T1_LR), 91)
  expect_equal(num_slices(nifti_data_avg152T1_RL), 91)
  expect_equal(num_slices(nifti_data_filtered_func), 21)
  expect_equal(num_slices(sample_nifti_img), 10)
  expect_equal(num_slices(nifti_data_zstat1), 21)
})

test_that("Number of slices - for CRAN", {
  expect_equal(num_slices(sample_nifti_img), 10)
})

test_that("Number of dimensions", {
  skip_on_cran()
  expect_equal(nifti1_num_dim(nifti_data_filtered_func), 4)
  expect_equal(nifti1_num_dim(nifti_data_avg152T1_LR), 3)
})

test_that("Image dimensions", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_filtered_func), c(64, 64, 21, 180))
  expect_equal(img_dimensions(nifti_data_avg152T1_LR), c(91, 109, 91))
})

test_that("Header fields", {
  skip_on_cran()
  expect_equal(header_fields(nifti_data_avg152T1_LR), header_fields(sample_nifti_img))
  expect_equal(length(header_fields(nifti_data_zstat1)), 46)
  expect_true("slice_code" %in% header_fields(nifti_data_filtered_func))
})

test_that("Header values", {
  skip_on_cran()
  expect_equal(header_value(nifti_data_filtered_func, "sizeof_hdr"), 348)
  expect_equal(header_value(nifti_data_filtered_func, "extender"), c(0,0,0,0))
  expect_equal(header_value(nifti_data_avg152T1_LR, "qoffset_x"), 0)
  expect_equal(header_value(nifti_data_avg152T1_LR, "descrip"), "FSL3.2beta")
  expect_equal(header_value(nifti_data_avg152T1_LR, "data_type"), "")
})

test_that("nifti_data_1103_3", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_1103_3), 332)
  expect_equal(img_dimensions(nifti_data_1103_3), c(256, 256, 332))
  expect_equal(nifti1_num_dim(nifti_data_1103_3), 3)
  expect_equal(length(header_fields(nifti_data_1103_3)), 46)
  expect_true("qoffset_x" %in% header_fields(nifti_data_1103_3))
  expect_equal(header_value(nifti_data_1103_3, "slice_code"), 0)
  expect_equal(length(nifti1_header_values(nifti_data_1103_3)), 46)
  expect_equal(nifti1_header_values(nifti_data_1103_3)[["regular"]], "r")
})

test_that("nifti_data_1103_3_glm", {
  skip_on_cran()
  expect_equal(nifti1_num_dim(nifti_data_1103_3_glm), 3)
  expect_equal(length(header_fields(nifti_data_1103_3_glm)), 46)
  expect_true("descrip" %in% header_fields(nifti_data_1103_3_glm))
  expect_equal(header_value(nifti_data_1103_3_glm, "quatern_b"), 0)
  expect_equal(length(nifti1_header_values(nifti_data_1103_3_glm)), 46)
  expect_equal(nifti1_header_values(nifti_data_1103_3_glm)[["bitpix"]], 16)
})

test_that("nifti_data_113_01_MPRAGE", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_113_01_MPRAGE), 256)
  expect_equal(img_dimensions(nifti_data_113_01_MPRAGE), c(170,256,256))
  expect_equal(nifti1_num_dim(nifti_data_113_01_MPRAGE), 3)
  expect_equal(header_value(nifti_data_113_01_MPRAGE, "slice_code"), 0)
})

test_that("nifti_data_113_01_MPRAGE_mask", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_113_01_MPRAGE_mask), 256)
  expect_equal(img_dimensions(nifti_data_113_01_MPRAGE_mask), c(170,256,256))
  expect_equal(length(nifti1_header_values(nifti_data_113_01_MPRAGE_mask)), 46)
  expect_equal(nifti1_header_values(nifti_data_113_01_MPRAGE_mask)[["vox_offset"]], 352)
})

test_that("nifti_data_avg152T1_LR", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_avg152T1_LR), 91)
  expect_equal(img_dimensions(nifti_data_avg152T1_LR), c(91,109,91))
  expect_equal(length(header_fields(nifti_data_avg152T1_LR)), 46)
  expect_true("scl_slope" %in% header_fields(nifti_data_avg152T1_LR))
  expect_equal(header_value(nifti_data_avg152T1_LR, "cal_min"), 0)
  expect_equal(length(nifti1_header_values(nifti_data_avg152T1_LR)), 46)
  expect_equal(nifti1_header_values(nifti_data_avg152T1_LR)[["cal_min"]], 0)
})

test_that("nifti_data_avg152T1_LR_hi", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_avg152T1_LR_hi), 91)
  expect_equal(img_dimensions(nifti_data_avg152T1_LR_hi), c(91,109,91))
  expect_equal(nifti1_num_dim(nifti_data_avg152T1_LR_hi), 3)
  expect_equal(header_fields(nifti_data_avg152T1_LR_hi), header_fields(nifti_data_avg152T1_LR))
  expect_true("glmin" %in% header_fields(nifti_data_avg152T1_LR_hi))
  expect_equal(header_value(nifti_data_avg152T1_LR_hi, "glmax"), 255)
  expect_equal(length(nifti1_header_values(nifti_data_avg152T1_LR_hi)), 46)
  expect_equal(nifti1_header_values(nifti_data_avg152T1_LR_hi)[["srow_z"]], c(0,0,2,-72))
})

test_that("nifti_data_avg152T1_RL", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_avg152T1_RL), c(91,109,91))
  expect_equal(header_value(nifti_data_avg152T1_RL, "descrip"), "FSL3.2beta")
})

test_that("nifti_data_avg152T1_RL_hi", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_avg152T1_RL_hi), c(91,109,91))
  expect_equal(header_value(nifti_data_avg152T1_RL_hi, "descrip"), "FSL3.2beta")
})

test_that("nifti_data_filtered_func", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_filtered_func), 21)
  expect_equal(img_dimensions(nifti_data_filtered_func), c(64,64,21,180))
  expect_equal(nifti1_num_dim(nifti_data_filtered_func), 4)
  expect_equal(header_value(nifti_data_filtered_func, "bitpix"), 16)
})

test_that("nifti_data_flair", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_flair), c(288,288,22))
})

test_that("nifti_data_flair_regToT1", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_flair_regToT1), 22)
  expect_equal(img_dimensions(nifti_data_flair_regToT1), c(512,512,22))
  expect_equal(nifti1_num_dim(nifti_data_flair_regToT1), 3)
  expect_equal(length(header_fields(nifti_data_flair_regToT1)), 46)
  expect_true("intent_p3" %in% header_fields(nifti_data_flair_regToT1))
  expect_equal(header_value(nifti_data_flair_regToT1, "quatern_c"), -0.9992785, tolerance = 1e-5)
  expect_equal(length(nifti1_header_values(nifti_data_flair_regToT1)), 46)
  expect_equal(nifti1_header_values(nifti_data_flair_regToT1)[["quatern_c"]], -0.9992785, tolerance = 1e-5)
})

test_that("nifti_data_FLIRT_113_01_T2w_regToT1", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_FLIRT_113_01_T2w_regToT1), c(170,256,256))
  expect_equal(length(nifti1_header_values(nifti_data_FLIRT_113_01_T2w_regToT1)), 46)
  expect_equal(nifti1_header_values(nifti_data_FLIRT_113_01_T2w_regToT1)[["srow_z"]], c(0,0,1,0))
})

test_that("nifti_data_JHU_MNI_SS_T1_brain", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_JHU_MNI_SS_T1_brain), c(181,217,181))
  expect_equal(header_value(nifti_data_JHU_MNI_SS_T1_brain, "cal_min"), 0)
})

test_that("nifti_data_JHU_MNI_SS_T1_mask", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_JHU_MNI_SS_T1_mask), c(181,217,181))
  expect_equal(header_value(nifti_data_JHU_MNI_SS_T1_mask, "sform_code"), 1)
})

test_that("sample_nifti_img - for CRAN", {
  expect_equal(num_slices(sample_nifti_img), 10)
  expect_equal(img_dimensions(sample_nifti_img), c(64,64,10))
  expect_equal(nifti1_num_dim(sample_nifti_img), 3)
  expect_equal(length(header_fields(sample_nifti_img)), 46)
  expect_true("srow_x" %in% header_fields(sample_nifti_img))
  expect_equal(header_value(sample_nifti_img, "cal_min"), 0)
  expect_equal(length(nifti1_header_values(sample_nifti_img)), 46)
  expect_equal(nifti1_header_values(sample_nifti_img)[["magic"]], "n+1")
})

test_that("sample_nifti_img_hi", {
  skip_on_cran()
  expect_equal(nifti1_num_dim(sample_nifti_img_hi), 3)
  expect_equal(header_value(sample_nifti_img_hi, "descrip"), "")
  expect_equal(header_value(sample_nifti_img_hi, "aux_file"), "")
  expect_equal(header_value(sample_nifti_img_hi, "qoffset_z"), 0)
  expect_equal(nifti1_header_values(sample_nifti_img_hi)[["quatern_c"]], 0)
})

test_that("nifti_data_MNI152_T1_1mm_brain", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_MNI152_T1_1mm_brain), 182)
  expect_equal(img_dimensions(nifti_data_MNI152_T1_1mm_brain), c(182,218,182))
  expect_equal(nifti1_num_dim(nifti_data_MNI152_T1_1mm_brain), 3)
  expect_equal(header_value(nifti_data_MNI152_T1_1mm_brain, "descrip"), "FSL3.3")
})

test_that("nifti_data_roi", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_roi), c(288,288,22))
  expect_equal(header_value(nifti_data_roi, "srow_z"), c(0.01915708,-0.05750556,5.98269606,-25.41534996), tolerance = 1e-5)
})

test_that("nifti_data_roi_regToT1_SyNtoMNI", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_roi_regToT1_SyNtoMNI), c(182,218,182))
  expect_equal(length(header_fields(nifti_data_roi_regToT1_SyNtoMNI)), 46)
  expect_true("sform_code" %in% header_fields(nifti_data_roi_regToT1_SyNtoMNI))
  expect_equal(length(nifti1_header_values(nifti_data_roi_regToT1_SyNtoMNI)), 46)
  expect_equal(nifti1_header_values(nifti_data_roi_regToT1_SyNtoMNI)[["cal_min"]], 0)
})

test_that("nifti_data_sirp", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_sirp), 35)
  expect_equal(img_dimensions(nifti_data_sirp), c(64,64,35,147))
  expect_equal(nifti1_num_dim(nifti_data_sirp), 4)
  expect_equal(header_value(nifti_data_sirp, "glmin"), 0)
})

test_that("nifti_data_t1", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_t1), c(512,512,22))
  expect_equal(header_value(nifti_data_t1, "xyzt_units"), 10)
})

test_that("nifti_data_t1_SyNtoMNI", {
  skip_on_cran()
  expect_equal(num_slices(nifti_data_t1_SyNtoMNI), 182)
  expect_equal(img_dimensions(nifti_data_t1_SyNtoMNI), c(182,218,182))

})

test_that("nifti_data_zstat1", {
  skip_on_cran()
  expect_equal(img_dimensions(nifti_data_zstat1), c(64,64,21))
  expect_equal(header_value(nifti_data_zstat1, "magic"), "n+1")
})



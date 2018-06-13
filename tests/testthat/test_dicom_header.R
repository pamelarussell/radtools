
# Setup

dir_prostate_dicom <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/nci_isbi_2013_challenge_prostate/images_dicom/"
dir_prostate_dicom_3T_03_0001 <-
  paste(dir_prostate_dicom,
        "Prostate3T-03-0001/1.3.6.1.4.1.14519.5.2.1.7307.2101.182382809090179976301292139745/1.3.6.1.4.1.14519.5.2.1.7307.2101.287009217605941401146066177219",
        sep = "/")
dicom_data_3T_03_0001 <- read_dicom(dir_prostate_dicom_3T_03_0001)


# Tests

test_that("DICOM standard website", {
  expect_true(grepl("http", dicom_standard_web()))
})

test_that("DICOM standard version", {
  expect_true(grepl("20", dicom_standard_version()))
})

test_that("DICOM standard timestamp", {
  expect_true(grepl("20", dicom_standard_timestamp()))
})

test_that("Number of slices", {
  expect_equal(num_slices(dicom_data_3T_03_0001), 19)
})

test_that("DICOM header fields", {
  fields <- header_fields(dicom_data_3T_03_0001)
  expect_equal(length(fields), 111)
  expect_true("DeidentificationMethod" %in% fields)
  expect_true(!"xxx" %in% fields)
})

test_that("Validate header", {
  expect_silent(validate_keyword("PixelBandwidth"))
  expect_error(validate_keyword("xxx"))
  expect_warning(validate_keyword("xxx", stop = FALSE))
  expect_silent(validate_tag("(0008,0304)"))
  expect_error(validate_tag("(0000,0000)"))
  expect_warning(validate_tag("(0000,0000)", stop = FALSE))
  expect_silent(validate_group_element("0008", "0304"))
  expect_error(validate_group_element("0000", "0000"))
  expect_error(validate_group_element("0000", stop = FALSE))
  expect_warning(validate_group_element("0000", "0000", stop = FALSE))
  expect_error(validate_header_elements(dicom_data_3T_03_0001))
  expect_warning(validate_header_elements(dicom_data_3T_03_0001, stop = FALSE))
})

test_that("DICOM header values", {
  slice_idx <- 5
  field_idx <- 100
  field <- dicom_data_3T_03_0001$hdr[[slice_idx]]$name[[field_idx]]
  value <- dicom_data_3T_03_0001$hdr[[slice_idx]]$value[[field_idx]]
  expect_equal(header_values(dicom_data_3T_03_0001, field, numeric = FALSE)[[slice_idx]], value)
  expect_equal(header_values(dicom_data_3T_03_0001, "PixelBandwidth"), rep(200, 19))
  expect_equal(header_values(dicom_data_3T_03_0001, "PixelBandwidth", numeric = FALSE), rep("200", 19))
  expect_error(header_values(dicom_data_3T_03_0001, "xxx"))
})

test_that("DICOM header as matrix", {
  mat1 <- header_as_matrix(dicom_data_3T_03_0001, 1)
  expect_equal(ncol(mat1), 7)
  expect_gt(nrow(mat1), 100)
  expect_gt(nrow(mat1 %>% filter(name == "CodeMeaning")), 1)
  mat <- header_as_matrix(dicom_data_3T_03_0001)
  expect_equal(ncol(mat), 23)
  expect_gt(nrow(mat1), nrow(mat))
  expect_equal(nrow(mat %>% filter(name == "CodeMeaning")), 0)
  v1 <- mat %>% filter(name == "InstanceCreationTime") %>% select("slice_2")
  expect_equal(v1[1,1], "091612.484000")
  expect_equal(nrow(mat), nrow(mat %>% select(group, element, name) %>% unique()))
})

test_that("Valid header elements from DICOM standard", {
  keywords <- all_valid_header_keywords()
  names <- all_valid_header_names()
  tags <- all_valid_header_tags()
  expect_true("MappingResourceName" %in% keywords)
  expect_true("Equipment Modality" %in% names)
  expect_true("(0008,030E)" %in% tags)
})

test_that("DICOM header tag", {
  expect_error(header_tag("1111"))
  expect_error(header_tag("1111", "xxxx"))
  expect_error(header_tag("xxxx", "1111"))
  expect_equal(header_tag("0000", "1111"), "(0000,1111)")
})

test_that("Search keyword", {
  res_kw <- search_header_keywords("width")
  res_name <- search_header_names("width")
  expect_true("ChannelWidth" %in% res_kw)
  expect_true("Channel Width" %in% res_name)
  expect_equal(length(search_header_keywords("xxxxx")), 0)
  expect_equal(length(search_header_names("xxxxx")), 0)
})


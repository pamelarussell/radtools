
# Setup: datasets

# NCI ISBI prostate challenge
# Modality: MR
# Body part: prostate
# Manufacturer: Siemens
dir_prostate_dicom_mr <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/nci_isbi_2013_challenge_prostate/images_dicom/"
dir_prostate_dicom_mr <-
  paste(dir_prostate_dicom_mr,
        "Prostate3T-03-0001/1.3.6.1.4.1.14519.5.2.1.7307.2101.182382809090179976301292139745/1.3.6.1.4.1.14519.5.2.1.7307.2101.287009217605941401146066177219",
        sep = "/")
dicom_data_prostate_mr <- read_dicom(dir_prostate_dicom_mr)

# LIDC-IDRI
# TCIA series instance UID 1.3.6.1.4.1.14519.5.2.1.6279.6001.140253591510022414496468423138
# Modality: CT
# Body part: chest
# Manufacturer: GE Medical Systems
dir_chest_dicom <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/lidc_idri_chest_ct/1.3.6.1.4.1.14519.5.2.1.6279.6001.140253591510022414496468423138"
dicom_data_chest <- read_dicom(dir_chest_dicom)

# NaF Prostate
# TCIA series instance UID 1.3.6.1.4.1.14519.5.2.1.9823.8001.580231868964887648671150773545
# Modality: PET
# Body part: Prostate
# Manufacturer: Philips Medical Systems
dir_prostate_pt_dicom <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/naf_prostate_pt/1.3.6.1.4.1.14519.5.2.1.9823.8001.580231868964887648671150773545"
dicom_data_prostate_pt <- read_dicom(dir_prostate_pt_dicom)

# TCGA-BLCA
# TCIA series instance UID 1.3.6.1.4.1.14519.5.2.1.8421.4016.922520924373492766630626617012
# Modality: CR
# Body part: bladder
# Manufacturer: Fujifilm
dir_bladder_dicom <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/tcga_blca_cr/1.3.6.1.4.1.14519.5.2.1.8421.4016.922520924373492766630626617012"
dicom_data_bladder <- read_dicom(dir_bladder_dicom)

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
  expect_equal(num_slices(dicom_data_prostate_mr), 19)
  expect_equal(num_slices(dicom_data_bladder), 1)
  expect_equal(num_slices(dicom_data_chest), 128)
  expect_equal(num_slices(dicom_data_prostate_pt), 234)
})

test_that("DICOM header fields", {
  fieldsp <- dicom_header_fields(dicom_data_prostate_mr)
  expect_equal(length(fieldsp), 111)
  expect_true("DeidentificationMethod" %in% fieldsp)
  expect_true(!"xxx" %in% fieldsp)
  fieldsc <- dicom_header_fields(dicom_data_chest)
  expect_equal(length(fieldsc), 94)
  expect_true("BodyPartExamined" %in% fieldsc)
  expect_true(!"Unknown" %in% fieldsc)
})

test_that("Validate header", {
  expect_silent(dicom_validate_keyword("PixelBandwidth"))
  expect_error(dicom_validate_keyword("xxx"))
  expect_warning(dicom_validate_keyword("xxx", stop = FALSE))
  expect_silent(dicom_validate_tag("(0008,0304)"))
  expect_error(dicom_validate_tag("(0000,0000)"))
  expect_warning(dicom_validate_tag("(0000,0000)", stop = FALSE))
  expect_silent(dicom_validate_group_element("0008", "0304"))
  expect_error(dicom_validate_group_element("0000", "0000"))
  expect_error(dicom_validate_group_element("0000", stop = FALSE))
  expect_warning(dicom_validate_group_element("0000", "0000", stop = FALSE))
  expect_error(dicom_validate_header_elements(dicom_data_prostate_mr))
  expect_warning(dicom_validate_header_elements(dicom_data_prostate_mr, stop = FALSE))
  expect_error(dicom_validate_header_elements(dicom_data_bladder))
  expect_warning(dicom_validate_header_elements(dicom_data_bladder, stop = FALSE))
})

test_that("DICOM header values", {
  slice_idx <- 5
  field_idx <- 100

  field <- dicom_data_prostate_mr$hdr[[slice_idx]]$name[[field_idx]]
  value <- dicom_data_prostate_mr$hdr[[slice_idx]]$value[[field_idx]]
  expect_equal(dicom_header_values(dicom_data_prostate_mr, field, numeric = FALSE)[[slice_idx]], value)
  expect_equal(dicom_header_values(dicom_data_prostate_mr, "PixelBandwidth"), rep(200, 19))
  expect_equal(dicom_header_values(dicom_data_prostate_mr, "PixelBandwidth", numeric = FALSE), rep("200", 19))
  expect_error(dicom_header_values(dicom_data_prostate_mr, "xxx"))

  fieldb <- dicom_data_bladder$hdr[[1]]$name[[field_idx]]
  valb <- dicom_data_bladder$hdr[[1]]$value[[field_idx]]
  expect_equal(dicom_header_values(dicom_data_bladder, fieldb, numeric = FALSE)[[1]], valb)
  expect_equal(dicom_header_values(dicom_data_bladder, "SeriesDate"), 20020816)
  expect_equal(dicom_header_values(dicom_data_bladder, "SeriesDate", numeric = FALSE), "20020816")
  expect_error(dicom_header_values(dicom_data_bladder, "Unknown"))

  fieldp <- dicom_data_prostate_pt$hdr[[slice_idx]]$name[[field_idx]]
  valp <- dicom_data_prostate_pt$hdr[[slice_idx]]$value[[field_idx]]
  expect_equal(dicom_header_values(dicom_data_prostate_pt, fieldp, numeric = FALSE)[[slice_idx]], valp)
  expect_equal(dicom_header_values(dicom_data_prostate_pt, "GroupLength"), rep(196,234))
  expect_equal(dicom_header_values(dicom_data_prostate_pt, "GroupLength", numeric = FALSE), rep("196",234))
  expect_error(dicom_header_values(dicom_data_prostate_pt, "Unknown"))
})

test_that("DICOM header as matrix", {
  mat1 <- dicom_header_as_matrix(dicom_data_prostate_mr, 1)
  expect_equal(ncol(mat1), 7)
  expect_gt(nrow(mat1), 100)
  expect_gt(nrow(mat1 %>% dplyr::filter(name == "CodeMeaning")), 1)
  mat <- dicom_header_as_matrix(dicom_data_prostate_mr)
  expect_equal(ncol(mat), 23)
  expect_gt(nrow(mat1), nrow(mat))
  expect_equal(nrow(mat %>% dplyr::filter(name == "CodeMeaning")), 0)
  v1 <- mat %>% dplyr::filter(name == "InstanceCreationTime") %>% dplyr::select("slice_2")
  expect_equal(v1[1,1], "091612.484000")
  expect_equal(nrow(mat), nrow(mat %>% dplyr::select(group, element, name) %>% unique()))

  mat1b <- dicom_header_as_matrix(dicom_data_bladder, 1)
  matb <- dicom_header_as_matrix(dicom_data_bladder)
  expect_equal(nrow(mat1b %>% dplyr::filter(name == "CodeMeaning")), 7)
  expect_equal(nrow(matb %>% dplyr::filter(name == "CodeMeaning")), 0)
  expect(ncol(matb %>% dplyr::select(dplyr::starts_with("slice"))), 1)

  mat10c <- dicom_header_as_matrix(dicom_data_chest, 10)
  matc <- dicom_header_as_matrix(dicom_data_chest)
  expect(ncol(matc %>% dplyr::select(dplyr::starts_with("slice"))), 128)
  expect_equal(mat10c[9,6], "ORIGINAL PRIMARY AXIAL")
})

test_that("Valid header elements from DICOM standard", {
  keywords <- dicom_all_valid_header_keywords()
  names <- dicom_all_valid_header_names()
  tags <- dicom_all_valid_header_tags()
  expect_true("MappingResourceName" %in% keywords)
  expect_true("Equipment Modality" %in% names)
  expect_true("(0008,030E)" %in% tags)
})

test_that("DICOM header tag", {
  expect_error(dicom_header_tag("1111"))
  expect_error(dicom_header_tag("1111", "xxxx"))
  expect_error(dicom_header_tag("xxxx", "1111"))
  expect_equal(dicom_header_tag("0000", "1111"), "(0000,1111)")
})

test_that("Search keyword", {
  res_kw <- dicom_search_header_keywords("width")
  res_name <- dicom_search_header_names("width")
  expect_true("ChannelWidth" %in% res_kw)
  expect_true("Channel Width" %in% res_name)
  expect_equal(length(dicom_search_header_names("xxxxx")), 0)
  expect_equal(length(dicom_search_header_names("xxxxx")), 0)
})

test_that("Constant header values", {
  const_val <- dicom_constant_header_values(dicom_data_prostate_mr)
  expect_null(const_val[["Unknown"]])
  expect_equal(const_val[["GroupLength"]], 196)
  expect_equal(dicom_constant_header_values(dicom_data_prostate_mr, numeric = FALSE)[["GroupLength"]], "196")
  expect_null(const_val[["SliceLocation"]])

  const_valb <- dicom_constant_header_values(dicom_data_bladder)
  expect_equal(length(const_valb),
               nrow(
                 dicom_header_as_matrix(dicom_data_bladder) %>%
                   dplyr::group_by(name) %>%
                   dplyr::summarize(n = n()) %>%
                   dplyr::filter(n == 1)))
  expect_equal(const_valb$AcquisitionDate, 20020816)
  expect_equal(dicom_constant_header_values(dicom_data_bladder, numeric = F)[["AcquisitionDate"]], "20020816")

  const_valc <- dicom_constant_header_values(dicom_data_chest)
  expect_null(const_valc[["Unknown"]])
  expect_equal(const_valc[["StudyDate"]], 20000101)
  expect_equal(dicom_constant_header_values(dicom_data_chest, numeric = FALSE)[["SeriesDate"]], "20000101")
  expect_null(const_valc[["SliceLocation"]])

})


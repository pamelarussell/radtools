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

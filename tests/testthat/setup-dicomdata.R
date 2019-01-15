
# Note: explicitly set environment variable NOT_CRAN to "true" (e.g. on command line) to run skipped tests

if(identical(tolower(Sys.getenv("NOT_CRAN")), "true")) {

  # Series 1.2.276.0.7230010.3.1.3.8323329.18438.1440001309.981882 from TCIA; a DICOM SR object with no slices
  dir_qin_headneck_sr <<- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/qin_headneck_sr"
  dicom_data_qin_hn_sr <<- read_dicom(paste(dir_qin_headneck_sr, "1-234.dcm", sep = "/"))

  # Images from http://barre.nom.fr/medical/samples/
  dir_s_barre_dicom <<- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/s_barre_medical_image_samples/"
  dicom_data_sbarre_ort <<- read_dicom(paste(dir_s_barre_dicom, "CT-MONO2-16-ort", sep = "/"))
  dicom_data_sbarre_brain <<- read_dicom(paste(dir_s_barre_dicom, "CT-MONO2-16-brain", sep = "/"))
  dicom_data_sbarre_head <<- read_dicom(paste(dir_s_barre_dicom, "MR-MONO2-16-head", sep = "/"))
  dicom_data_sbarre_knee <<- read_dicom(paste(dir_s_barre_dicom, "MR-MONO2-16-knee", sep = "/"))
  dicom_data_sbarre_heart_mr <<- read_dicom(paste(dir_s_barre_dicom, "MR-MONO2-8-16x-heart", sep = "/"))
  dicom_data_sbarre_heart_nm <<- read_dicom(paste(dir_s_barre_dicom, "NM-MONO2-16-13x-heart", sep = "/"))
  dicom_data_sbarre_execho <<- read_dicom(paste(dir_s_barre_dicom, "US-MONO2-8-8x-execho", sep = "/"))

  # Images from http://www.dclunie.com/
  dir_d_clunie_dicom <<- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/d_clunie_samples/"
  dir_d_clunie_dicom_charset <<- paste(dir_d_clunie_dicom, "charsettests", sep = "/")
  dir_d_clunie_dicom_deflate <<- paste(dir_d_clunie_dicom, "deflate_tests", sep = "/")
  dir_d_clunie_dicom_signedrange <<- paste(dir_d_clunie_dicom, "signedrangeimages/IMAGES", sep = "/")
  dicom_data_dclunie_scsgreek <<- read_dicom(paste(dir_d_clunie_dicom_charset, "SCSGREEK", sep = "/"))
  dicom_data_dclunie_scsx2 <<- read_dicom(paste(dir_d_clunie_dicom_charset, "SCSX2", sep = "/"))
  dicom_data_dclunie_image <<- read_dicom(paste(dir_d_clunie_dicom_deflate, "image", sep = "/"))
  for(dir in list.files(dir_d_clunie_dicom_signedrange, full.names = T)) {
    dd <<- read_dicom(dir)
    rm(dd)
  }

  # 98890234_20030505_MR
  dir_988_dicom <<- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/98890234_20030505_MR/98890234/20030505/MR/"
  for(dir in list.files(dir_988_dicom, full.names = T)) {
    dd <<- read_dicom(dir)
    rm(dd)
  }
  # dicom_data_988_MR1 <<- read_dicom(paste(dir_988_dicom, "MR1", sep = "/")) # Include with package
  dicom_data_988_MR700 <<- read_dicom(paste(dir_988_dicom, "MR700", sep = "/"))

  # 24759123_20010101
  dir_247_dicom <<- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/24759123_20010101/24759123/20010101/"
  for(dir in list.files(dir_247_dicom, full.names = T)) {
    dd <<- read_dicom(dir)
    rm(dd)
  }
  dicom_data_247_MR3 <<- read_dicom(paste(dir_247_dicom, "MR3", sep = "/"))
  dicom_data_247_OT <<- read_dicom(paste(dir_247_dicom, "OT999999", sep = "/"))

  # NCI ISBI prostate challenge
  # Modality: MR
  # Body part: prostate
  # Manufacturer: Siemens
  dir_prostate_dicom_mr <<- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/nci_isbi_2013_challenge_prostate/images_dicom/"
  dir_prostate_dicom_mr <<-
    paste(dir_prostate_dicom_mr,
          "Prostate3T-03-0001/1.3.6.1.4.1.14519.5.2.1.7307.2101.182382809090179976301292139745/1.3.6.1.4.1.14519.5.2.1.7307.2101.287009217605941401146066177219",
          sep = "/")
  dicom_data_prostate_mr <<- read_dicom(dir_prostate_dicom_mr)

  # LIDC-IDRI
  # TCIA series instance UID 1.3.6.1.4.1.14519.5.2.1.6279.6001.140253591510022414496468423138
  # Modality: CT
  # Body part: chest
  # Manufacturer: GE Medical Systems
  dir_chest_dicom <<- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/lidc_idri_chest_ct/1.3.6.1.4.1.14519.5.2.1.6279.6001.140253591510022414496468423138"
  dicom_data_chest <<- read_dicom(dir_chest_dicom)

  # NaF Prostate
  # TCIA series instance UID 1.3.6.1.4.1.14519.5.2.1.9823.8001.580231868964887648671150773545
  # Modality: PET
  # Body part: Prostate
  # Manufacturer: Philips Medical Systems
  dir_prostate_pt_dicom <<- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/naf_prostate_pt/1.3.6.1.4.1.14519.5.2.1.9823.8001.580231868964887648671150773545"
  dicom_data_prostate_pt <<- read_dicom(dir_prostate_pt_dicom)

  # TCGA-BLCA
  # TCIA series instance UID 1.3.6.1.4.1.14519.5.2.1.8421.4016.922520924373492766630626617012
  # Modality: CR
  # Body part: bladder
  # Manufacturer: Fujifilm
  dir_bladder_dicom <<- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/tcga_blca_cr/1.3.6.1.4.1.14519.5.2.1.8421.4016.922520924373492766630626617012"
  dicom_data_bladder <<- read_dicom(dir_bladder_dicom)
}


# Note: explicitly set environment variable NOT_CRAN to "true" (e.g. on command line) to run skipped tests


# Make temp directory to store images from web
outdir_dicom <- tempfile()
dir.create(outdir_dicom, recursive = TRUE)


# Images from http://barre.nom.fr/medical/samples/
url_sbarre <- "http://barre.nom.fr/medical/samples/files/"
sbarre_samples <- list(ort = "CT-MONO2-16-ort",
                       brain = "CT-MONO2-16-brain",
                       head = "MR-MONO2-16-head",
                       knee = "MR-MONO2-16-knee",
                       heart_mr = "MR-MONO2-8-16x-heart",
                       heart_nm = "NM-MONO2-16-13x-heart",
                       execho = "US-MONO2-8-8x-execho")
sbarre_url_sample <- function(sample) {paste(url_sbarre, sample, ".gz", sep = "")}
sbarre_unzip_file <- function(sample) {paste(outdir_dicom, sample, sep = "/")}
sbarre_zip_file <- function(sample) {paste(sbarre_unzip_file(sample), ".gz", sep = "")}
for(sample in sbarre_samples) {
  download.file(sbarre_url_sample(sample), sbarre_zip_file(sample))
  R.utils::gunzip(sbarre_zip_file(sample))
}
dicom_data_sbarre_ort <<- read_dicom(sbarre_unzip_file(sbarre_samples$ort))
dicom_data_sbarre_brain <<- read_dicom(sbarre_unzip_file(sbarre_samples$brain))
dicom_data_sbarre_head <<- read_dicom(sbarre_unzip_file(sbarre_samples$head))
dicom_data_sbarre_knee <<- read_dicom(sbarre_unzip_file(sbarre_samples$knee))
dicom_data_sbarre_heart_mr <<- read_dicom(sbarre_unzip_file(sbarre_samples$heart_mr))
dicom_data_sbarre_heart_nm <<- read_dicom(sbarre_unzip_file(sbarre_samples$heart_nm))
dicom_data_sbarre_execho <<- read_dicom(sbarre_unzip_file(sbarre_samples$execho))


# Images from http://www.dclunie.com/
d_clunie_tar_charset <- paste(outdir_dicom, "charsettests.20070405.tar.bz2", sep = "/")
d_clunie_tar_deflate <- paste(outdir_dicom, "deflate_tests_release.tar.gz", sep = "/")
d_clunie_tar_signedrange <- paste(outdir_dicom, "signedrangeimages.tar.bz2", sep = "/")
download.file("http://www.dclunie.com/images/charset/charsettests.20070405.tar.bz2", d_clunie_tar_charset)
download.file("http://www.dclunie.com/images/compressed/deflate_tests_release.tar.gz", d_clunie_tar_deflate)
download.file("http://www.dclunie.com/images/signedrange/signedrangeimages.tar.bz2", d_clunie_tar_signedrange)
untar(d_clunie_tar_charset, exdir = outdir_dicom)
untar(d_clunie_tar_deflate, exdir = outdir_dicom)
untar(d_clunie_tar_signedrange, exdir = outdir_dicom)
dir_d_clunie_dicom_charset <<- paste(outdir_dicom, "charsettests", sep = "/")
dir_d_clunie_dicom_deflate <<- paste(outdir_dicom, "deflate_tests", sep = "/")
dir_d_clunie_dicom_signedrange <<- paste(outdir_dicom, "IMAGES", sep = "/")
dicom_data_dclunie_scsgreek <<- read_dicom(paste(dir_d_clunie_dicom_charset, "SCSGREEK", sep = "/"))
dicom_data_dclunie_scsx2 <<- read_dicom(paste(dir_d_clunie_dicom_charset, "SCSX2", sep = "/"))
dicom_data_dclunie_image <<- read_dicom(paste(dir_d_clunie_dicom_deflate, "image", sep = "/"))
for(dir in list.files(dir_d_clunie_dicom_signedrange, full.names = T)) {
  dd <<- read_dicom(dir)
  rm(dd)
}


# Images from patient contributed image repository http://www.pcir.org/
pcir_tar_988 <- paste(outdir_dicom, "98890234_20030505_MR.tar.bz2", sep = "")
pcir_tar_247 <- paste(outdir_dicom, "24759123_20010101.tar.bz2", sep = "")
download.file("https://archive.org/download/9889023420030505MR/98890234_20030505_MR.tar.bz2", pcir_tar_988)
download.file("https://archive.org/download/2475912320010101/24759123_20010101.tar.bz2", pcir_tar_247)
untar(pcir_tar_988, exdir = outdir_dicom)
untar(pcir_tar_247, exdir = outdir_dicom)
dir_pcir_988 <- paste(outdir_dicom, "98890234/20030505/MR/", sep = "/")
dir_pcir_247 <- paste(outdir_dicom, "24759123/20010101/", sep = "/")
# 98890234_20030505_MR
for(dir in list.files(dir_pcir_988, full.names = T)) {
  dd <<- read_dicom(dir)
  rm(dd)
}
# dicom_data_988_MR1 <<- read_dicom(paste(dir_pcir_988, "MR1", sep = "/")) # Include with package
dicom_data_988_MR700 <<- read_dicom(paste(dir_pcir_988, "MR700", sep = "/"))
# 24759123_20010101
for(dir in list.files(dir_pcir_247, full.names = T)) {
  dd <<- read_dicom(dir)
  rm(dd)
}
dicom_data_247_MR3 <<- read_dicom(paste(dir_pcir_247, "MR3", sep = "/"))
dicom_data_247_OT <<- read_dicom(paste(dir_pcir_247, "OT999999", sep = "/"))



# TCIA datasets can't be downloaded on the fly
if(identical(tolower(Sys.getenv("NOT_CRAN")), "true")) {

  # Series 1.2.276.0.7230010.3.1.3.8323329.18438.1440001309.981882 from TCIA; a DICOM SR object with no slices
  dir_qin_headneck_sr <<- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/dicom/qin_headneck_sr"
  dicom_data_qin_hn_sr <<- read_dicom(paste(dir_qin_headneck_sr, "1-234.dcm", sep = "/"))

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



# Make temp directory to store images from web
outdir_nifti <- tempfile()
dir.create(outdir_nifti, recursive = TRUE)



# https://nifti.nimh.nih.gov/nifti-1/data
url_nimh <- "https://nifti.nimh.nih.gov/nifti-1/data/"
download_nimh <- function(base, extension) {
  name <- paste(base, extension, sep = ".")
  name_gz <- paste(name, "gz", sep = ".")
  gz <- paste(outdir_nifti, name_gz, sep = "/")
  download.file(paste(url_nimh, name_gz, sep = "/"), gz)
  R.utils::gunzip(gz)
}
# avg152T1_LR
avg152T1_LR_hdr <- download_nimh("avg152T1_LR_nifti", "hdr")
avg152T1_LR_img <- download_nimh("avg152T1_LR_nifti", "img")
avg152T1_LR_nii <- download_nimh("avg152T1_LR_nifti", "nii")
avg152T1_LR_base <- gsub(".hdr", "", avg152T1_LR_hdr)
nifti_data_avg152T1_LR_hi <- read_nifti1(avg152T1_LR_base)
nifti_data_avg152T1_LR <- read_nifti1(avg152T1_LR_nii)
# avg152T1_RL
avg152T1_RL_hdr <- download_nimh("avg152T1_RL_nifti", "hdr")
avg152T1_RL_img <- download_nimh("avg152T1_RL_nifti", "img")
avg152T1_RL_nii <- download_nimh("avg152T1_RL_nifti", "nii")
avg152T1_RL_base <- gsub(".hdr", "", avg152T1_RL_hdr)
nifti_data_avg152T1_RL_hi <- read_nifti1(avg152T1_RL_base)
nifti_data_avg152T1_RL <- read_nifti1(avg152T1_RL_nii)
# filtered_func_data
filtered_func <- download_nimh("filtered_func_data", "nii")
nifti_data_filtered_func <- read_nifti1(filtered_func)
# minimal data
minimal_base <- paste(outdir_nifti, "minimal", sep = "/")
minimal <- download_nimh("minimal", "hdr")
minimal <- download_nimh("minimal", "img")
nifti_data_minimal_hi <- read_nifti1(minimal_base)
# SIRP
sirp_gz <- paste(outdir_nifti, "sirp_fmri_study_ver4.tar.gz", sep = "/")
sirp_file <- paste(outdir_nifti, "newsirp_final_XML.nii", sep = "/")
download.file("https://nifti.nimh.nih.gov/nifti-1/data/sirp_fmri_study_ver4.tar.gz", sirp_gz)
untar(sirp_gz, exdir = outdir_nifti)
nifti_data_sirp <- read_nifti1(sirp_file, reorient = F)
# zstat1
zstat1_nii <- download_nimh("zstat1", "nii")
nifti_data_zstat1 <- read_nifti1(zstat1_nii)



# http://www.neuromorphometrics.com/?page_id=310
file_1103 <- paste(outdir_nifti, "Data/1103/3/NIFTI/1103_3.nii", sep = "/")
file_1103_glm <- paste(outdir_nifti, "Data/1103/3/NIFTI/1103_3_glm.nii", sep = "/")
gz_1103 <- paste(outdir_nifti, "1103_3.tgz", sep = "/")
download.file("http://www.neuromorphometrics.com/1103_3.tgz", gz_1103)
untar(gz_1103, exdir = outdir_nifti)
nifti_data_1103_3 <- read_nifti1(file_1103)
nifti_data_1103_3_glm <- read_nifti1(file_1103_glm)



# https://github.com/muschellij2/Neurohacking_data/tree/master/BRAINIX/NIfTI
download_jm <- function(path, outfile) {
  saved_file <- paste(outdir_nifti, outfile, sep = "/")
  download.file(paste("https://github.com/muschellij2/Neurohacking_data/raw/master/", path, sep = "/"),
                saved_file)
  saved_file
}
nifti_data_flair <- read_nifti1(download_jm("BRAINIX/NIfTI/FLAIR.nii.gz", "FLAIR.nii.gz"), reorient = F)
nifti_data_flair_regToT1 <- read_nifti1(download_jm("BRAINIX/NIfTI/FLAIR_regToT1.nii.gz", "FLAIR_regToT1.nii.gz"), reorient = F)
nifti_data_roi <- read_nifti1(download_jm("BRAINIX/NIfTI/ROI.nii.gz", "ROI.nii.gz"), reorient = F)
nifti_data_roi_regToT1_SyNtoMNI <- read_nifti1(download_jm("BRAINIX/NIfTI/ROI_regToT1_SyNtoMNI.nii.gz", "ROI_regToT1_SyNtoMNI.nii.gz"))
nifti_data_t1 <- read_nifti1(download_jm("BRAINIX/NIfTI/T1.nii.gz", "T1.nii.gz"), reorient = F)
nifti_data_t1_SyNtoMNI <- read_nifti1(download_jm("BRAINIX/NIfTI/T1_SyNtoMNI.nii.gz", "T1_SyNtoMNI.nii.gz"))


# https://github.com/muschellij2/Neurohacking_data/tree/master/Template
nifti_data_JHU_MNI_SS_T1_brain <- read_nifti1(download_jm("Template/JHU_MNI_SS_T1_brain.nii.gz", "JHU_MNI_SS_T1_brain.nii.gz"))
nifti_data_JHU_MNI_SS_T1_mask <- read_nifti1(download_jm("Template/JHU_MNI_SS_T1_mask.nii.gz", "JHU_MNI_SS_T1_mask.nii.gz"))
nifti_data_MNI152_T1_1mm_brain <- read_nifti1(download_jm("Template/MNI152_T1_1mm_brain.nii.gz", "MNI152_T1_1mm_brain.nii.gz"))


# https://github.com/muschellij2/Neurohacking_data/tree/master/kirby21/visit_1/113
nifti_data_113_01_MPRAGE <- read_nifti1(download_jm("kirby21/visit_1/113/113-01-MPRAGE.nii.gz", "113-01-MPRAGE.nii.gz"))
nifti_data_113_01_MPRAGE_mask <- read_nifti1(download_jm("kirby21/visit_1/113/113-01-MPRAGE_mask.nii.gz", "113-01-MPRAGE_mask.nii.gz"))
nifti_data_FLIRT_113_01_T2w_regToT1 <- read_nifti1(download_jm("kirby21/visit_1/113/FLIRT_113-01-T2w_regToT1.nii.gz", "FLIRT_113-01-T2w_regToT1.nii.gz"))


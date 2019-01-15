
# Note: explicitly set environment variable NOT_CRAN to "true" (e.g. on command line) to run skipped tests

if(identical(tolower(Sys.getenv("NOT_CRAN")), "true")) {

  dir_nifti1 <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/nifti-1/"
  dir_nifti2 <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/nifti-2/"

  # https://nifti.nimh.nih.gov/nifti-1/data
  # avg152T1_LR
  avg152T1_LR_base <- paste(dir_nifti1, "avg152T1_LR_nifti", sep = "/")
  avg152T1_LR_nii <- paste(avg152T1_LR_base, ".nii", sep = "")
  nifti_data_avg152T1_LR_hi <- read_nifti1(avg152T1_LR_base)
  nifti_data_avg152T1_LR <- read_nifti1(avg152T1_LR_nii)
  # avg152T1_RL
  avg152T1_RL_base <- paste(dir_nifti1, "avg152T1_LR_nifti", sep = "/")
  avg152T1_RL_nii <- paste(avg152T1_RL_base, ".nii.gz", sep = "")
  nifti_data_avg152T1_RL <- read_nifti1(avg152T1_RL_nii)
  nifti_data_avg152T1_RL_hi <- read_nifti1(avg152T1_RL_base)
  # filtered_func_data
  filtered_func <- paste(dir_nifti1, "filtered_func_data.nii.gz", sep = "/")
  nifti_data_filtered_func <- read_nifti1(filtered_func)
  # minimal data
  minimal_base <- paste(dir_nifti1, "minimal", sep = "/")
  minimal_nii <- paste(minimal_base, ".nii.gz", sep = "")
  # nifti_data_minimal <- read_nifti1(minimal_nii) # Include with package
  nifti_data_minimal_hi <- read_nifti1(minimal_base)
  # SIRP
  nifti_data_sirp <- read_nifti1(paste(dir_nifti1, "newsirp_final_XML.nii", sep = "/"), reorient = F)
  # zstat1
  zstat1 <- paste(dir_nifti1, "zstat1.nii.gz", sep = "/")
  nifti_data_zstat1 <- read_nifti1(zstat1)

  # http://www.neuromorphometrics.com/?page_id=310
  nifti_data_1103_3 <- read_nifti1(paste(dir_nifti1, "1103_3.nii", sep = "/"))
  nifti_data_1103_3_glm <- read_nifti1(paste(dir_nifti1, "1103_3_glm.nii", sep = "/"))

  # https://github.com/muschellij2/Neurohacking_data/tree/master/BRAINIX/NIfTI
  nifti_data_flair <- read_nifti1(paste(dir_nifti1, "FLAIR.nii.gz", sep = "/"), reorient = F)
  nifti_data_flair_regToT1 <- read_nifti1(paste(dir_nifti1, "FLAIR_regToT1.nii.gz", sep = "/"), reorient = F)
  nifti_data_roi <- read_nifti1(paste(dir_nifti1, "ROI.nii.gz", sep = "/"), reorient = F)
  nifti_data_roi_regToT1_SyNtoMNI <- read_nifti1(paste(dir_nifti1, "ROI_regToT1_SyNtoMNI.nii.gz", sep = "/"))
  nifti_data_t1 <- read_nifti1(paste(dir_nifti1, "T1.nii.gz", sep = "/"), reorient = F)
  nifti_data_t1_SyNtoMNI <- read_nifti1(paste(dir_nifti1, "T1_SyNtoMNI.nii.gz", sep = "/"))

  # https://github.com/muschellij2/Neurohacking_data/tree/master/Template
  nifti_data_JHU_MNI_SS_T1_brain <- read_nifti1(paste(dir_nifti1, "JHU_MNI_SS_T1_brain.nii.gz", sep = "/"))
  nifti_data_JHU_MNI_SS_T1_mask <- read_nifti1(paste(dir_nifti1, "JHU_MNI_SS_T1_mask.nii.gz", sep = "/"))
  nifti_data_MNI152_T1_1mm_brain <- read_nifti1(paste(dir_nifti1, "MNI152_T1_1mm_brain.nii.gz", sep = "/"))

  # https://github.com/muschellij2/Neurohacking_data/tree/master/kirby21/visit_2/113
  nifti_data_113_01_MPRAGE <- read_nifti1(paste(dir_nifti1, "113-01-MPRAGE.nii.gz", sep = "/"))
  nifti_data_113_01_MPRAGE_mask <- read_nifti1(paste(dir_nifti1, "113-01-MPRAGE_mask.nii.gz", sep = "/"))
  nifti_data_FLIRT_113_01_T2w_regToT1 <- read_nifti1(paste(dir_nifti1, "FLIRT_113-01-T2w_regToT1.nii.gz", sep = "/"))
}

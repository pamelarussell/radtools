
dir_nifti1 <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/nifti-1/"
dir_nifti2 <- "~/Dropbox/Documents/Radiogenomics/radiogenomics_r_package/sample_data/images/nifti-2/"

# avg152T1_LR
avg152T1_LR_hdr <- paste(dir_nifti1, "avg152T1_LR_nifti.hdr", sep = "/")
avg152T1_LR_img <- paste(dir_nifti1, "avg152T1_LR_nifti.img", sep = "/")
avg152T1_LR_nii <- paste(dir_nifti1, "avg152T1_LR_nifti.nii", sep = "/")
nifti_data_avg152T1_LR <- read_nifti1(avg152T1_LR_nii)

# avg152T1_RL
avg152T1_RL_hdr <- paste(dir_nifti1, "avg152T1_LR_nifti.hdr.gz", sep = "/")
avg152T1_RL_img <- paste(dir_nifti1, "avg152T1_LR_nifti.img.gz", sep = "/")
avg152T1_RL_nii <- paste(dir_nifti1, "avg152T1_LR_nifti.nii.gz", sep = "/")
nifti_data_avg152T1_RL <- read_nifti1(avg152T1_RL_nii)

# filtered_func_data
filtered_func <- paste(dir_nifti1, "filtered_func_data.nii.gz", sep = "/")
nifti_data_filtered_func <- read_nifti1(filtered_func)

# minimal data
minimal_hdr <- paste(dir_nifti1, "minimal.hdr.gz", sep = "/")
minimal_img <- paste(dir_nifti1, "minimal.img.gz", sep = "/")
minimal_nii <- paste(dir_nifti1, "minimal.nii.gz", sep = "/")
nifti_data_minimal <- read_nifti1(minimal_nii)

# zstat1
zstat1 <- paste(dir_nifti1, "zstat1.nii.gz", sep = "/")
nifti_data_zstat1 <- read_nifti1(zstat1)



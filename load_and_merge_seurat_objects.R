# -----------------------------------------------------------
# Script: load_and_merge_seurat_objects.R
# Author: Thouhid Islam
# Description: Load multiple 10X Genomics matrices and create
#              Seurat objects, then merge them into a single object
# -----------------------------------------------------------

# Load required libraries
library(Seurat)
library(tidyverse)

# Define the directory containing the datasets
data_dir <- "C:/Users/HP/Desktop/sre_test"

# List all sample folders
sample_dirs <- list.dirs(path = data_dir, recursive = FALSE, full.names = FALSE)

# Create an empty list to store Seurat objects
seurat_objects <- list()

# Loop through each directory and read 10X data
for (sample in sample_dirs) {
  
  # Clean sample name
  sample_name <- sub('_filtered_feature_bc_matrix', '', sample)
  
  # Read matrix files
  counts <- ReadMtx(
    mtx = file.path(data_dir, sample, "matrix.mtx.gz"),
    features = file.path(data_dir, sample, "features.tsv.gz"),
    cells = file.path(data_dir, sample, "barcodes.tsv.gz")
  )
  
  # Create Seurat object
  seurat_objects[[sample_name]] <- CreateSeuratObject(counts = counts)
  
  # Print progress
  cat("Loaded:", sample_name, "\n")
}

# Check loaded objects
ls()

# Merge all Seurat objects
merged_seurat <- merge(
  x = seurat_objects[[1]],
  y = seurat_objects[-1],
  add.cell.ids = names(seurat_objects),
  project = "HB"
)

# View merged object
merged_seurat

# Inspect metadata
View(merged_seurat@meta.data)
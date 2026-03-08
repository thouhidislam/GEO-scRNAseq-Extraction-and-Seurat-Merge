# GEO scRNA-seq Seurat Preprocessing Workflow

This repository provides a simple workflow for preprocessing GEO single-cell RNA sequencing (scRNA-seq) datasets. The pipeline demonstrates how to extract GEO archives and load the resulting 10X Genomics matrices into Seurat for downstream analysis.

## Dataset

Example dataset used:

GEO accession: **GSE180665**

Platform: NCBI Gene Expression Omnibus (GEO)

## Workflow

The workflow consists of two main stages:

1. Extract GEO compressed files using Windows PowerShell
2. Load the extracted matrices into R and merge them using Seurat

```
GEO dataset → Extract files → 10X matrices → Create Seurat objects → Merge datasets
```

## Step 1: Extract GEO Data

Run the PowerShell script:

```
scripts/extract_geo_data.ps1
```

Main commands used:

```
cd "C:\Users\HP\Downloads\scRNA"
tar -xvf GSE180665_RAW.tar
gci *.tar.gz | foreach { tar -xzf $_ }
gci *.tar | foreach { tar -xf $_ }
```

This step extracts the compressed GEO archive into individual sample folders.

## Step 2: Load and Merge Data in R

Run the R script:

```
scripts/load_merge_seurat.R
```

This script:

- Reads 10X Genomics matrices
- Creates Seurat objects
- Merges multiple samples into one object

## Requirements

R packages:

- Seurat
- tidyverse

Install packages:

```r
install.packages("Seurat")
install.packages("tidyverse")
```

## Output

The workflow produces a merged Seurat object containing cells from all samples, which can be used for:

- Quality control
- Normalization
- Dimensionality reduction
- Clustering
- Visualization

## Author

Thouhid Islam  
Bioinformatician | scRNA-seq analysis | R programming

## License

MIT License

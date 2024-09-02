#!/bin/bash
#SBATCH --job-name=miRDeep2-analysis
#SBATCH -p short
#SBATCH --mem 32G
#SBATCH -t 1-00:00:00
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=aitken.n@northeastern.edu

# Load necessary modules or environments
module load perl
module load miniconda3/23.5.2
source activate binf6310

# Define input and output directories
OUTPUT_DIR="../output"
COLLAPSED_DIR="$OUTPUT_DIR/collapsed"
MAPPED_DIR="$OUTPUT_DIR/mapped"
MIRDEEP2_OUTPUT_DIR="$OUTPUT_DIR/miRDeep2_results"

# Create output directory for miRDeep2 results if it doesn't exist
mkdir -p $MIRDEEP2_OUTPUT_DIR

# Define the path to the reference genome and annotation files
REFERENCE_GENOME="Rattus_norvegicus.mRatBN7.2.cdna.all.fa"
KNOWN_MIRNA="rno_mature.fa" # Replace with the actual file containing known mature miRNAs
PRECURSOR_MIRNA="rno_hairpin.fa" # Replace with the actual file containing precursor miRNAs

# Combine all mapped reads into a single file
COMBINED_MAPPED_READS="$MIRDEEP2_OUTPUT_DIR/combined_mapped_reads.arf"
cat $MAPPED_DIR/*.arf > $COMBINED_MAPPED_READS

# Check if required input files exist
if [[ ! -f "$REFERENCE_GENOME" || ! -f "$KNOWN_MIRNA" || ! -f "$PRECURSOR_MIRNA" ]]; then
    echo "Error: One or more required files do not exist. Please check the file paths."
    exit 1
fi

# Run miRDeep2 with the combined mapped reads
echo "Running miRDeep2..."
miRDeep2.pl "$COLLAPSED_DIR/*.fa" "$REFERENCE_GENOME" "$COMBINED_MAPPED_READS" "$KNOWN_MIRNA" none "$PRECURSOR_MIRNA" -t rat -z 1 -P -o $MIRDEEP2_OUTPUT_DIR

# Confirm completion of miRDeep2
if [ $? -eq 0 ]; then
    echo "miRDeep2 analysis completed successfully."
else
    echo "Error: miRDeep2 analysis encountered an issue."
fi

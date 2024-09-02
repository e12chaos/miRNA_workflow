#!/bin/bash
#SBATCH --job-name=binf-work        # Name of the job
#SBATCH -p short                    # Partition to submit to
#SBATCH --mem 16G                   # Memory allocation
#SBATCH -t 1-00:00:00               # Time limit (1 day)
#SBATCH -N 1                        # Number of nodes
#SBATCH -c 8                        # Number of CPU cores
#SBATCH --mail-type=END,FAIL        # Email notifications
#SBATCH --mail-user=aitken.n@northeastern.edu  # Email address

echo "RUNNING FASTQC"

# Define the input directory where the FASTQ files are located
INPUT_DIR="../P1432_trimmomatic_output"

# Define the output directory where the FastQC reports will be saved
OUTPUT_DIR="../P1432_trimmomatic_fastqc_reports"

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Loop through each gzipped FASTQ file in the input directory
for FILE in $INPUT_DIR/*.fastq.gz; do
    if [ -f "$FILE" ]; then
        echo "Running FastQC on $FILE..."
        fastqc -o $OUTPUT_DIR $FILE
    else
        echo "No FASTQ file found for $FILE"
    fi
done

# Generate a summary report using MultiQC
echo "Generating MultiQC report..."
multiqc -o $OUTPUT_DIR $OUTPUT_DIR

echo "FastQC analysis complete. Reports are saved in $OUTPUT_DIR."


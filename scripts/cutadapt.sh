#!/bin/bash
#SBATCH --job-name=cutadapt-work        # Name of the job
#SBATCH -p short                        # Partition to submit to
#SBATCH --mem 16G                       # Memory allocation
#SBATCH -t 1-00:00:00                   # Time limit (1 day)
#SBATCH -N 1                            # Number of nodes
#SBATCH -c 8                            # Number of CPU cores
#SBATCH --mail-type=END,FAIL            # Email notifications
#SBATCH --mail-user=aitken.n@northeastern.edu  # Email address

# Create an output log directory
LOG_DIR="slurm_logs"
mkdir -p $LOG_DIR

# Redirect output and error logs to files in the log directory
LOG_FILE="$LOG_DIR/%x_%j.out"
ERROR_FILE="$LOG_DIR/%x_%j.err"
exec > >(tee -a $LOG_FILE) 2> >(tee -a $ERROR_FILE >&2)

# Load Cutadapt module or environment (adjust if using a specific module system)
# module load cutadapt/3.4

# Define the input and output directories
INPUT_DIR="../P1432_fastqs"
OUTPUT_DIR="../P1432_cutadapt_results"
# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Adapter sequence to remove
ADAPTER_SEQ="AGATCGGAAG"

# Run Cutadapt on each FASTQ file
for FILE in $INPUT_DIR/*.fastq.gz; do
    if [ -f "$FILE" ]; then
        echo "Processing $FILE with Cutadapt..."
        BASENAME=$(basename "$FILE" .fastq.gz)
        OUTPUT_FILE="$OUTPUT_DIR/${BASENAME}_trimmed.fastq.gz"
        
        # Run Cutadapt to remove the adapter sequence
        cutadapt -a $ADAPTER_SEQ -o $OUTPUT_FILE $FILE
        
        echo "Trimmed file saved to $OUTPUT_FILE"
    else
        echo "No file found for $FILE"
    fi
done

echo "Cutadapt trimming complete. Results are saved in $OUTPUT_DIR."

#!/bin/bash
#SBATCH --job-name=trimmomatic     # Name of the job
#SBATCH -p short                   # Partition to submit to
#SBATCH --mem 16G                  # Memory allocation
#SBATCH -t 1-00:00:00              # Time limit (1 day)
#SBATCH -N 1                       # Number of nodes
#SBATCH -c 8                       # Number of CPU cores
#SBATCH --mail-type=END,FAIL       # Email notifications
#SBATCH --mail-user=aitken.n@northeastern.edu  # Email address

echo "RUNNING TRIMMOMATIC"

# Load Trimmomatic module if it's installed as a module
module load trimmomatic/0.39

# Define the input directory where the trimmed FASTQ files are located
INPUT_DIR="../P1432_cutadapt_results"

# Define the output directory where the Trimmomatic output will be saved
OUTPUT_DIR="../P1432_trimmomatic_output"

# Define the directory where adapter sequences are stored
ADAPTERS_DIR="adapters.fasta"  # Update with the actual path

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Loop through each FASTQ file in the input directory
for FILE in $INPUT_DIR/*.fastq.gz; do
    if [ -f "$FILE" ]; then
        # Define the output file name
        BASE=$(basename $FILE .fastq.gz)
        OUTPUT_FILE="$OUTPUT_DIR/${BASE}_trimmed.fastq.gz"
        UNPAIRED_OUTPUT_FILE="$OUTPUT_DIR/${BASE}_unpaired.fastq.gz"

        # Run Trimmomatic
        echo "Running Trimmomatic on $FILE..."
        trimmomatic SE -threads 8 \
            $FILE $OUTPUT_FILE \
            ILLUMINACLIP:$ADAPTERS_DIR/TruSeq3-SE.fa:2:30:10 \
            LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:18
    else
        echo "No FASTQ file found for $FILE"
    fi
done

echo "Trimmomatic analysis complete. Trimmed files are saved in $OUTPUT_DIR."

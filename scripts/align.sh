#!/bin/bash
#SBATCH --job-name=miRDeep2-mapping
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


# Define the path to the reference genome
REFERENCE_GENOME="Rattus_norvegicus.mRatBN7.2.cdna.all.fa"

# Index the reference genome using Bowtie
bowtie-build $REFERENCE_GENOME reference_genome_bowtie

# Index the reference genome using Bowtie2
bowtie2-2.5.4-linux-x86_64/bowtie2-build $REFERENCE_GENOME reference_genome_bowtie2

# Define input and output directories
INPUT_DIR="../P1432_fastq_unzipped"
OUTPUT_DIR="../output"
COLLAPSED_DIR="$OUTPUT_DIR/collapsed"
MAPPED_DIR="$OUTPUT_DIR/mapped"

# Create output directories if they don't exist
mkdir -p $COLLAPSED_DIR
mkdir -p $MAPPED_DIR

# Loop through each FastQ file in the input directory
for INPUT_FILE in $INPUT_DIR/*.fastq; do
    # Extract the sample name from the file name
    SAMPLE_NAME=$(basename "$INPUT_FILE" .fastq)

    echo "Processing $SAMPLE_NAME..."
    echo "Input file: $INPUT_FILE"

    # Check if the input file exists
    if [ ! -f "$INPUT_FILE" ]; then
        echo "Error: Input file $INPUT_FILE does not exist"
        continue
    fi

    # Print the exact command being executed
    echo "Executing command:"
    echo "/scratch/aitken.n/data/miRNA/scripts/mirdeep2/bin/mapper.pl $INPUT_FILE -e -j -m -h -p reference_genome_bowtie -s $COLLAPSED_DIR/${SAMPLE_NAME}_collapsed.fa -t $MAPPED_DIR/${SAMPLE_NAME}_mapped.arf"

    # Run the mapper.pl script using Bowtie 1
    /scratch/aitken.n/data/miRNA/scripts/mirdeep2/bin/mapper.pl "$INPUT_FILE" \
        -e -j -m -h \
        -p reference_genome_bowtie \
        -s "$COLLAPSED_DIR/${SAMPLE_NAME}_collapsed_bowtie1.fa" \
        -t "$MAPPED_DIR/${SAMPLE_NAME}_mapped_bowtie1.arf"

    echo "Completed processing $SAMPLE_NAME with Bowtie 1"

    # Run the mapper.pl script using Bowtie 2
    echo "Processing $SAMPLE_NAME with Bowtie 2..."
    /scratch/aitken.n/data/miRNA/scripts/mirdeep2/bin/mapper.pl "$INPUT_FILE" \
        -e -j -m -h \
        -p reference_genome_bowtie2 \
        -s "$COLLAPSED_DIR/${SAMPLE_NAME}_collapsed_bowtie2.fa" \
        -t "$MAPPED_DIR/${SAMPLE_NAME}_mapped_bowtie2.arf"

    echo "Completed processing $SAMPLE_NAME with Bowtie 2"
done

echo "All samples processed successfully."
